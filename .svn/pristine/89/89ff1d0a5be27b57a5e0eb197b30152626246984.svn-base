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
using System.Data.SqlClient;

namespace FunctionalDashboard.Controllers
{
    public class DetailedFileUpassController : BaseController
    {

        private static string InstitutionID { get; set; }
        private static string Uri { get; set; }
        private static IList<UpassFileDetail> RetrievedResult { get; set; }
        private static IList<UpassFileDetail> SearchResult { get; set; }
        public static string CurrentSearchKeyword { get; set; }
        private static string _sortOrder = string.Empty;
        private static DateTime DateStart { get; set; }

        public static int RetrievedResultPageNo { get; set; }
        public static int SearchResultPageNo { get; set; }
        public static string UniqueParticipantID { get; set; }
        public int EventID { get; set; }

        public static int Page { get; set; }

        const int pageSize = 10;

        private void process(string institutionID, string uri)
        {
            if (Logs.GeneralLog == null || Logs.GeneralLog.Count() == 0)
            {
                Logs.GeneralLog = Logs.CreateGeneralEventLog();
            }
            NcsInfo ret = null;
            string fileName = Path.GetFileName(uri);
            var entries = Logs.GeneralLog
                .Where(x => x.InstitutionID == InstitutionID &&
                            x.Environment.ToUpper() == HomeController.CurrentEnvironment.ToUpper() &&
                            (x.URIType == "sFTP") &&
                            x.ProgramID == PROGRAM_ID.UPASS &&
                            !String.IsNullOrEmpty(x.URI) &&
                            //!String.IsNullOrEmpty(x.UniqueParticipantId) &&
                            x.FileName == fileName)
                .OrderByDescending(x => x.ProcessDatetime)
                .GroupBy(x => new { x.UniqueParticipantId, x.ProcessErrorDescr })
                .Select(g => new UpassFileDetail
                {
                    ID = g.First().ID,
                    ProgramID = g.First().ProgramID,
                    InstitutionID = InstitutionID,
                    Institution = (ret = Logs.GetNCSInfo(InstitutionID)) != null ? ret.Name : null,
                    Category = g.First().Category,
                    CategoryID = g.First().CategoryID,
                    CardSerialNumber = g.First().CardSerialNumber,
                    UniqueParticipantId = g.Key.UniqueParticipantId,
                    Event = g.First().Event,
                    EventID = g.First().EventID,
                    URI = g.First().URI,
                    ProcessDatetime = g.First().ProcessDatetime,
                    Errors = g.Where(r => r.Level == EVENT_STATUS.ERROR).Count(),
                    ClearedErrors = g.Where(c => c.Level == EVENT_STATUS.CLEARED).Count(),
                    Acknowledged = g.Where(a => a.Level == EVENT_STATUS.ACKNOWLEDGED).Count(),
                    CurrentClicked = g.First().CurrentClicked,
                });


            RetrievedResult = entries.ToList();
            SetViewBags();         
        }

        public ActionResult Index(int? page, 
                                  string institutionID, 
                                  string uri,
                                  int? eventID,
                                  long? dateStartTicks, 
                                  string uniqueParticipantID)
        {
            if (dateStartTicks != null)
            {
                DateStart = new DateTime((long)dateStartTicks);
            }
            if (uniqueParticipantID != null)
            {
                UniqueParticipantID = uniqueParticipantID;
            }
            if (eventID != null)
            {
                EventID = (int) eventID;
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
            if (!String.IsNullOrEmpty(institutionID))
            {
                InstitutionID = institutionID;               
            }
            if (InstitutionID == null)
            {
                InstitutionID = (string) Session["InstitutionID"];
            }


            if (!String.IsNullOrEmpty(uri))
            {
                Uri = uri;
            }

            process(InstitutionID, Uri);

            // Clear previous static data if it holds
            SearchResult = null;            

            return View();
            
        }
        public PartialViewResult UpdateRetrievedResult(int? page, string sortOrder, string institutionID, string uri, DateTime? dateStart)
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
                DateStart = (DateTime) dateStart;
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

            
            var entries = RetrievedResult;
            var ents = from entry in entries
                       select entry;
            if (page == null)
            {
                ViewBag.DateTimeStartSortParm = _sortOrder == "DateTimeStart" ? "DateTimeStart_desc" : "DateTimeStart";
                ViewBag.GUIDSortParm = _sortOrder == "GUID" ? "GUID_desc" : "GUID";
                ViewBag.CategorySortParm = _sortOrder == "Category" ? "Category_desc" : "Category";
                ViewBag.EventSortParm = _sortOrder == "Event" ? "Event_desc" : "Event";
                ViewBag.StatusSortParm = _sortOrder == "Status" ? "Status_desc" : "Status";

                switch (_sortOrder)
                {
                    case "DateTimeStart_desc":
                        ents = ents.OrderByDescending(s => s.ProcessDatetime);
                        break;
                    case "DateTimeStart":
                        ents = ents.OrderBy(s => s.ProcessDatetime);
                        break;
                    case "GUID_desc":
                        ents = ents.OrderByDescending(s => s.UniqueParticipantId);
                        break;
                    case "GUID":
                        ents = ents.OrderBy(s => s.UniqueParticipantId);
                        break;
                    case "Event_desc":
                        ents = ents.OrderByDescending(s => s.EventID);
                        break;
                    case "Event":
                        ents = ents.OrderBy(s => s.EventID);
                        break;
                    case "Category_desc":
                        ents = ents.OrderByDescending(s => s.CategoryID);
                        break;
                    case "Category":
                        ents = ents.OrderBy(s => s.CategoryID);
                        break;
                    case "Status_desc":
                        ents = ents.OrderByDescending(s => s.Errors > 0 ? s.Errors : (s.ClearedErrors > 0 ? s.ClearedErrors : s.Acknowledged));
                        break;
                    case "Status":
                        ents = ents.OrderBy(s => s.Errors > 0 ? s.Errors : (s.ClearedErrors > 0 ? s.ClearedErrors : s.Acknowledged));
                        break;

                    default:
                        ents = ents.OrderByDescending(s => s.ProcessDatetime);
                        break;
                }
            }
            
            RetrievedResult = ents.ToList();
            SetViewBags();
            ViewBag.keyword = CurrentSearchKeyword;

            return PartialView("_FileDetails", null);

        }

        public PartialViewResult SearchFileName(int? page, bool? refresh, string fileName)
        {
            if (!String.IsNullOrEmpty(fileName))
            {
                SearchResult = RetrievedResult.Where(s => s.URI != null && (Path.GetFileName(s.URI)).ToUpper().Contains(fileName.Trim().ToUpper())).ToList();
            }
            else
            {
                SearchResult = null;
            }
            SetViewBags();
            
            CurrentSearchKeyword = string.Format(" File Name contains '{0}'", fileName);
            ViewBag.keyword = CurrentSearchKeyword;

            return PartialView("_PartialFiles", null);
        }

        public PartialViewResult SearchUniqueParticipantID(int? page, bool? refresh, string uniqueParticipantID)
        {
            if (!String.IsNullOrEmpty(uniqueParticipantID))
            {
                var entries = RetrievedResult
                .Where(s => s.UniqueParticipantId != null && s.UniqueParticipantId.ToUpper().Contains(uniqueParticipantID.Trim().ToUpper()))
                .OrderByDescending(x => x.ProcessDatetime)
                .GroupBy(x => new { x.URI, x.ProcessDatetime, x.ProcessErrorDescr })
                .Select(g => new UpassFileDetail
                {
                    InstitutionID = InstitutionID,
                    Category = g.First().Category,
                    CategoryID = g.First().CategoryID,
                    CardSerialNumber = g.First().CardSerialNumber,
                    UniqueParticipantId = g.First().UniqueParticipantId,
                    Event = g.First().Event,
                    EventID = g.First().EventID,
                    URI = g.First().URI,
                    ProcessDatetime = g.Key.ProcessDatetime,
                    Errors = g.Where(r => r.Level == EVENT_STATUS.ERROR).Count(),
                    ClearedErrors = g.Where(c => c.Level == EVENT_STATUS.CLEARED).Count(),
                    Acknowledged = g.Where(a => a.Level == EVENT_STATUS.ACKNOWLEDGED).Count(),
                });
                SearchResult = entries.ToList();
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
                if (cate > 0 && evt > 0)
                {
                    da.SpUpdateErrorList(evt, cate, processDatetimeTicks, status, User.Identity.Name, programID, institutionID);
#if true
                    Logs.GeneralLog = Logs.UpdateGeneralEventLogLevel(Logs.GeneralLog, cate, evt, processDatetimeTicks, status, programID, institutionID);
#else
                    Logs.GeneralLog = Logs.UpdateGeneralEventLogLevel(Logs.GeneralLog);
#endif
                    Logs.GeneralLog = Logs.SetCurrentClickedRow(Logs.GeneralLog, ID);
                }
                else
                {
                    ViewBag.ErrorMsg = "Either Category ID is zero or Event ID is zero";
                    return PartialView("_Error", null);
                }
            }
            catch (SqlException ex)
            {
                ViewBag.ErrorMsg = ex.Message;
                return PartialView("_Error", null);
            }

            process(institutionID, Uri);
            return PartialView("_FileDetails", null);           
        }

        #endregion
    }
}
