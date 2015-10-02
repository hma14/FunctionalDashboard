using FunctionalDashboard.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using FunctionalDashboard.Dal;
using FunctionalDashboard.Dal.DataEntity;
using PagedList;
using System.IO;
using FunctionalDashboard.ViewModels;
using System.Web.UI;
using System.Data.SqlClient;


namespace FunctionalDashboard.Controllers
{
    public class DetailedFilePpassController : BaseController
    {

        private static string InstitutionID { get; set; }
        private static string Uri { get; set; }
        private static IList<PpassFileDetail> RetrievedResult { get; set; }
        private static IList<PpassFileDetail> SearchResult { get; set; }
        public static string CurrentSearchKeyword { get; set; }
        private static string _sortOrder = string.Empty;
        private static DateTime DateStart { get; set; }

        public static int RetrievedResultPageNo { get; set; }
        public static int SearchResultPageNo { get; set; }
        public static int CategoryID { get; set; }
        public static int EventID { get; set; }
        public static string UniqueParticipantID { get; set; }
        public static long DateStartTicks { get; set; }

        public static int Page { get; set; }

        const int pageSize = 10;


        private void process(int? page,
                                  string institutionID,
                                  string uri,
                                  string uniqueParticipantID,
                                  long? dateStartTicks,
                                  int? categoryID,
                                  int? eventID,
                                  int? totalErrors)
        {
            if (dateStartTicks != null)
            {
                DateStartTicks = (long)dateStartTicks;
                DateStart = new DateTime((long)dateStartTicks);
                Session["ProcessTimeTicks"] = DateStartTicks;
            }
            else if (Session["ProcessTimeTicks"] != null)
            {
                DateStart = new DateTime((long)Session["ProcessTimeTicks"]);
            }

            if (!String.IsNullOrEmpty(institutionID))
            {
                InstitutionID = institutionID;
                Session["InstitutionID"] = InstitutionID;
            }
            else if (!String.IsNullOrEmpty((string)Session["InstitutionID"]))
            {
                InstitutionID = (string)Session["InstitutionID"];
            }

            if (!String.IsNullOrEmpty(uri))
            {
                Uri = uri;
                Session["Uri"] = uri;
            }
            

            if (uniqueParticipantID != null)
            {
                UniqueParticipantID = uniqueParticipantID;
                Session["UniqueParticipantID"] = uniqueParticipantID;
            }
            else if (!String.IsNullOrEmpty((string)Session["UniqueParticipantID"]))
            {
                UniqueParticipantID = (string)Session["UniqueParticipantID"];
            }

            if (categoryID != null)
            {
                CategoryID = (int)categoryID;
            }
            if (eventID != null)
            {
                EventID = (int)eventID;
            }
           

            // Get current Server from which EventLog is being monitored and display
            SetCurrentServer();

            // Get total memory used so far and set and display
            SetCurrentProcessMemorySize();

            if (page != null)
            {
                Page = (int)page;
            }
            if (Page == 0)
            {
                Page = 1;
            }
            RetrievedResultPageNo = Page;
            


            //string fileName = Path.GetFileName(Uri);
            if (Logs.GeneralLog == null || Logs.GeneralLog.Count() == 0)
            {
                Logs.GeneralLog = Logs.CreateGeneralEventLog();
            }

            NcsInfo ret = null;
            var entries = Logs.GeneralLog
                .Where(x => x.InstitutionID == InstitutionID &&
                            x.ProgramID != PROGRAM_ID.UPASS &&
                            x.Environment.ToUpper() == HomeController.CurrentEnvironment.ToUpper() &&
                            (!String.IsNullOrEmpty(x.URI) ? x.URI == Uri : (x.EventID == EventID && x.ProcessDatetime.Ticks == DateStartTicks)) &&
                            x.URIType == "sFTP")
                .GroupBy(x => new { x.RequestTxID, x.EventID, x.ProcessDatetime })
                .Select(g => new PpassFileDetail
                {
                    ID = g.First().ID,
                    ProgramID = g.First().ProgramID,
                    Institution = (ret = Logs.GetNCSInfo(InstitutionID)) != null ? ret.Name : null,
                    InstitutionID = InstitutionID,
                    RequestTxID = g.Key.RequestTxID,
                    Category = g.First().Category,
                    CategoryID = g.First().CategoryID,
                    Event = g.First().Event,
                    EventID = g.Key.EventID,
                    UniqueParticipantId = g.First().UniqueParticipantId,
                    Action = g.First().Action,
                    ReasonCode = g.First().ReasonCode,
                    CardSerialNumber = g.First().CardSerialNumber,
                    URI = g.First().URI,
                    ProcessDatetime = g.Key.ProcessDatetime,
                    ProcessErrorDescr = g.First().ProcessErrorDescr,
                    ProcessErrorID = g.First().ProcessErrorID,
                    Errors = g.Where(e => e.Level == EVENT_STATUS.ERROR).Count(),
                    ClearedErrors = g.Where(c => c.Level == EVENT_STATUS.CLEARED).Count(),
                    Acknowledged = g.Where(a => a.Level == EVENT_STATUS.ACKNOWLEDGED).Count(),
                    CurrentClicked = g.First().CurrentClicked,
                });

            entries = entries.OrderByDescending(x => x.Errors > 0 ? x.Errors : (x.Acknowledged > 0 ? x.Acknowledged : x.ClearedErrors));
            RetrievedResult = entries.ToList();

            
            if (entries != null)
            {
                ViewBag.RetrievedResult = entries.ToPagedList(RetrievedResultPageNo, pageSize);
            }
            SetViewBags();

            // Clear previous static data if it holds
            SearchResult = null;   
        }
        
        public ActionResult Index(int? page, 
                                  string institutionID, 
                                  string uri,
                                  string uniqueParticipantID,
                                  long? dateStartTicks, 
                                  int? categoryID,
                                  int? eventID,
                                  int? totalErrors)
        {
            process(page, institutionID, uri, uniqueParticipantID, dateStartTicks, categoryID, eventID, totalErrors);
            return View();            
        }


        public PartialViewResult UpdateRetrievedResult(int? page, string sortOrder, string institutionID, string uri, DateTime? dateStart, int? totalErrors)
        {
            ViewBag.Status = Logs.CurrentEnvironment;
            if (page != null)
            {
                Page = (int)page;
            }
            if (!String.IsNullOrEmpty(sortOrder))
            {
                _sortOrder = sortOrder;
            }
            if (dateStart.HasValue)
            {
                DateStart =(DateTime) dateStart;
            }
            ViewBag.CurrentSortOrder = _sortOrder;
            RetrievedResultPageNo = (page ?? 1);

            if (Logs.GeneralLog == null)
            {
                Logs.GeneralLog = Logs.CreateGeneralEventLog();
            }

            if (!String.IsNullOrEmpty(institutionID))
            {
                InstitutionID = institutionID;
            }
            if (!String.IsNullOrEmpty(uri))
            {
                Uri = uri;
            }

            SetViewBags();

            var entries = RetrievedResult;
            var ents = from entry in entries
                       select entry;
            if (page == null)
            {
                ViewBag.DateTimeStartSortParm = _sortOrder == "DateTimeStart" ? "DateTimeStart_desc" : "DateTimeStart";
                ViewBag.EventSortParm = _sortOrder == "Event" ? "Event_desc" : "Event";
                ViewBag.RequestTxIDSortParm = _sortOrder == "RequestTxID" ? "RequestTxID_desc" : "RequestTxID";
                ViewBag.UniqueParticipantIDSortParm = _sortOrder == "UniqueParticipantID" ? "UniqueParticipantID_desc" : "UniqueParticipantID";
                ViewBag.ActionSortParm = _sortOrder == "Action" ? "Action_desc" : "Action";
                ViewBag.ReasonSortParm = _sortOrder == "Reason" ? "Reason_desc" : "Reason";
                ViewBag.CardSerialNumberSortParm = _sortOrder == "CardSerialNumber" ? "CardSerialNumber_desc" : "CardSerialNumber";
                ViewBag.RequestStatusSortParm = _sortOrder == "RequestStatus" ? "RequestStatus_desc" : "RequestStatus";

                switch (_sortOrder)
                {
                    case "DateTimeStart":
                        ents = ents.OrderBy(s => s.ProcessDatetime);
                        break;
                    case "Event_desc":
                        ents = ents.OrderByDescending(s => s.EventID);
                        break;
                    case "Event":
                        ents = ents.OrderBy(s => s.EventID);
                        break;
                    case "RequestTxID_desc":
                        ents = ents.OrderByDescending(s => s.RequestTxID);
                        break;
                    case "RequestTxID":
                        ents = ents.OrderBy(s => s.RequestTxID);
                        break;
                    case "UniqueParticipantID_desc":
                        ents = ents.OrderByDescending(s => s.UniqueParticipantId);
                        break;
                    case "UniqueParticipantID":
                        ents = ents.OrderBy(s => s.UniqueParticipantId);
                        break;
                    case "Action_desc":
                        ents = ents.OrderByDescending(s => s.Action);
                        break;
                    case "Action":
                        ents = ents.OrderBy(s => s.Action);
                        break;
                    case "Reason_desc":
                        ents = ents.OrderByDescending(s => s.ReasonCode);
                        break;
                    case "Reason":
                        ents = ents.OrderBy(s => s.ReasonCode);
                        break;
                    case "CardSerialNumber_desc":
                        ents = ents.OrderByDescending(s => s.CardSerialNumber);
                        break;
                    case "CardSerialNumber":
                        ents = ents.OrderBy(s => s.CardSerialNumber);
                        break;
                    case "RequestStatus_desc":
                        ents = ents.OrderByDescending(s => s.Errors > 0 ? s.Errors : (s.ClearedErrors > 0 ? s.ClearedErrors : s.Acknowledged));
                        break;
                    case "RequestStatus":
                        ents = ents.OrderBy(s => s.Errors > 0 ? s.Errors : (s.ClearedErrors > 0 ? s.ClearedErrors : s.Acknowledged));
                        break;

                    default:
                        ents = ents.OrderByDescending(s => s.ProcessDatetime);
                        break;
                }
            }
            ViewBag.RetrievedResult = ents.ToPagedList(RetrievedResultPageNo, pageSize);
            if (SearchResult != null && SearchResult.Count() > 0)
            {
                ViewBag.SearchResult = SearchResult.ToPagedList(SearchResultPageNo, pageSize);
            }
            ViewBag.keyword = CurrentSearchKeyword;

            return PartialView("_FileDetails", null);

        }

        public PartialViewResult UpdateSearchResult(int? page, string sortOrder)
        {
            if (!String.IsNullOrEmpty(sortOrder))
            {
                _sortOrder = sortOrder;
            }
            
            ViewBag.CurrentSortOrder = _sortOrder;
          
            ViewBag.NCSInfo = Logs.GetNCSInfo(InstitutionID);
            ViewBag.FileName = Path.GetFileName(Uri);
            ViewBag.DirectoryName = Path.GetDirectoryName(Uri);
            ViewBag.DateStart = DateStart;
            ViewBag.TotalErrors = RetrievedResult.Sum(e => e.Errors);
            ViewBag.TotalClearedErrors = RetrievedResult.Sum(e => e.ClearedErrors);
            ViewBag.TotalAcknowledged = RetrievedResult.Sum(e => e.Acknowledged);


            var ents = from entry in SearchResult
                       select entry;
            if (page == null)
            {
                ViewBag.RequestTxIDSortParm = _sortOrder == "RequestTxID" ? "RequestTxID_desc" : "RequestTxID";
                ViewBag.UniqueParticipantIDSortParm = _sortOrder == "UniqueParticipantID" ? "UniqueParticipantID_desc" : "UniqueParticipantID";
                ViewBag.ActionSortParm = _sortOrder == "Action" ? "Action_desc" : "Action";
                ViewBag.ReasonSortParm = _sortOrder == "Reason" ? "Reason_desc" : "Reason";
                ViewBag.CardSerialNumberSortParm = _sortOrder == "CardSerialNumber" ? "CardSerialNumber_desc" : "CardSerialNumber";
                ViewBag.RequestStatusSortParm = _sortOrder == "RequestStatus" ? "RequestStatus_desc" : "RequestStatus";

                switch (_sortOrder)
                {
                    case "RequestTxID_desc":
                        ents = ents.OrderByDescending(s => s.RequestTxID);
                        break;
                    case "UniqueParticipantID_desc":
                        ents = ents.OrderByDescending(s => s.UniqueParticipantId);
                        break;
                    case "UniqueParticipantID":
                        ents = ents.OrderBy(s => s.UniqueParticipantId);
                        break;
                    case "Action_desc":
                        ents = ents.OrderByDescending(s => s.CardTypeCode);
                        break;
                    case "Action":
                        ents = ents.OrderBy(s => s.URIType);
                        break;
                    case "Reason_desc":
                        ents = ents.OrderByDescending(s => s.URIType);
                        break;
                    case "Reason":
                        ents = ents.OrderBy(s => s.ReasonCode);
                        break;
                    case "CardSerialNumber_desc":
                        ents = ents.OrderByDescending(s => s.CardSerialNumber);
                        break;
                    case "CardSerialNumber":
                        ents = ents.OrderBy(s => s.CardSerialNumber);
                        break;
                    case "RequestStatus_desc":
                        ents = ents.OrderByDescending(s => s.Errors > 0 ? s.Errors : (s.ClearedErrors > 0 ? s.ClearedErrors : s.Acknowledged));
                        break;
                    case "RequestStatus":
                        ents = ents.OrderBy(s => s.Errors > 0 ? s.Errors : (s.ClearedErrors > 0 ? s.ClearedErrors : s.Acknowledged));
                        break;

                    default:
                        ents = ents.OrderBy(s => s.RequestTxID);
                        break;
                }
            }

            SearchResultPageNo = (page ?? 1);

            SearchResult = ents.ToList();
            ViewBag.SearchResult = ents.ToPagedList(SearchResultPageNo, pageSize);
            ViewBag.RetrievedResult = RetrievedResult.ToPagedList(RetrievedResultPageNo, pageSize);
            ViewBag.keyword = CurrentSearchKeyword;
            return PartialView("_FileDetails", null);

        }

        public PartialViewResult SearchRequestTxID(int? page, bool? refresh, string requestTxID)
        {                      
            if (!String.IsNullOrEmpty(requestTxID))
            {
                process(page, InstitutionID, Uri, UniqueParticipantID, DateStartTicks, CategoryID, EventID, null);
                SearchResult = RetrievedResult.Where(s => s.RequestTxID != null && s.RequestTxID.ToUpper().Contains(requestTxID.Trim().ToUpper())).ToList();
            }
            else
            {
                SearchResult = null;
            }

            SetViewBags();
            CurrentSearchKeyword = " Request Transaction ID contains '" + requestTxID + "'";
            ViewBag.keyword = CurrentSearchKeyword;
            return PartialView("_FileDetails", null);
        }

        public PartialViewResult SearchUniqueParticipantID(int? page, bool? refresh, string uniqueParticipantID)
        {
            if (!String.IsNullOrEmpty(uniqueParticipantID))
            {
                process(page, InstitutionID, Uri, UniqueParticipantID, DateStartTicks, CategoryID, EventID, null);
                SearchResult = RetrievedResult.Where(s => s.UniqueParticipantId != null && s.UniqueParticipantId.ToUpper().Contains(uniqueParticipantID.Trim().ToUpper())).ToList();
            }
            else
            {
                SearchResult = null;
            }

            SetViewBags();
            CurrentSearchKeyword = " Unique Participant ID contains '" + uniqueParticipantID + "'";
            ViewBag.keyword = CurrentSearchKeyword;
            return PartialView("_FileDetails", null);
        }

        public PartialViewResult SearchCSN(int? page, bool? refresh, string CSN)
        {
            if (!String.IsNullOrEmpty(CSN))
            {
                process(page, InstitutionID, Uri, UniqueParticipantID, DateStartTicks, CategoryID, EventID, null);
                SearchResult = RetrievedResult.Where(s => s.CardSerialNumber != null && s.CardSerialNumber.ToUpper().Contains(CSN.Trim().ToUpper())).ToList();
            }
            else
            {
                SearchResult = null;
            }

            SetViewBags();
            CurrentSearchKeyword = " Card Serial Number contains '" + CSN + "'";
            ViewBag.keyword = CurrentSearchKeyword;

            return PartialView("_FileDetails", null);
        }

        private void SetViewBags()
        {
            ViewBag.NCSInfo = Logs.GetNCSInfo(InstitutionID);
            ViewBag.FileName = Path.GetFileName(Uri);
            ViewBag.DirectoryName = Path.GetDirectoryName(Uri);
            ViewBag.DateStart = DateStart;
            

            RetrievedResultPageNo = Page;
            SearchResultPageNo = Page;
            if (SearchResult != null)
            {
                ViewBag.TotalErrors = SearchResult.Sum(e => e.Errors);
                ViewBag.TotalClearedErrors = SearchResult.Sum(e => e.ClearedErrors);
                ViewBag.TotalAcknowledged = SearchResult.Sum(e => e.Acknowledged);
                ViewBag.SearchResult = SearchResult.ToPagedList(SearchResultPageNo, pageSize);
            }
            else if (RetrievedResult != null)
            {
                ViewBag.TotalErrors = RetrievedResult.Sum(e => e.Errors);
                ViewBag.TotalClearedErrors = RetrievedResult.Sum(e => e.ClearedErrors);
                ViewBag.TotalAcknowledged = RetrievedResult.Sum(e => e.Acknowledged);
                ViewBag.RetrievedResult = RetrievedResult.ToPagedList(RetrievedResultPageNo, pageSize);
            }
            
        }
  
        #region JavaScript call back functions
        public ActionResult FileDetailsUpdateErrorListStatus(string programID, string institutionID, int cate, int evt, long processDatetimeTicks, int status, long ID)
        {           
            try
            {
                DataAccess da = new DataAccess();
                da.SpUpdateErrorList(evt, cate, processDatetimeTicks, status, User.Identity.Name, programID, institutionID);
                Logs.GeneralLog = Logs.UpdateGeneralEventLogLevel(Logs.GeneralLog, cate, evt, processDatetimeTicks, status, programID, institutionID);
                //Logs.GeneralLog = Logs.UpdateGeneralEventLogLevel(Logs.GeneralLog);
                Logs.GeneralLog = Logs.SetCurrentClickedRow(Logs.GeneralLog, ID);
            }
            catch (SqlException ex)
            {
                ViewBag.ErrorMsg = ex.Message;
                return PartialView("_Error", null);
            }

            process(Page, institutionID, Uri, UniqueParticipantID, processDatetimeTicks, cate, evt, null);

            return PartialView("_FileDetails", null);
        }

        #endregion
    }
}
