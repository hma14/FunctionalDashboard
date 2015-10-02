using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using FunctionalDashboard.Models;
using System.Data;
using FunctionalDashboard.Dal.DataEntity;
using PagedList;
using FunctionalDashboard.ViewModels;
using System.IO;
using MvcSiteMapProvider;
using System.Web.Configuration;
using Rotativa.Options;
using System.Web.UI;
using System.Web.UI.WebControls;
using FastMember;
using System.Globalization;
using System.Configuration;
using NPOI.HSSF.UserModel;
using NPOI.XSSF.UserModel;
using System.Drawing;


namespace FunctionalDashboard.Controllers
{

    public class ProgramPpassController : BaseController
    {
        // Tab Files
        private IList<PpassProgramFile> RetrievedResult { get; set; }
        private IList<PpassProgramWebService> WSRetrievedResult { get; set; }

        private IList<PpassProgramFile> SearchResult { get; set; }
        private IList<PpassProgramWebService> WSSearchResult { get; set; }
        private static string InstitutionID { get; set; }
        private static string Uri { get; set; }
        public static int RetrievedResultPageNo { get; set; }
        public static int WSRetrievedResultPageNo { get; set; }
        public static int SearchResultPageNo { get; set; }
        public static int WSSearchResultPageNo { get; set; }
        public static string CurrentSearchKeyword { get; set; }
        public static string WSCurrentSearchKeyword { get; set; }

        // Sort Order
        private static string RetrieveResult_SortOrder { get; set; }
        private static string SearchResult_SortOrder { get; set; }
        private static string WSRetrieveResult_SortOrder { get; set; }
        private static string WSSearchResult_SortOrder { get; set; }


        // Default page size
        const int pageSize = 10;
        private static int Page { get; set; }



        #region For Panel File

        public ActionResult Index(string institutionID, DateTime? startDate, DateTime? endDate, int? page, bool? refresh, string id)
        { 
            SetDateRange(startDate, endDate);

            if (!String.IsNullOrEmpty(institutionID))
            {
                InstitutionID = institutionID;
                Session["InstitutionID"] = institutionID;
            }
            else if (Session["InstitutionID"] != null)
            {
                InstitutionID = (string) Session["InstitutionID"];
            }
            if (page != null)
            {
                Page = (int)page;
            }
            if (Page == 0)
            {
                Page = 1;
            }

            setFileViewBags();
            setWSViewBags();

            // Clear previous static data if it holds
            SearchResult = null;
            WSSearchResult = null;

            // Get current Server from which EventLog is being monitored and display
            SetCurrentServer();

            // Get total memory used so far and set and display
            SetCurrentProcessMemorySize();

            return View();
        }

        public PartialViewResult UpdateRetrievedResult(DateTime? startDate, DateTime? endDate, string sortOrder, int? page)
        {
            if (!String.IsNullOrEmpty(sortOrder))
            {
                RetrieveResult_SortOrder = sortOrder;
            }

            SetDateRange(startDate, endDate);

            if (page != null)
            {
                Page = (int)page;
            }           

            setFileViewBags();
            setWSViewBags();
            Session["WSKeyword"] = WSCurrentSearchKeyword;

            return PartialView("_PartialFiles", null);
        }

        private IList<PpassProgramFile> UpdateRetrieved(int? page)
        {
            if (RetrievedResult == null)
            {
                RetrievedResult = (List<PpassProgramFile>)Session["RetrievedResult"];
            }
            var entries = from entry in RetrievedResult
                          select entry;

            if (page == null)
            {
                ViewBag.DateTimeStartSortParm = RetrieveResult_SortOrder == "DateTimeStart" ? "DateTimeStart_desc" : "DateTimeStart";
                ViewBag.FileNameSortParm = RetrieveResult_SortOrder == "FileName" ? "FileName_desc" : "FileName";
                ViewBag.UniqueParticipantIDSortParm = RetrieveResult_SortOrder == "UniqueParticipantID" ? "UniqueParticipantID_desc" : "UniqueParticipantID";
                ViewBag.RequestsSortParm = RetrieveResult_SortOrder == "Requests" ? "Requests_desc" : "Requests";
                ViewBag.StatusSortParm = RetrieveResult_SortOrder == "Status" ? "Status_desc" : "Status";

            }

            switch (RetrieveResult_SortOrder)
            {
                case "DateTimeStart":
                    entries = entries.OrderBy(s => s.DateStart);
                    break;
                case "FileName_desc":
                    entries = entries.OrderByDescending(s => s.FileName);
                    break;
                case "FileName":
                    entries = entries.OrderBy(s => s.FileName);
                    break;
                case "UniqueParticipantID_desc":
                    entries = entries.OrderByDescending(s => s.UniqueParticipantID);
                    break;
                case "UniqueParticipantID":
                    entries = entries.OrderBy(s => s.UniqueParticipantID);
                    break;
                case "Requests_desc":
                    entries = entries.OrderByDescending(s => s.Requests);
                    break;
                case "Requests":
                    entries = entries.OrderBy(s => s.Requests);
                    break;
                case "Status_desc":
                    entries = entries.OrderByDescending(s => s.Errors > 0 ? s.Errors : (s.ClearedErrors > 0 ? s.ClearedErrors : s.Acknowledged));
                    break;
                case "Status":
                    entries = entries.OrderBy(s => s.Errors > 0 ? s.Errors : (s.ClearedErrors > 0 ? s.ClearedErrors : s.Acknowledged));
                    break;

                default:
                    entries = entries.OrderByDescending(s => s.DateStart);
                    break;
            }

            return entries.ToList();
        }

        public PartialViewResult UpdateSearchResult(int? page, string sortOrder2)
        {
            if (!String.IsNullOrEmpty(sortOrder2))
            {
                SearchResult_SortOrder = sortOrder2;
            }
            
            var entries = from entry in SearchResult
                          select entry;

            if (page == null)
            {
                ViewBag.DateTimeStartSortParm = SearchResult_SortOrder == "DateTimeStart" ? "DateTimeStart_desc" : "DateTimeStart";
                ViewBag.FileNameSortParm = SearchResult_SortOrder == "FileName" ? "FileName_desc" : "FileName";
                ViewBag.UniqueParticipantIDSortParm = SearchResult_SortOrder == "UniqueParticipantID" ? "UniqueParticipantID_desc" : "UniqueParticipantID";
                ViewBag.RequestsSortParm = SearchResult_SortOrder == "Requests" ? "Requests_desc" : "Requests";
                ViewBag.StatusSortParm = SearchResult_SortOrder == "Status" ? "Status_desc" : "Status";
            }

            switch (SearchResult_SortOrder)
            {
                case "DateTimeStart_desc":
                    entries = entries.OrderByDescending(s => s.DateStart);
                    break;
                case "DateTimeStart":
                    entries = entries.OrderBy(s => s.DateStart);
                    break;
                case "FileName_desc":
                    entries = entries.OrderByDescending(s => s.FileName);
                    break;
                case "FileName":
                    entries = entries.OrderBy(s => s.FileName);
                    break;
                case "UniqueParticipantID_desc":
                    entries = entries.OrderByDescending(s => s.UniqueParticipantID);
                    break;
                case "UniqueParticipantID":
                    entries = entries.OrderBy(s => s.UniqueParticipantID);
                    break;
                case "Requests_desc":
                    entries = entries.OrderByDescending(s => s.Requests);
                    break;
                case "Requests":
                    entries = entries.OrderBy(s => s.Requests);
                    break;
                case "Status_desc":
                    entries = entries.OrderByDescending(s => s.Errors > 0 ? s.Errors : (s.ClearedErrors > 0 ? s.ClearedErrors : s.Acknowledged));
                    break;
                case "Status":
                    entries = entries.OrderBy(s => s.Errors > 0 ? s.Errors : (s.ClearedErrors > 0 ? s.ClearedErrors : s.Acknowledged));
                    break;

                default:
                    entries = entries.OrderByDescending(s => s.DateStart);
                    break;
            }

            if (page != null)
            {
                Page = (int)page;
            }
            else
            {
                Page = 1;
            }
            SearchResult = entries.ToList();
            Session["WSKeyword"] = CurrentSearchKeyword;

            return PartialView("_PartialFiles", null);
        }

        private IEnumerable<PpassProgramFile> GenListFromLog(DateTime startDate, DateTime endDate)
        {
            NcsInfo ret = null;
            if (Logs.GeneralLog == null || Logs.GeneralLog.Count() == 0)
            {
                Logs.GeneralLog = Logs.CreateGeneralEventLog();
            }
            var entries = Logs.GeneralLog
                .Where(x => x.ProgramID != PROGRAM_ID.UPASS &&
                            x.ProcessDatetime >= startDate &&
                            x.ProcessDatetime <= endDate &&
                            x.URIType == "sFTP" &&
                            !String.IsNullOrEmpty(x.InstitutionID) &&
                            x.InstitutionID == InstitutionID &&
                            x.Environment.ToUpper() == HomeController.CurrentEnvironment.ToUpper() &&
                            !String.IsNullOrEmpty(x.URI) && 
                            (x.URI.Contains("IUF_") || x.URI.Contains("FUF_") || x.URI.Contains("FCF_") || x.URI.Contains("ICF_") || x.Level == "Error"))
                .OrderByDescending(x => x.ProcessDatetime)
                .GroupBy(x => new { x.URI })
                .Select(g => new PpassProgramFile
                {
                    ID = g.First().ID,
                    Level = g.First().Level,
                    InstitutionID = g.First().InstitutionID,
                    Institution = (ret = Logs.GetNCSInfo(g.First().InstitutionID)) != null ? ret.Name : null,
                    DateStart = g.First().ProcessDatetime,
                    NCSCustomerID = ret != null ? ret.OrganizationId : 0,
                    Program = g.First().ProgramID,
                    Category = g.First().Category,
                    CategoryID = g.First().CategoryID,
                    Event = g.First().Event,
                    EventID = g.First().EventID,
                    URI = g.Key.URI,
                    FileName = Path.GetFileNameWithoutExtension(g.Key.URI),
                    UniqueParticipantID = g.First().UniqueParticipantId,
                    RequestTxID = g.First().RequestTxID,
                    CSN = g.First().ExistingCardSN != null ? g.First().ExistingCardSN : g.First().CardSerialNumber,

                    Files = g.Select(f => new File_Info
                    {
                        ID = f.ID,
                        Event = f.Event,
                        EventID = f.EventID,
                        UniqueParticipantID = f.UniqueParticipantId,
                        RequestTxID = f.RequestTxID,
                        ProcessTime = f.ProcessDatetime,
                        CSN = f.ExistingCardSN != null ? f.ExistingCardSN : f.CardSerialNumber,
                        LogLevel = f.Level,
                    }).ToList(),

                    Name = ret.Name,
                    OrganizationId = ret.OrganizationId,
                    ShortName = ret.ShortName,
                    Requests = g.Where(r => r.RequestTxID != null).Count(),

                    IufRequests = g.Where(r => r.RequestTxID != null && r.CategoryID == CATEGORY_ID_FILES.IUF).Count(),
                    FufRequests = g.Where(r => r.RequestTxID != null && r.CategoryID == CATEGORY_ID_FILES.FUF).Count(),
                    FcfRequests = g.Where(r => r.RequestTxID != null && r.CategoryID == CATEGORY_ID_FILES.FCF).Count(),
                    IcfRequests = g.Where(r => r.RequestTxID != null && r.CategoryID == CATEGORY_ID_FILES.ICF).Count(),

                    ProcessTime = g.First().ProcessDatetime,
                    ErrorDescr = g.First().ProcessErrorDescr,
                    StackTrace = g.First().StackTrace,
                    Errors = g.Where(e => e.Level == EVENT_STATUS.ERROR).Count(),
                    ClearedErrors = g.Where(c => c.Level == EVENT_STATUS.CLEARED).Count(),
                    Acknowledged = g.Where(a => a.Level == EVENT_STATUS.ACKNOWLEDGED).Count(),
                });

            return entries;
        }


        public PartialViewResult SearchFileName(int? page, bool? refresh, string fileName)
        {
            if (!String.IsNullOrEmpty(fileName))
            {
                if (RetrievedResult == null)
                {
                    RetrievedResult = (List<PpassProgramFile>)Session["RetrievedResult"];
                }
                SearchResult = RetrievedResult.Where(s => s.FileName != null && s.FileName.ToUpper().Contains(fileName.Trim().ToUpper())).ToList();
            }
            else
            {
                SearchResult = null;
            }

            setFileViewBags();
            CurrentSearchKeyword = string.Format(" File contains '{0}'", fileName);
            Session["Keyword"] = CurrentSearchKeyword;

            return PartialView("_PartialFiles", null);
        }

        public PartialViewResult SearchRequestTxID(string requestTxID, int? page)
        {
            if (!String.IsNullOrEmpty(requestTxID))
            {
                List<PpassProgramFile> lst = new List<PpassProgramFile>();
                if (RetrievedResult == null)
                {
                    RetrievedResult = (List<PpassProgramFile>)Session["RetrievedResult"];
                }
                foreach (var e in RetrievedResult)
                {
                    PpassProgramFile t = new PpassProgramFile();
                    List<File_Info> fi = new List<File_Info>();
                    foreach (var f in e.Files)
                    {                        
                        if (f.RequestTxID != null && f.RequestTxID.ToUpper().Contains(requestTxID.Trim().ToUpper()))
                        {                            
                            fi.Add(f);                                                  
                        }
                    }
                    if (fi.Count() > 0)
                    {
                        t = e;
                        t.Files = fi;
                    }
                    
                    if (t.Files != null && t.Files.Count() > 0)
                    {
                        lst.Add(t);
                    }
                }
                SearchResult = lst;
            }
            else
            {
                SearchResult = null;
            }

            CurrentSearchKeyword = string.Format(" RequestTxID contains '{0}'", requestTxID);
            Session["Keyword"] = CurrentSearchKeyword;
            setFileViewBags();

            return PartialView("_PartialFiles", null);
        }

        public PartialViewResult SearchUniqueParticipantID(string uniqueParticipantID, int? page)
        {
            if (!String.IsNullOrEmpty(uniqueParticipantID))
            {
                List<PpassProgramFile> lst = new List<PpassProgramFile>();
                if (RetrievedResult == null)
                {
                    RetrievedResult = (List<PpassProgramFile>)Session["RetrievedResult"];
                }
                foreach (var e in RetrievedResult)
                {
                    PpassProgramFile t = new PpassProgramFile();
                    List<File_Info> fi = new List<File_Info>();
                    foreach (var f in e.Files)
                    {
                        if (f.UniqueParticipantID != null && f.UniqueParticipantID.ToUpper().Contains(uniqueParticipantID.Trim().ToUpper()))
                        {
                            fi.Add(f);
                        }
                    }
                    if (fi.Count() > 0)
                    {
                        t = e;
                        t.Files = fi;
                    }

                    if (t.Files != null && t.Files.Count() > 0)
                    {
                        lst.Add(t);
                    }
                }
                SearchResult = lst;
            }
            else
            {
                SearchResult = null;
            }

            CurrentSearchKeyword = string.Format(" Unique Participant ID contains '{0}'", uniqueParticipantID);
            Session["Keyword"] = CurrentSearchKeyword;
            setFileViewBags();

            return PartialView("_PartialFiles", null);
        }

        public PartialViewResult SearchCSN(string CSN, int? page)
        {
            if (!String.IsNullOrEmpty(CSN))
            {
                List<PpassProgramFile> lst = new List<PpassProgramFile>();
                if (RetrievedResult == null)
                {
                    RetrievedResult = (List<PpassProgramFile>)Session["RetrievedResult"];
                }
                foreach (var e in RetrievedResult)
                {
                    PpassProgramFile t = new PpassProgramFile();
                    List<File_Info> fi = new List<File_Info>();
                    foreach (var f in e.Files)
                    {
                        if (f.CSN != null && f.CSN.ToUpper().Contains(CSN.Trim().ToUpper()))
                        {
                            fi.Add(f);
                        }
                    }
                    if (fi.Count() > 0)
                    {
                        t = e;
                        t.Files = fi;
                    }

                    if (t.Files != null && t.Files.Count() > 0)
                    {
                        lst.Add(t);
                    }
                }
                SearchResult = lst;                
            }
            else
            {
                SearchResult = null;
            }

            CurrentSearchKeyword = string.Format(" Card Serial Number contains '{0}'", CSN);
            Session["Keyword"] = CurrentSearchKeyword;
            setFileViewBags();

            return PartialView("_PartialFiles", null);
        }

        [OutputCache(Duration = 3600, Location = OutputCacheLocation.Client, NoStore = true)]
        public ActionResult GetFiles(long? dateStartTicks, string uri)
        {
            IList<PpassProgramFile> result;
            DateTime dateStart = new DateTime((long)dateStartTicks);
            if (SearchResult == null)
            {
                if (RetrievedResult == null)
                {
                    RetrievedResult = (List<PpassProgramFile>)Session["RetrievedResult"];
                }
                result = RetrievedResult.Where(x => x.DateStart == dateStart && x.URI == uri).ToList();
            }
            else
            {
                result = SearchResult.Where(x => x.DateStart == dateStart && x.URI == uri).ToList();
            }
            return View("_FileDropDown", result.FirstOrDefault());
        }

        #endregion

        #region For Panel Web Service

        public ActionResult WebServices(string institutionID, DateTime? startDate, DateTime? endDate, int? page, bool? refresh)
        {
            SetDateRange(startDate, endDate);

            if (!String.IsNullOrEmpty(institutionID))
            {
                InstitutionID = institutionID;
            }
            if (page != null)
            {
                Page = (int)page;
            }
            if (Page == 0)
            {
                Page = 1;
            }

            // Tab File
            setFileViewBags();

            // Tab Web Service
            setWSViewBags();

            // Clear previous static data if it holds
            SearchResult = null;
            WSSearchResult = null;

            // Get current Server from which EventLog is being monitored and display
            SetCurrentServer();

            // Get total memory used so far and set and display
            SetCurrentProcessMemorySize();

            return View();
        }

        public PartialViewResult WSUpdateRetrievedResult(DateTime? startDate, DateTime? endDate, string sortOrderWS, int? page)
        {
            if (!String.IsNullOrEmpty(sortOrderWS))
            {
                WSRetrieveResult_SortOrder = sortOrderWS;
            }

            SetDateRange(startDate, endDate);
            
            if (page != null)
            {
                Page = (int)page;
            }
            
            Session["WSKeyword"] = WSCurrentSearchKeyword;

            setWSViewBags();
            setFileViewBags();

            return PartialView("_PartialWS", null);
        }

        private IList<PpassProgramWebService> WSUpdateRetrieved(int? page)
        {
            var entries = from entry in WSRetrievedResult
                          select entry;

            if (page == null)
            {
                ViewBag.WSDateTimeStartSortParm = WSRetrieveResult_SortOrder == "DateTimeStart" ? "DateTimeStart_desc" : "DateTimeStart";
                ViewBag.WSCategorySortParm = WSRetrieveResult_SortOrder == "Category" ? "Category_desc" : "Category";
                ViewBag.WSEventSortParm = WSRetrieveResult_SortOrder == "Event" ? "Event_desc" : "Event";
                ViewBag.WSGUIDSortParm = WSRetrieveResult_SortOrder == "GUID" ? "GUID_desc" : "GUID";
                ViewBag.WSStatusSortParm = WSRetrieveResult_SortOrder == "Status" ? "Status_desc" : "Status";
            }

            switch (WSRetrieveResult_SortOrder)
            {
                case "DateTimeStart":
                    entries = entries.OrderBy(s => s.DateStart);
                    break;
                case "Category_desc":
                    entries = entries.OrderByDescending(s => s.Category);
                    break;
                case "Category":
                    entries = entries.OrderBy(s => s.Category);
                    break;
                case "Event_desc":
                    entries = entries.OrderByDescending(s => s.Event);
                    break;
                case "Event":
                    entries = entries.OrderBy(s => s.Event);
                    break;
                case "GUID_desc":
                    entries = entries.OrderByDescending(s => s.GUID);
                    break;
                case "GUID":
                    entries = entries.OrderBy(s => s.GUID);
                    break;
                case "Status_desc":
                    entries = entries.OrderByDescending(s => s.Errors > 0 ? s.Errors : (s.ClearedErrors > 0 ? s.ClearedErrors : s.Acknowledged));
                    break;
                case "Status":
                    entries = entries.OrderBy(s => s.Errors > 0 ? s.Errors : (s.ClearedErrors > 0 ? s.ClearedErrors : s.Acknowledged));
                    break;

                default:
                    entries = entries.OrderByDescending(s => s.DateStart);
                    break;
            }

            return entries.ToList();
        }

        public PartialViewResult WSUpdateSearchResult(int? page, string sortOrderWS)
        {
            if (!String.IsNullOrEmpty(sortOrderWS))
            {
                WSSearchResult_SortOrder = sortOrderWS;
            }

            var entries = from entry in WSSearchResult
                          select entry;

            if (page == null)
            {
                ViewBag.WSDateTimeStartSortParm = WSSearchResult_SortOrder == "DateTimeStart" ? "DateTimeStart_desc" : "DateTimeStart";
                ViewBag.WSCategorySortParm = WSSearchResult_SortOrder == "Category" ? "Category_desc" : "Category";
                ViewBag.WSEventSortParm = WSSearchResult_SortOrder == "Event" ? "Event_desc" : "Event";
                ViewBag.WSElapsedTimeSortParm = WSSearchResult_SortOrder == "ElapsedTime" ? "ElapsedTime_desc" : "ElapsedTime";
                ViewBag.WSStatusSortParm = WSSearchResult_SortOrder == "Status" ? "Status_desc" : "Status";
            }

            switch (WSSearchResult_SortOrder)
            {
                case "DateTimeStart_desc":
                    entries = entries.OrderByDescending(s => s.DateStart);
                    break;
                case "DateTimeStart":
                    entries = entries.OrderBy(s => s.DateStart);
                    break;
                case "Category_desc":
                    entries = entries.OrderByDescending(s => s.Category);
                    break;
                case "Category":
                    entries = entries.OrderBy(s => s.Category);
                    break;
                case "Event_desc":
                    entries = entries.OrderByDescending(s => s.Event);
                    break;
                case "Event":
                    entries = entries.OrderBy(s => s.Event);
                    break;
                case "ElapsedTime_desc":
                    entries = entries.OrderByDescending(s => s.ElapsedTime);
                    break;
                case "ElapsedTime":
                    entries = entries.OrderBy(s => s.ElapsedTime);
                    break;
                case "Status_desc":
                    entries = entries.OrderByDescending(s => s.TotalErrors > 0 ? s.TotalErrors : s.ClearedErrors);
                    break;
                case "Status":
                    entries = entries.OrderBy(s => s.TotalErrors > 0 ? s.TotalErrors : s.ClearedErrors);
                    break;

                default:
                    entries = entries.OrderByDescending(s => s.DateStart);
                    break;
            }

            
            WSSearchResult = entries.ToList();
            setWSViewBags();
            Session["WSKeyword"] = WSCurrentSearchKeyword;

            return PartialView("_PartialWS", null);

        }

        private IEnumerable<PpassProgramWebService> WSGenListFromLog(DateTime? startDate, DateTime? endDate)
        {
            NcsInfo ret = null;
            if (Logs.GeneralLog == null || Logs.GeneralLog.Count() == 0)
            {
                Logs.GeneralLog = Logs.CreateGeneralEventLog();
            }
            var entries = Logs.GeneralLog
                .Where(x => x.ProgramID == PROGRAM_ID.PPASS &&
                            x.URIType == "API" &&
                            x.InstitutionID == InstitutionID &&
                            x.Environment.ToUpper() == HomeController.CurrentEnvironment.ToUpper() &&
                            x.ProcessDatetime >= startDate &&
                            x.ProcessDatetime <= endDate)
                .OrderByDescending(x => x.ProcessDatetime)
                .GroupBy(x => new { x.ProgramID, x.InstitutionID, x.CategoryID, x.GUID })
                .Select(g => new PpassProgramWebService
                {
                    ID = g.First().ID,
                    Level = g.First().Level,
                    TaskID = g.First().TaskID,
                    StateID = g.First().StateID,
                    InstitutionID = !String.IsNullOrEmpty(g.Key.InstitutionID) ? g.Key.InstitutionID : "NA",
                    Institution = (ret = Logs.GetNCSInfo(g.Key.InstitutionID)) != null ? ret.Name : null,
                    DateStart = g.First().ProcessDatetime,
                    NCSCustomerID = ret != null ? ret.OrganizationId : 0,
                    Program = g.First().ProgramID,
                    URI = g.First().URI,
                    URIType = g.First().URIType,
                    CSN = g.First().ExistingCardSN != null ? g.First().ExistingCardSN : g.First().CardSerialNumber,
                    Name = ret != null ? ret.Name : null,
                    OrganizationId = ret != null ? ret.OrganizationId : 0,
                    ShortName = ret != null ? ret.ShortName : null,
                    CategoryID = g.Key.CategoryID,
                    Category = g.First().Category,
                    GUID = g.Key.GUID,
                    Event = g.First().Event,
                    EventID = g.First().EventID,
                    Events = g.Select(e => new Event_ID
                    {
                        ID = e.ID,
                        Event = e.Event,
                        EventID = e.EventID,
                        GUID = e.GUID,
                        URI = e.URI,
                        ProcessTime = e.ProcessDatetime,
                        TaskID = e.TaskID,
                        LogLevel = e.Level
                    }).ToList(),

                    NewCardRequests = g.Where(e => e.CategoryID == CATEGORY_ID_WEBSERVICES.NEW_CARD).Count(),
                    TerminatedCardRequests = g.Where(e => e.CategoryID == CATEGORY_ID_WEBSERVICES.TERMINATE_CARD).Count(),
                    ReplacementCardRequests = g.Where(e => e.CategoryID == CATEGORY_ID_WEBSERVICES.REPLACEMENT_CARD).Count(),
                    SuspendCardRequests = g.Where(e => e.CategoryID == CATEGORY_ID_WEBSERVICES.SUSPEND_CARD).Count(),
                    ResumeCardRequests = g.Where(e => e.CategoryID == CATEGORY_ID_WEBSERVICES.RESUME_CARD).Count(),

                    ErrorDescr = g.First().ProcessErrorDescr,
                    StackTrace = g.First().StackTrace,
                    Errors = g.Where(e => e.Level == EVENT_STATUS.ERROR).Count(),
                    ClearedErrors = g.Where(c => c.Level == EVENT_STATUS.CLEARED).Count(),
                    Acknowledged = g.Where(a => a.Level == EVENT_STATUS.ACKNOWLEDGED).Count()
                });


            return entries;
        }


        public PartialViewResult WSSearchUniqueParticipantID(int? page, bool? refresh, string uniqueParticipantID)
        {
            if (!String.IsNullOrEmpty(uniqueParticipantID))
            {
                List<PpassProgramWebService> lst = new List<PpassProgramWebService>();
                if (WSRetrievedResult == null)
                {
                    WSRetrievedResult = (List<PpassProgramWebService>)Session["WSRetrievedResult"];
                }
                foreach (var e in WSRetrievedResult)
                {
                    PpassProgramWebService t = new PpassProgramWebService();
                    List<Event_ID> ei = new List<Event_ID>();
                    foreach (var evt in e.Events)
                    {
                        if (evt.GUID != null && evt.GUID.ToUpper().Contains(uniqueParticipantID.Trim().ToUpper()))
                        {
                            ei.Add(evt);
                        }
                    }
                    if (ei.Count() > 0)
                    {
                        t = e;
                        t.Events = ei;
                    }
                    if (t.Events != null && t.Events.Count() > 0)
                    {
                        lst.Add(t);
                    }
                }
                WSSearchResult = lst;
            }
            else
            {
                WSSearchResult = null;
            }

            setWSViewBags();
            WSCurrentSearchKeyword = string.Format(" UniqueParticipant ID contains '{0}'", uniqueParticipantID);
            Session["WSKeyword"] = WSCurrentSearchKeyword;

            return PartialView("_PartialWS", null);
        }

        public PartialViewResult WSSearchCSN(string CSN, int? page)
        {
            if (!String.IsNullOrEmpty(CSN))
            {
                List<PpassProgramWebService> lst = new List<PpassProgramWebService>();
                if (WSRetrievedResult == null)
                {
                    WSRetrievedResult = (List<PpassProgramWebService>)Session["WSRetrievedResult"];
                }
                foreach (var e in WSRetrievedResult)
                {
                    PpassProgramWebService t = new PpassProgramWebService();
                    if (e.CSN !=  null && e.CSN.ToUpper().Contains(CSN.Trim().ToUpper()))
                    {
                        t = e;
                        t.Events = e.Events;
                        lst.Add(t);
                    }
                }
                WSSearchResult = lst;
            }
            else
            {
                WSSearchResult = null;
            }

            if (page != null)
            {
                Page = (int)page;
            }

            setWSViewBags();

            WSCurrentSearchKeyword = string.Format(" Card Serial Number contains '{0}'", CSN);
            Session["WSKeyword"] = WSCurrentSearchKeyword;

            return PartialView("_PartialWS", null);
        }

        [OutputCache(Duration = 3600, Location = OutputCacheLocation.Client, NoStore = true)]
        public ActionResult GetEvents(long ID)
        {
            IList<PpassProgramWebService> result;
            if (WSSearchResult == null)
            {
                if (WSRetrievedResult == null)
                {
                    WSRetrievedResult = (List<PpassProgramWebService>)Session["WSRetrievedResult"];
                }
                result = WSRetrievedResult.Where(x => x.ID == ID).ToList();
            }
            else
            {
                result = WSSearchResult.Where(x => x.ID == ID).ToList();
            }
            return View("_PartialEvents", result.FirstOrDefault());
        }

        #endregion

        #region Export to PDF

        public ActionResult ExportFilePDF()
        {
            var switches = @" --username " + ConfigurationManager.AppSettings["PdfUserName"] +
                            " --password " + ConfigurationManager.AppSettings["PdfPassword"];

            return new Rotativa.ActionAsPdf("GetFileView")
            {
                PageOrientation = Rotativa.Options.Orientation.Landscape,
                PageMargins = { Left = 5, Right = 5 },
                FileName = "ProgramPpassFiles.pdf",
                CustomSwitches = switches,
            };
        }

        public ActionResult GetFileView()
        {
            if (RetrievedResult == null)
            {
                RetrievedResult = (List<PpassProgramFile>)Session["RetrievedResult"];
            }
            var model = RetrievedResult;
            if (SearchResult != null)
            {
                model = SearchResult;
            }
            return View("GetFileView", model);
        }

        public ActionResult ExportWSPDF()
        {
            var switches = @" --username " + ConfigurationManager.AppSettings["PdfUserName"] +
                            " --password " + ConfigurationManager.AppSettings["PdfPassword"];

            return new Rotativa.ActionAsPdf("GetWSView")
            {
                PageOrientation = Rotativa.Options.Orientation.Landscape,
                PageMargins = { Left = 5, Right = 5 },
                FileName = "ProgramPpassWebServices.pdf",
                CustomSwitches = switches,
            };           
        }

        public ActionResult GetWSView()
        {
            if (WSRetrievedResult == null)
            {
                WSRetrievedResult = (List<PpassProgramWebService>)Session["WSRetrievedResult"];
            }
            var model = WSRetrievedResult;
            if (WSSearchResult != null)
            {
                model = WSSearchResult;
            }
            return View("GetWSView", model);
        }

        #endregion

        #region ExportFileExcel - Export to Excel

        public FileResult ExportFileExcel()
        {
            StartDate = (DateTime)Session["StartDate"];
            EndDate = (DateTime)Session["EndDate"];

            var model = SearchResult != null ? SearchResult : RetrievedResult;
            var workbook = new XSSFWorkbook();
            var sheet = workbook.CreateSheet("Ppass Files");

            var headerRow = sheet.CreateRow(0);
            headerRow.CreateCell(0).SetCellValue("Date Time Start");
            headerRow.CreateCell(1).SetCellValue("File Name");
            headerRow.CreateCell(2).SetCellValue("Requests");
            headerRow.CreateCell(3).SetCellValue("Elapsed Time");
            headerRow.CreateCell(4).SetCellValue("Status (Acknowledged or Cleared)");

            sheet.CreateFreezePane(0, 1, 0, 1);

            int rowNumber = 1;
            var row = sheet.CreateRow(rowNumber++);
            foreach (var datarow in model)
            {
                row = sheet.CreateRow(rowNumber++);
                row.CreateCell(0).SetCellValue(datarow.DateStart.ToString("MM/dd/yyyy HH:mm:ss.fff", CultureInfo.InvariantCulture));
                row.CreateCell(1).SetCellValue(datarow.FileName);
                row.CreateCell(2).SetCellValue(datarow.Requests.ToString());
                row.CreateCell(3).SetCellValue(GetElapsedTime(datarow.Files).ToString());
                row.CreateCell(4).SetCellValue(String.Format("{0} {1} ({2})  {3}",  datarow.Level,
                                                                                    datarow.Errors,
                                                                                    datarow.Acknowledged + datarow.ClearedErrors,
                                                                                    datarow.ErrorDescr));

                foreach (var f in datarow.Files)
                {
                    row = sheet.CreateRow(rowNumber++);
                    row.CreateCell(1).SetCellValue(String.Format("          - {0}   ({1})   {2}   {3}", f.Event, f.EventID, f.UniqueParticipantID, f.CSN));
                }

                row = sheet.CreateRow(rowNumber++);
                row.CreateCell(0).SetCellValue(string.Empty);
                row.CreateCell(1).SetCellValue(string.Empty);
            }

            XSSFColor backColor = new XSSFColor(Color.Yellow);
            XSSFCellStyle style = (XSSFCellStyle)workbook.CreateCellStyle();
            style.SetFillForegroundColor(backColor);
            style.FillPattern = NPOI.SS.UserModel.FillPattern.SolidForeground;
            style.Alignment = NPOI.SS.UserModel.HorizontalAlignment.Center;
            XSSFFont font = (XSSFFont)workbook.CreateFont();
            font.FontHeightInPoints = 12;
            font.FontName = "Calibri";
            font.Boldweight = (short)NPOI.SS.UserModel.FontBoldWeight.Bold;

            for (int i = 0; i <= 4; i++)
            {
                XSSFCell cell = (XSSFCell)headerRow.GetCell(i);
                cell.CellStyle = style;
                cell.CellStyle.SetFont(font);
            }

            for (int i = 0; i <= 4; i++)
            {
                sheet.AutoSizeColumn(i);
            }

            XSSFCellStyle style2 = (XSSFCellStyle)workbook.CreateCellStyle();
            style2.SetFillForegroundColor(backColor);
            style2.FillPattern = NPOI.SS.UserModel.FillPattern.SolidForeground;
            style2.Alignment = NPOI.SS.UserModel.HorizontalAlignment.Left;

            var infoSheet = workbook.CreateSheet("Info");
            infoSheet.CreateFreezePane(0, 1, 0, 1);
            rowNumber = 0;
            var ni = Logs.GetNCSInfo(InstitutionID);
            
            row = infoSheet.CreateRow(rowNumber++);
            row.CreateCell(0).SetCellValue("Program Name");
            XSSFCell c = (XSSFCell)row.GetCell(0);
            c.CellStyle = style2;
            c.CellStyle.SetFont(font);

            row.CreateCell(1).SetCellValue(ni.ProgramId);

            row = infoSheet.CreateRow(rowNumber++);
            row.CreateCell(0).SetCellValue("NCS Organisation Name");
            c = (XSSFCell)row.GetCell(0);
            c.CellStyle = style2;
            c.CellStyle.SetFont(font);
            row.CreateCell(1).SetCellValue(ni.Name);

            row = infoSheet.CreateRow(rowNumber++);
            row.CreateCell(0).SetCellValue("NCS Customer ID");
            c = (XSSFCell)row.GetCell(0);
            c.CellStyle = style2;
            c.CellStyle.SetFont(font);
            row.CreateCell(1).SetCellValue(ni.OrganizationId);

            row = infoSheet.CreateRow(rowNumber++);
            row.CreateCell(0).SetCellValue("NCS Customer Assigned ID");
            c = (XSSFCell)row.GetCell(0);
            c.CellStyle = style2;
            c.CellStyle.SetFont(font);
            row.CreateCell(1).SetCellValue(ni.ShortName);

            row = infoSheet.CreateRow(rowNumber++);
            row.CreateCell(0).SetCellValue(string.Empty);
            row.CreateCell(1).SetCellValue(string.Empty);

            row = infoSheet.CreateRow(rowNumber++);
            row.CreateCell(0).SetCellValue("Total IUF");
            c = (XSSFCell)row.GetCell(0);
            c.CellStyle = style2;
            c.CellStyle.SetFont(font);
            row.CreateCell(1).SetCellValue(model.Sum(e => e.IufRequests));

            row = infoSheet.CreateRow(rowNumber++);
            row.CreateCell(0).SetCellValue("Total FUF");
            c = (XSSFCell)row.GetCell(0);
            c.CellStyle = style2;
            c.CellStyle.SetFont(font);
            row.CreateCell(1).SetCellValue(model.Sum(e => e.FufRequests));

            row = infoSheet.CreateRow(rowNumber++);
            row.CreateCell(0).SetCellValue("Total FCF");
            c = (XSSFCell)row.GetCell(0);
            c.CellStyle = style2;
            c.CellStyle.SetFont(font);
            row.CreateCell(1).SetCellValue(model.Sum(e => e.FcfRequests));

            row = infoSheet.CreateRow(rowNumber++);
            row.CreateCell(0).SetCellValue("Total ICF");
            c = (XSSFCell)row.GetCell(0);
            c.CellStyle = style2;
            c.CellStyle.SetFont(font);
            row.CreateCell(1).SetCellValue(model.Sum(e => e.IcfRequests));

            row = infoSheet.CreateRow(rowNumber++);
            row.CreateCell(0).SetCellValue("Errors (Acknowledged or Cleared)");
            c = (XSSFCell)row.GetCell(0);
            c.CellStyle = style2;
            c.CellStyle.SetFont(font);
            row.CreateCell(1).SetCellValue(String.Format("{0} ({1})", model.Sum(e => e.Errors),
                                                                      model.Sum(e => e.ClearedErrors) + model.Sum(e => e.Acknowledged)));

            row = infoSheet.CreateRow(rowNumber++);
            row.CreateCell(0).SetCellValue(string.Empty);
            row.CreateCell(1).SetCellValue(string.Empty);

            row.CreateCell(0).SetCellValue("Request Start:");
            c = (XSSFCell)row.GetCell(0);
            c.CellStyle = style2;
            c.CellStyle.SetFont(font);
            row.CreateCell(1).SetCellValue(StartDate.ToString());

            row = infoSheet.CreateRow(rowNumber++);
            row.CreateCell(0).SetCellValue("Request End:");
            c = (XSSFCell)row.GetCell(0);
            c.CellStyle = style2;
            c.CellStyle.SetFont(font);
            row.CreateCell(1).SetCellValue(EndDate.ToString());

            for (int i = 0; i <= 2; i++)
            {
                infoSheet.AutoSizeColumn(i);
            }

            MemoryStream output = new MemoryStream();
            workbook.Write(output);
            return File(output.ToArray(), "application/vnd.ms-excel", "PpassFiles.xlsx");
        }
        
        #endregion


        #region ExportWSExcel - Export Web Services to Excel


        public FileResult ExportWSExcel()
        {
            StartDate = (DateTime)Session["StartDate"];
            EndDate = (DateTime)Session["EndDate"];
            if (WSRetrievedResult == null)
            {
                WSRetrievedResult = (List<PpassProgramWebService>)Session["WSRetrievedResult"];
            }

            var model = WSSearchResult != null ? WSSearchResult : WSRetrievedResult;
            var workbook = new XSSFWorkbook();
            var sheet = workbook.CreateSheet("Ppass WebServices");           

            var headerRow = sheet.CreateRow(0);
            headerRow.CreateCell(0).SetCellValue("Date Time Start");
            headerRow.CreateCell(1).SetCellValue("Category (id)");
            headerRow.CreateCell(2).SetCellValue("Event (id)");
            headerRow.CreateCell(3).SetCellValue("GUID");
            headerRow.CreateCell(4).SetCellValue("Elapsed Time");
            headerRow.CreateCell(5).SetCellValue("Status (Acknowledged or Cleared)");

            sheet.CreateFreezePane(0, 1, 0, 1);

            int rowNumber = 1;
            var row = sheet.CreateRow(rowNumber++);
            foreach (var datarow in model)
            {
                row = sheet.CreateRow(rowNumber++);
                row.CreateCell(0).SetCellValue(datarow.DateStart.ToString("MM/dd/yyyy HH:mm:ss.fff", CultureInfo.InvariantCulture));
                row.CreateCell(1).SetCellValue(datarow.Category + "(" + datarow.CategoryID.ToString() + ")");
                row.CreateCell(2).SetCellValue(datarow.Event + "(" + datarow.EventID.ToString() + ")");
                row.CreateCell(3).SetCellValue(datarow.GUID);
                row.CreateCell(4).SetCellValue(GetElapsedTime(datarow.Events).ToString());
                row.CreateCell(5).SetCellValue(String.Format("{0} {1} ({2})  {3}", datarow.Level,
                                                                                    datarow.Errors,
                                                                                    datarow.Acknowledged + datarow.ClearedErrors,
                                                                                    datarow.ErrorDescr));

                foreach (var f in datarow.Events)
                {
                    row = sheet.CreateRow(rowNumber++);
                    row.CreateCell(2).SetCellValue(String.Format("         - {0}   ({1})", f.Event, f.EventID));
                }

                row = sheet.CreateRow(rowNumber++);
                row.CreateCell(0).SetCellValue(string.Empty);
                row.CreateCell(1).SetCellValue(string.Empty);
            }

            XSSFColor backColor = new XSSFColor(Color.Yellow);
            XSSFCellStyle style = (XSSFCellStyle)workbook.CreateCellStyle();
            style.SetFillForegroundColor(backColor);
            style.FillPattern = NPOI.SS.UserModel.FillPattern.SolidForeground;
            style.Alignment = NPOI.SS.UserModel.HorizontalAlignment.Center;
            XSSFFont font = (XSSFFont)workbook.CreateFont();
            font.FontHeightInPoints = 12;
            font.FontName = "Calibri";
            font.Boldweight = (short)NPOI.SS.UserModel.FontBoldWeight.Bold;

            for (int i = 0; i <= 5; i++)
            {
                XSSFCell cell = (XSSFCell)headerRow.GetCell(i);
                cell.CellStyle = style;
                cell.CellStyle.SetFont(font);
            }

            for (int i = 0; i <= 5; i++)
            {
                sheet.AutoSizeColumn(i);
            }

            XSSFCellStyle style2 = (XSSFCellStyle)workbook.CreateCellStyle();
            style2.SetFillForegroundColor(backColor);
            style2.FillPattern = NPOI.SS.UserModel.FillPattern.SolidForeground;
            style2.Alignment = NPOI.SS.UserModel.HorizontalAlignment.Left;

            var infoSheet = workbook.CreateSheet("Info");
            infoSheet.CreateFreezePane(0, 1, 0, 1);
            rowNumber = 0;
            NcsInfo ni = Logs.GetNCSInfo(InstitutionID);
            row = infoSheet.CreateRow(rowNumber++);
            row.CreateCell(0).SetCellValue("Program Name");
            XSSFCell c = (XSSFCell)row.GetCell(0);
            c.CellStyle = style2;
            c.CellStyle.SetFont(font);
            row.CreateCell(1).SetCellValue(ni.ProgramId);

            row = infoSheet.CreateRow(rowNumber++);
            row.CreateCell(0).SetCellValue("NCS Organisation Name");
            c = (XSSFCell)row.GetCell(0);
            c.CellStyle = style2;
            c.CellStyle.SetFont(font);
            row.CreateCell(1).SetCellValue(ni.Name);

            row = infoSheet.CreateRow(rowNumber++);
            row.CreateCell(0).SetCellValue("NCS Customer ID");
            c = (XSSFCell)row.GetCell(0);
            c.CellStyle = style2;
            c.CellStyle.SetFont(font);
            row.CreateCell(1).SetCellValue(ni.OrganizationId);

            row = infoSheet.CreateRow(rowNumber++);
            row.CreateCell(0).SetCellValue("NCS Customer Assigned ID");
            c = (XSSFCell)row.GetCell(0);
            c.CellStyle = style2;
            c.CellStyle.SetFont(font);
            row.CreateCell(1).SetCellValue(ni.ShortName);

            row = infoSheet.CreateRow(rowNumber++);
            row.CreateCell(0).SetCellValue(string.Empty);
            row.CreateCell(1).SetCellValue(string.Empty);

            row = infoSheet.CreateRow(rowNumber++);
            row.CreateCell(0).SetCellValue("New Card");
            c = (XSSFCell)row.GetCell(0);
            c.CellStyle = style2;
            c.CellStyle.SetFont(font);
            row.CreateCell(1).SetCellValue(model.Sum(e => e.NewCardRequests));

            row = infoSheet.CreateRow(rowNumber++);
            row.CreateCell(0).SetCellValue("Terminated Card");
            c = (XSSFCell)row.GetCell(0);
            c.CellStyle = style2;
            c.CellStyle.SetFont(font);
            row.CreateCell(1).SetCellValue(model.Sum(e => e.TerminatedCardRequests));

            row = infoSheet.CreateRow(rowNumber++);
            row.CreateCell(0).SetCellValue("Replacement Card");
            c = (XSSFCell)row.GetCell(0);
            c.CellStyle = style2;
            c.CellStyle.SetFont(font);
            row.CreateCell(1).SetCellValue(model.Sum(e => e.ReplacementCardRequests));

            row = infoSheet.CreateRow(rowNumber++);
            row.CreateCell(0).SetCellValue("Suspend Card");
            c = (XSSFCell)row.GetCell(0);
            c.CellStyle = style2;
            c.CellStyle.SetFont(font);
            row.CreateCell(1).SetCellValue(model.Sum(e => e.SuspendCardRequests));

            row = infoSheet.CreateRow(rowNumber++);
            row.CreateCell(0).SetCellValue("Resume Card");
            c = (XSSFCell)row.GetCell(0);
            c.CellStyle = style2;
            c.CellStyle.SetFont(font);
            row.CreateCell(1).SetCellValue(model.Sum(e => e.ResumeCardRequests));

            row = infoSheet.CreateRow(rowNumber++);
            row.CreateCell(0).SetCellValue("Errors (Acknowledged or Cleared)");
            c = (XSSFCell)row.GetCell(0);
            c.CellStyle = style2;
            c.CellStyle.SetFont(font);
            row.CreateCell(1).SetCellValue(String.Format("{0} ({1})", model.Sum(e => e.Errors), model.Sum(e => e.ClearedErrors) + model.Sum(e => e.Acknowledged)));

            row = infoSheet.CreateRow(rowNumber++);
            row.CreateCell(0).SetCellValue(string.Empty);
            row.CreateCell(1).SetCellValue(string.Empty);

            row.CreateCell(0).SetCellValue("Request Start:");
            c = (XSSFCell)row.GetCell(0);
            c.CellStyle = style2;
            c.CellStyle.SetFont(font);
            row.CreateCell(1).SetCellValue(StartDate.ToString());

            row = infoSheet.CreateRow(rowNumber++);
            row.CreateCell(0).SetCellValue("Request End:");
            c = (XSSFCell)row.GetCell(0);
            c.CellStyle = style2;
            c.CellStyle.SetFont(font);
            row.CreateCell(1).SetCellValue(EndDate.ToString());

            for (int i = 0; i <= 2; i++)
            {
                infoSheet.AutoSizeColumn(i);
            }


            MemoryStream output = new MemoryStream();
            workbook.Write(output);
            return File(output.ToArray(), "application/vnd.ms-excel", "UpassEvents.xlsx");
        }

        #endregion

        #region Private Methods
        private void setFileViewBags()
        {
            StartDate = (DateTime)Session["StartDate"];
            EndDate = (DateTime)Session["EndDate"];
            RetrievedResult = GenListFromLog(StartDate, EndDate).ToList();
            RetrievedResult = UpdateRetrieved(Page);
            Session["RetrievedResult"] = RetrievedResult;

            if (!String.IsNullOrEmpty(InstitutionID))
            {
                var ni = Logs.GetNCSInfo(InstitutionID);
                ViewBag.Program = ni.ProgramId;
                ViewBag.Name = ni.Name;
                ViewBag.OrganizationId = ni.OrganizationId;
                ViewBag.ShortName = ni.ShortName;
            }
            if (SearchResult != null)
            {
                ViewBag.FufRequests = SearchResult.Sum(e => e.FufRequests);
                ViewBag.IufRequests = SearchResult.Sum(e => e.IufRequests);
                ViewBag.FcfRequests = SearchResult.Sum(e => e.FcfRequests);
                ViewBag.IcfRequests = SearchResult.Sum(e => e.IcfRequests);
                ViewBag.TotalErrors = SearchResult.Sum(e => e.Errors);
                ViewBag.TotalClearedErrors = SearchResult.Sum(e => e.ClearedErrors);
                ViewBag.TotalAcknowledged = SearchResult.Sum(e => e.Acknowledged);

                SearchResultPageNo = Page;
                ViewBag.SearchResult = SearchResult.ToPagedList(SearchResultPageNo, pageSize);
                ViewBag.CurrentSort = SearchResult_SortOrder;
            }
            else if (RetrievedResult != null)
            {

                ViewBag.FufRequests = RetrievedResult.Sum(e => e.FufRequests);
                ViewBag.IufRequests = RetrievedResult.Sum(e => e.IufRequests);
                ViewBag.FcfRequests = RetrievedResult.Sum(e => e.FcfRequests);
                ViewBag.IcfRequests = RetrievedResult.Sum(e => e.IcfRequests);
                ViewBag.TotalErrors = RetrievedResult.Sum(e => e.Errors);
                ViewBag.TotalClearedErrors = RetrievedResult.Sum(e => e.ClearedErrors);
                ViewBag.TotalAcknowledged = RetrievedResult.Sum(e => e.Acknowledged);

                RetrievedResultPageNo = Page;
                ViewBag.RetrievedResult = RetrievedResult.ToPagedList(RetrievedResultPageNo, pageSize);
                ViewBag.CurrentSort = RetrieveResult_SortOrder;
            }
        }

        private void setWSViewBags()
        {
            StartDate = (DateTime)Session["StartDate"];
            EndDate = (DateTime)Session["EndDate"];
            WSRetrievedResult = WSGenListFromLog(StartDate, EndDate).ToList();
            Session["WSRetrievedResult"] = WSRetrievedResult;

            if (!String.IsNullOrEmpty(InstitutionID))
            {
                var ni = Logs.GetNCSInfo(InstitutionID);
                ViewBag.Program = ni.ProgramId;
                ViewBag.Name = ni.Name;
                ViewBag.OrganizationId = ni.OrganizationId;
                ViewBag.ShortName = ni.ShortName;
            }
            if (WSSearchResult != null)
            {
                ViewBag.NewCard = WSSearchResult.Sum(r => r.NewCardRequests);
                ViewBag.TerminatedCard = WSSearchResult.Sum(r => r.TerminatedCardRequests);
                ViewBag.ReplacementCard = WSSearchResult.Sum(r => r.ReplacementCardRequests);
                ViewBag.SuspendCard = WSSearchResult.Sum(r => r.SuspendCardRequests);
                ViewBag.ResumeCard = WSSearchResult.Sum(r => r.ResumeCardRequests);
                ViewBag.WSTotalErrors = WSSearchResult.Sum(e => e.Errors);
                ViewBag.WSTotalClearedErrors = WSSearchResult.Sum(e => e.ClearedErrors);
                ViewBag.WSTotalAcknowledged = WSSearchResult.Sum(e => e.Acknowledged);

                WSSearchResultPageNo = Page;
                ViewBag.WSSearchResult = WSSearchResult.ToPagedList(WSSearchResultPageNo, pageSize);
                ViewBag.WSCurrentSort = WSSearchResult_SortOrder;
            }
            else if (WSRetrievedResult != null)
            {
                ViewBag.NewCard = WSRetrievedResult.Sum(r => r.NewCardRequests);
                ViewBag.TerminatedCard = WSRetrievedResult.Sum(r => r.TerminatedCardRequests);
                ViewBag.ReplacementCard = WSRetrievedResult.Sum(r => r.ReplacementCardRequests);
                ViewBag.SuspendCard = WSRetrievedResult.Sum(r => r.SuspendCardRequests);
                ViewBag.ResumeCard = WSRetrievedResult.Sum(r => r.ResumeCardRequests);
                ViewBag.WSTotalErrors = WSRetrievedResult.Sum(e => e.Errors);
                ViewBag.WSTotalClearedErrors = WSRetrievedResult.Sum(e => e.ClearedErrors);
                ViewBag.WSTotalAcknowledged = WSRetrievedResult.Sum(e => e.Acknowledged);

                WSRetrievedResultPageNo = Page;
                ViewBag.WSRetrievedResult = WSRetrievedResult.ToPagedList(WSRetrievedResultPageNo, pageSize);
                ViewBag.WSCurrentSort = WSRetrieveResult_SortOrder;
            }            
        }

        #endregion

    }
}
