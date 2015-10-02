using System.Web.UI.WebControls;
using FunctionalDashboard.ViewModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.SqlClient;
using FunctionalDashboard.Controllers;
using System.Xml.Linq;
using System.Diagnostics;
using System.Text.RegularExpressions;
using System.Web.Configuration;
using System.Data;
using System.Security.Principal;
using System.Security.Claims;
using System.IO;
using FunctionalDashboard.Bal;
using FunctionalDashboard.Dal;
using FunctionalDashboard.Dal.DataEntity;
using NLog;
using NLog.Fluent;

namespace FunctionalDashboard.Models
{
    public class Logs
    {
        public static DateTime LastRefreshed = DateTime.Now;
        public static string CurrentEnvironment = string.Empty;
        public static long MemorySize = 0;
        

        public static IList<GeneralEventLog> GeneralLog { get; set; }

        //public static IList<EventLog> EventLogs { get; set; }

        //public static IList<NCSInfo> NCSInfoList { get; set; }

        public static DateTime StartDate { get; set; }
        public static DateTime EndDate { get; set; }

        public static string Exception = string.Empty;

        public static int DropDwonListLength = int.Parse(WebConfigurationManager.AppSettings["DropDwonListLength"]);

        private static EventLogDataAccess _context = new EventLogDataAccess();

        private static Logger Logging = LogManager.GetCurrentClassLogger();

        public static NcsInfo GetNCSInfo(string institutionId)
        {
            Logging.Info("GetNCSInfo: institutionID=" + institutionId);

            if (string.IsNullOrEmpty(institutionId)) return null;

            institutionId = institutionId.ToUpper();

            NcsInfo info = (NcsInfo)DataCache.GetCachedObject(Constants.Key_NcsInfo + institutionId);
            if (info == null)
            {
                Logging.Error("GetNCSInfo: can't find institutionID=" + institutionId);
                throw new Exception("Can't find Institution: " + institutionId);

                //RefreshCachedNcsInfo();
                //info = (NcsInfo)DataCache.GetCachedObject(Constants.Key_NcsInfo + institutionId);
                //if (info == null)
                //{
                //    Logging.Error("GetNCSInfo: can't find institutionID=" + institutionId);
                //    throw new Exception("Can't find Institution: " + institutionId);
                //}
            }
            
            return info;
        }

        /// <summary>
        /// Refresh or create cached NCS info object
        /// </summary>
        public static void RefreshCachedNcsInfo()
        {
            var ncsInfo = _context.RetrieveNcsInfo();
            foreach (var n in ncsInfo)
            {
                DataCache.SetCachedObjectPermanent(Constants.Key_NcsInfo + n.InstitutionId.ToUpper(), n);
            }

        }

        /// <summary>
        /// jtang: return process error and stack trace if any
        /// </summary>
        /// <param name="eventLogId"></param>
        /// <returns>null or text of process error</returns>
        public static EventLogDetail RetrieveEventProcessError(long eventLogId)
        {
            Logging.Info("RetrieveEventProcessError: logId=" + eventLogId + " => starts");
            var err = (EventLogDetail)DataCache.GetCachedObject(Constants.Key_ErrorDesc + eventLogId);
            if (err != null) return err;

            var errs = _context.RetrieveTLEventLogErrorDetail(eventLogId).ToList();
            if (errs.Count <= 0) return null;
                
            err = errs[0];
            DataCache.SetCachedObjectSliding(Constants.Key_ErrorDesc + eventLogId, err, 3600);

            Logging.Info("RetrieveEventProcessError: logId=" + eventLogId + " => ends");

            return err;
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="startDateTimeUtc">start datetime in UTC </param>
        /// <param name="endDateTimeUtc">end datetime in UTC</param>
        /// <returns></returns>
        private static IList<GeneralEventLog> RetriveGeneralEventLogFromDb(DateTime startDateTimeUtc, DateTime endDateTimeUtc)
        {
            Logging.Info("RetriveGeneralEventLogFromDb: StartDate=" + startDateTimeUtc + ", EndDate=" + endDateTimeUtc + " => Starts");

            var context = new EventLogDataAccess();
            var logList = context.RetrieveGeneralEventLog(startDateTimeUtc, endDateTimeUtc).ToList();

            Logging.Info("RetriveGeneralEventLogFromDb: StartDate=" + startDateTimeUtc + ", EndDate=" + endDateTimeUtc + " => Ends, count=" + logList.Count);

            return logList;
           
        }

        public static IList<GeneralEventLog> CreateGeneralEventLog()
        {
            
            // Get GeneralEventLog from Cache first
            var log = (IList<GeneralEventLog>)DataCache.GetCachedObject(Constants.Key_GeneralEventLog);
            if (log != null && log.Count > 0)
            {
                Logging.Info("CreateGeneralEventLog: return " + log.Count + " cached log entries");
                return log;
            }

            Logging.Info("CreateGeneralEventLog: call GenerateGeneralEventLog(" + StartDate + ")");
            return RetriveGeneralEventLog(StartDate);
        }

        public static List<CPGFD_ErrorList> GenerateErrorList()
        {
            try
            {
                DataAccess da = new DataAccess();
                DataTable dt = da.SpRetrieveErrorListRecords();
                List<CPGFD_ErrorList> ErrorList = new List<CPGFD_ErrorList>();
                foreach (DataRow dr in dt.Rows)
                {
                    CPGFD_ErrorList el = new CPGFD_ErrorList();
                    el.ProgramID = (dr["ProgramID"] != DBNull.Value) ? (string)dr["ProgramID"] : null;
                    el.InstitutionID = (dr["InstitutionID"] != DBNull.Value) ? (string)dr["InstitutionID"] : null;
                    el.EventID = (int)dr["EventID"];
                    el.CategoryID = (int)dr["CategoryID"];
                    el.ProcessDatetime = (long)dr["ProcessDatetime"];
                    el.UpdatedBy = (string)dr["UpdatedBy"];
                    el.Status = (int)dr["Status"];
                    el.UpdatedDatetime = (DateTime)dr["UpdatedDatetime"];
                    ErrorList.Add(el);
                }
                return ErrorList;
            }
            catch (SqlException ex)
            {
                throw ex;
            }
        }

        public static List<CPGFD_ErrorException> RetrieveErrorExceptions()
        {
            DataAccess da;
            try
            {
                da = new DataAccess();
            }
            catch (SqlException ex)
            {
                throw ex;
            }
            DataTable dt = da.SpRetrieveErrorExceptions();
            var lst = (from x in dt.AsEnumerable()
                       select new CPGFD_ErrorException()
                       {
                           EventID = int.Parse(x[0].ToString()),
                           CategoryID = int.Parse(x[1].ToString()),
                           Status = int.Parse(x[2].ToString()),
                       }).ToList();
            return lst;

        }

        

        public static IList<GeneralEventLog> SetCurrentClickedRow(IList<GeneralEventLog> log, long ID)
        {
            foreach (var l in log)
            {
                l.CurrentClicked = 0;
                if (l.ID == ID)
                {
                    l.CurrentClicked = 1;
                }
            }
            return log;
        }


        private static IList<GeneralEventLog> UpdateLogLevel(List<CPGFD_ErrorList> errorList, List<CPGFD_ErrorException> exceptionList, IList<GeneralEventLog> log)
        {
            foreach (var l in log)
            {
                if (l.Level != EVENT_STATUS.COMPLETED)
                {
                    if (errorList.Find(x => (x.ProgramID != null && x.ProgramID == l.ProgramID &&
                                       x.InstitutionID != null && x.InstitutionID == l.InstitutionID ||
                                       x.ProgramID == null && x.InstitutionID == null) &&
                                       x.EventID == l.EventID &&
                                       x.CategoryID == l.CategoryID &&
                                       x.ProcessDatetime >= l.ProcessDatetime.Ticks &&
                                       x.Status == (int)STATUS.CLEARED) != null)
                    {
                        l.Level = EVENT_STATUS.CLEARED;
                    }
                    else if (errorList.Find(x => (x.ProgramID != null && x.ProgramID == l.ProgramID &&
                                            x.InstitutionID != null && x.InstitutionID == l.InstitutionID ||
                                            x.ProgramID == null && x.InstitutionID == null) &&
                                            x.EventID == l.EventID &&
                                            x.CategoryID == l.CategoryID &&
                                            x.ProcessDatetime >= l.ProcessDatetime.Ticks &&
                                            x.Status == (int)STATUS.ERROR) != null)
                    {
                        l.Level = EVENT_STATUS.ERROR;
                    }
                    else if (errorList.Find(x => (x.ProgramID != null && x.ProgramID == l.ProgramID &&
                                            x.InstitutionID != null && x.InstitutionID == l.InstitutionID ||
                                            x.ProgramID == null && x.InstitutionID == null) &&
                                            x.EventID == l.EventID &&
                                            x.CategoryID == l.CategoryID &&
                                            x.ProcessDatetime >= l.ProcessDatetime.Ticks &&
                                            x.Status == (int)STATUS.ACK) != null)
                    {
                        l.Level = EVENT_STATUS.ACKNOWLEDGED;
                    }
                    

                    // check if it is real error e.g. eventID = 1026 is not error, change Level to Information
                    if (exceptionList.Find(x => x.EventID == l.EventID && x.CategoryID == l.CategoryID && x.Status == (int)STATUS.CLEARED) != null)
                    {
                        l.Level = EVENT_STATUS.COMPLETED;
                    }
                }
            }
            return log;
        }

        public static IList<GeneralEventLog> UpdateGeneralEventLogLevel(IList<GeneralEventLog> log)
        {
            // Update log level = Cleared if eventid and categoryid found in the CPGFD_ErrorList table, 
            // Also check if an error is false one based on eventid and categoryid found in CPGFD_ErrorExceptions table
            //
            var ErrorList = GenerateErrorList();
            var ErrorExceptionList = RetrieveErrorExceptions();
            return UpdateLogLevel(ErrorList, ErrorExceptionList, log);
        }

        public static IList<GeneralEventLog> UpdateGeneralEventLogLevel(IList<GeneralEventLog> log, int cateID, int eventID, long dateTimeTikcs, int status, 
                                                                        string programID = null, string institutionID = null)
        {
            var ErrorExceptionList = RetrieveErrorExceptions();
            foreach (var l in log)
            {
                if (l.Level != EVENT_STATUS.COMPLETED)
                {
                    if ((l.ProgramID != null && l.ProgramID == programID || l.ProgramID == null) &&
                        (l.InstitutionID != null && l.InstitutionID == institutionID || l.InstitutionID == null) &&
                        l.EventID == eventID &&
                        l.CategoryID == cateID &&
                        l.ProcessDatetime.Ticks <= dateTimeTikcs &&
                        status == (int)STATUS.CLEARED)
                    {
                        l.Level = EVENT_STATUS.CLEARED;
                    }
                    else if ((l.ProgramID != null && l.ProgramID == programID || l.ProgramID == null) &&
                        (l.InstitutionID != null && l.InstitutionID == institutionID || l.InstitutionID == null) &&
                        l.EventID == eventID &&
                        l.CategoryID == cateID &&
                        l.ProcessDatetime.Ticks <= dateTimeTikcs &&
                        status == (int)STATUS.ACK)
                    {
                        l.Level = EVENT_STATUS.ACKNOWLEDGED;
                    }
                    else if ((l.ProgramID != null && l.ProgramID == programID || l.ProgramID == null) &&
                        (l.InstitutionID != null && l.InstitutionID == institutionID || l.InstitutionID == null) &&
                        l.EventID == eventID &&
                        l.CategoryID == cateID &&
                        l.ProcessDatetime.Ticks <= dateTimeTikcs &&
                        status == (int)STATUS.ERROR)
                    {
                        l.Level = EVENT_STATUS.ERROR;
                    }

                    // check if it is real error e.g. eventID = 1026 is not error, change Level to Information
                    if (ErrorExceptionList.Find(x => x.EventID == l.EventID && x.CategoryID == l.CategoryID && x.Status == (int)STATUS.CLEARED) != null)
                    {
                        l.Level = EVENT_STATUS.COMPLETED;
                    }
                }                
            }
            return log;
        }

#if false
        public static IList<GeneralEventLog> UpdateGeneralEventLogLevel(IList<GeneralEventLog> log, long ID, int status)
        {
            var ErrorExceptionList = RetrieveErrorExceptions();
            foreach (var l in log)
            {
                if (l.Level != EVENT_STATUS.COMPLETED && l.ID == ID)
                {
                    if (status == (int)STATUS.CLEARED)
                    {
                        l.Level = EVENT_STATUS.CLEARED;
                    }
                    else if (status == (int)STATUS.ACK)
                    {
                        l.Level = EVENT_STATUS.ACKNOWLEDGED;
                    }
                    else if (status == (int)STATUS.ERROR)
                    {
                        l.Level = EVENT_STATUS.ERROR;
                    }

                    // check if it is real error e.g. eventID = 1026 is not error, change Level to Information
                    if (ErrorExceptionList.Find(x => x.EventID == l.EventID && x.CategoryID == l.CategoryID && x.Status == (int)STATUS.CLEARED) != null)
                    {
                        l.Level = EVENT_STATUS.COMPLETED;
                    }
                }
            }
            return log;
        }

#endif

        /// <summary>
        /// Retrieve General EventLog
        /// 
        /// <remarks>this is an revised version of GenerateGeneralEventLog((DateTime startDate, DateTime? endDate = null, bool? isRefresh = false) </remarks>
        /// </summary>
        /// <param name="startDate"></param>
        /// <param name="endDate"></param>
        /// <param name="isRefresh"></param>
        /// <returns></returns>
        public static IList<GeneralEventLog> RetriveGeneralEventLog(DateTime startDate, DateTime? endDate = null, bool isRefresh = false)
        {
            var regex = new Regex(@"\.xml\.xml$|\.asc$|\.pgp$|\.zip\.xml$", RegexOptions.IgnoreCase);

            var dtEndUtc = endDate.HasValue ? endDate.Value.ToUniversalTime() : DateTime.UtcNow;
            var dtStartUtc = startDate.ToUniversalTime();
            var logText = "RetriveGeneralEventLog: StartDate=" + dtStartUtc + ", EndDate=" + dtEndUtc + ", Refresh=" + (isRefresh ? "true" : "false");
            Logging.Info(logText);

            BaseController.LoadStarted = DateTime.Now;
            // GeneralEventLog has not been cached, go get from Database
            IList<GeneralEventLog> log = GeneralLog;
            try
            {
                if (isRefresh || GeneralLog == null || GeneralLog.Count == 0 || startDate < StartDate)
                {

                    log = RetriveGeneralEventLogFromDb(dtStartUtc, dtEndUtc);
                    
                    // special rules for URI, according to Henry and Andy
                    foreach (var l in log.Where(l => !String.IsNullOrEmpty(l.URI) && l.URIType.ToUpper() != "NOURI"))
                    {
                        if (regex.Match(l.URI).Success)
                        {
                            //gel.URI = f.First().URI.Substring(0, f.First().URI.Length - 4).ToUpper();
                            l.URI = l.URI.Substring(0, l.URI.Length - 4);
                        }


                        if (l.URIType == "sFTP")
                        {
                            string fname = Path.GetFileName(l.URI);

                            if (!string.IsNullOrEmpty(fname) && fname.Contains("."))
                            {
                                l.FileName = fname;
                            }

                        }
                        else
                        {
                            l.FileName = null;
                        }
                    }

                }
                else
                {
                    log = GeneralLog;
                }                              
            }
            catch (SqlException sqlex)
            {
                Exception = sqlex.Message;
                Logging.Error("RetriveGeneralEventLog: " + Exception);
                return new List<GeneralEventLog>();
            }

            var log2 = UpdateGeneralEventLogLevel(log);

            BaseController.LoadCompleted = DateTime.Now;

            return log2;
        }

        private static void ClearLogs()
        {
            if (GeneralLog != null)
            {
                GeneralLog.Clear();
            }
        }

        public static void RefreshGeneralEventLogs(DateTime startDate)
        {
            Logging.Info("RefreshGeneralEventLogs: StartDate=" + startDate);

            ClearLogs();
            StartDate = startDate;
            DateTime dtEnd = DateTime.Now;

            var logs = RetriveGeneralEventLog(StartDate, dtEnd);
            if (logs != null && logs.Count > 0)
            {
                Logging.Info("RefreshGeneralEventLogs: StartDate=" + startDate + ", cached " + logs.Count + " log entries.");
                DataCache.SetCachedObjectPermanent(Constants.Key_GeneralEventLog, logs);
                GeneralLog = logs;
                LastRefreshed = dtEnd;
            }
        }

        /// <summary>
        /// jtang: return sync utility log detail
        /// </summary>
        /// <param name="eventLogId">log id</param>
        /// <returns>null or log detailr</returns>
        public static SyncUtilityEventLog RetrieveSyncUtilityEventLog(long eventLogId)
        {
            Logging.Info("RetrieveSyncUtilityEventLog: logId=" + eventLogId + " => starts");
            var err = (SyncUtilityEventLog)DataCache.GetCachedObject(Constants.Key_SyncUtil + eventLogId);
            if (err != null) return err;

            err = _context.RetrieveSyncUtilityDetail(eventLogId).FirstOrDefault();

            DataCache.SetCachedObjectSliding(Constants.Key_SyncUtil + eventLogId, err, 3600);

            Logging.Info("RetrieveSyncUtilityEventLog: logId=" + eventLogId + " => ends");

            return err;
        }
        /// <summary>
        /// hema: return HHU log detail
        /// </summary>
        /// <param name="eventLogId">log id</param>
        /// <returns>log detail or null</returns>
        public static HHUEventLog RetrieveHHUEventLog(long eventLogId)
        {
            Logging.Info("HHUEventLog: logId=" + eventLogId + " => starts");
            var err = (HHUEventLog)DataCache.GetCachedObject(Constants.Key_HHU + eventLogId);
            if (err != null) return err;

            err = _context.RetrieveHHUDetail(eventLogId).FirstOrDefault();

            DataCache.SetCachedObjectSliding(Constants.Key_HHU + eventLogId, err, 3600);

            Logging.Info("RetrieveHHUEventLog: logId=" + eventLogId + " => ends");

            return err;
        }

        /// <summary>
        /// hema: return HHU log detail
        /// </summary>
        /// <param name="eventLogId">log id</param>
        /// <returns>log detail or null</returns>
        public static IList<HHUEventLog> RetrieveHHUEventLog()
        {
            Logging.Info("HHUEventLog: => starts");
            var log = (IList<HHUEventLog>) DataCache.GetCachedObject(Constants.Key_HHU + "All");
            if (log != null && log.Any()) return log;

            log = _context.RetrieveHHUDetail().ToList();
           
            DataCache.SetCachedObjectSliding(Constants.Key_HHU + "All", log, 3600);

            Logging.Info("RetrieveHHUEventLog:  => ends");

            return log;
        }
    }
}