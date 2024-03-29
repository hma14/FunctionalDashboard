﻿using System;
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
using System.Web.Configuration;
using System.IO;
using Rotativa.Options;
using MvcSiteMapProvider;
using System.Web.UI;
using System.Globalization;
using FastMember;
using System.Web.UI.WebControls;
using NPOI.HSSF.UserModel;
using NPOI.SS.UserModel;
using NPOI.XSSF.UserModel;
using System.Drawing;
using FunctionalDashboard.Dal;


namespace FunctionalDashboard.Controllers
{

    public class ProgramUpassController : BaseController
    {

        // Tab Files
        private IList<UpassProgramFile> RetrievedResult { get; set; }
        private IList<UpassProgramWebService> WSRetrievedResult { get; set; }

        private IList<UpassProgramFile> SearchResult { get; set; }
        private IList<UpassProgramWebService> WSSearchResult { get; set; }
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

        public ActionResult Files(string institutionID, DateTime? startDate, DateTime? endDate, int? page, bool? refresh)
        {
            SetDateRange(startDate, endDate);

            if (!String.IsNullOrEmpty(institutionID))
            {
                InstitutionID = institutionID;
                Session["InstitutionID"] = institutionID;
            }
            else if (!String.IsNullOrEmpty((string)Session["InstitutionID"]))
            {
                InstitutionID = (string)Session["InstitutionID"];
            }

            if (page != null)
            {
                Page = (int)page;
            }
            if (Page == 0)
            {
                Page = 1;
            }

            StartDate = (DateTime)Session["StartDate"];
            EndDate = (DateTime)Session["EndDate"];
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

        public PartialViewResult UpdateRetrievedResult(DateTime? startDate, DateTime? endDate, int? page, string sortOrder)
        {
            StartDate = (DateTime)Session["StartDate"];
            EndDate = (DateTime)Session["EndDate"];

            if (!String.IsNullOrEmpty(sortOrder))
            {
                RetrieveResult_SortOrder = sortOrder;
            }
            ViewBag.CurrentSort = RetrieveResult_SortOrder;

            SetDateRange(startDate, endDate);

            if (page != null)
            {
                Page = (int)page;
            }
            Session["StartDate"] = StartDate;
            Session["EndDate"] = EndDate;
            Session["Keyword"] = CurrentSearchKeyword;

            setFileViewBags(page);
            setWSViewBags();

            return PartialView("_PartialFiles", null);
        }

        public IList<UpassProgramFile> UpdateRetrieved(int? page)
        {
            if (RetrievedResult == null)
            {
                RetrievedResult = (List<UpassProgramFile>)Session["RetrievedResult"];
            }
            var entries = from entry in RetrievedResult
                          select entry;

            if (page == null)
            {
                ViewBag.DateTimeStartSortParm = RetrieveResult_SortOrder == "DateTimeStart" ? "DateTimeStart_desc" : "DateTimeStart";
                ViewBag.FileNameSortParm = RetrieveResult_SortOrder == "FileName" ? "FileName_desc" : "FileName";
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

        public PartialViewResult UpdateSearchResult(int? page, string sortOrder)
        {
            if (!String.IsNullOrEmpty(sortOrder))
            {
                SearchResult_SortOrder = sortOrder;
            }

            ViewBag.CurrentSort = SearchResult_SortOrder;

            var entries = from entry in SearchResult
                          select entry;

            if (page == null)
            {
                ViewBag.DateTimeStartSortParm = SearchResult_SortOrder == "DateTimeStart" ? "DateTimeStart_desc" : "DateTimeStart";
                ViewBag.FileNameSortParm = SearchResult_SortOrder == "FileName" ? "FileName_desc" : "FileName";
                ViewBag.RequestsSortParm = SearchResult_SortOrder == "Requests" ? "Requests_desc" : "Requests";
                ViewBag.StatusSortParm = SearchResult_SortOrder == "Status" ? "Status_desc" : "Status";
            }

            switch (SearchResult_SortOrder)
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
                case "Requests_desc":
                    entries = entries.OrderByDescending(s => s.Requests);
                    break;
                case "Requests":
                    entries = entries.OrderBy(s => s.Requests);
                    break;
                case "Status_desc":
                    entries = entries.OrderByDescending(s => s.Errors);
                    break;
                case "Status":
                    entries = entries.OrderBy(s => s.Errors);
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
            Session["Keyword"] = CurrentSearchKeyword;

            setFileViewBags();
            setWSViewBags();

            return PartialView("_PartialFiles", null);

        }

        private IEnumerable<UpassProgramFile> GenListFromLog(DateTime? startDate, DateTime? endDate)
        {
            NcsInfo ret = null;
            if (Logs.GeneralLog == null || Logs.GeneralLog.Count() == 0)
            {
                Logs.GeneralLog = Logs.CreateGeneralEventLog();
            }
            var entries = Logs.GeneralLog
                .Where(x => x.InstitutionID == InstitutionID &&
                            !String.IsNullOrEmpty(x.URI) &&
                            (x.URI.ToUpper().Contains("IUF_") ||
                             x.URI.ToUpper().Contains("ICF_") ||
                             x.URI.ToUpper().Contains("FUF_") ||
                             x.URI.ToUpper().Contains("FCF_") ||
                             x.URI.Contains(PROGRAM_ID.UPASS)) &&
                             !String.IsNullOrEmpty(x.FileName) &&
                             x.FileName.Contains(".") && 
                            x.URIType == "sFTP" &&                           
                            x.ProgramID == PROGRAM_ID.UPASS &&
                            x.Environment.ToUpper() == HomeController.CurrentEnvironment.ToUpper() &&
                            x.ProcessDatetime >= StartDate &&
                            x.ProcessDatetime <= EndDate)
                .OrderByDescending(x => x.ProcessDatetime)
                .GroupBy(x => new { x.FileName} )
                .Select(g => new UpassProgramFile
                {
                    ID = g.First().ID,
                    Level = g.First().Level,
                    InstitutionID = g.First().InstitutionID,
                    Institution = (ret = Logs.GetNCSInfo(g.First().InstitutionID)) != null ? ret.Name : null,
                    DateStart = g.First().ProcessDatetime,
                    NCSCustomerID = ret != null ? ret.OrganizationId : 0,
                    Program = g.First().ProgramID,
                    Category = g.First().Category,
                    URI = g.First().URI,
                    FileName = g.Key.FileName,
                    //UniqueParticipantID = g.First().UniqueParticipantId,

                    Files = g.Select(f => new File_Info
                    {
                        Event = f.Event,
                        EventID = f.EventID,
                        UniqueParticipantID = f.UniqueParticipantId,
                        ProcessTime = f.ProcessDatetime,
                        LogLevel = f.Level,
                    }).ToList(),

                    Name = ret != null ? ret.Name : null,
                    OrganizationId = ret != null ? ret.OrganizationId : 0,
                    ShortName = ret != null ? ret.ShortName : null,
                    Requests = g.Where(e => e.UniqueParticipantId != null).Count(),
                    ProcessTime = g.First().ProcessDatetime,
                    ErrorDescr = g.First().ProcessErrorDescr ,
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
                    RetrievedResult = (List<UpassProgramFile>)Session["RetrievedResult"];
                }
                SearchResult = RetrievedResult.Where(s => s.FileName != null && s.FileName.ToUpper().Contains(fileName.Trim().ToUpper())).ToList();
            }
            else
            {
                SearchResult = null;
            }

            CurrentSearchKeyword = string.Format(" File Name contains '{0}'", fileName);
            Session["Keyword"] = CurrentSearchKeyword;

            setFileViewBags();
            setWSViewBags();

            return PartialView("_PartialFiles", null);
        }

        public PartialViewResult SearchUniqueParticipantID(int? page, bool? refresh, string uniqueParticipantID)
        {
            if (!String.IsNullOrEmpty(uniqueParticipantID))
            {
                List<UpassProgramFile> lst = new List<UpassProgramFile>();
                if (RetrievedResult == null)
                {
                    RetrievedResult = (List<UpassProgramFile>)Session["RetrievedResult"];
                }
                foreach (var e in RetrievedResult)
                {
                    UpassProgramFile t = new UpassProgramFile();
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
            CurrentSearchKeyword = string.Format(" UniqueParticipantID contains '{0}'", uniqueParticipantID);
            Session["Keyword"] = CurrentSearchKeyword;

            setFileViewBags();
            setWSViewBags();

            return PartialView("_PartialFiles", null);
        }

        [OutputCache(Duration = 3600, Location = OutputCacheLocation.Client, NoStore = true)]
        public ActionResult GetFiles(long? dateStartTicks, string uri)
        {         
            IList<UpassProgramFile> result;
            DateTime dateStart = new DateTime((long)dateStartTicks);
            if (SearchResult == null)
            {
                if (RetrievedResult == null)
                {
                    RetrievedResult = (List<UpassProgramFile>)Session["RetrievedResult"];
                }
                result = RetrievedResult.Where(x => x.DateStart == dateStart && x.FileName == uri).ToList();
            }
            else
            {
                result = SearchResult.Where(x => x.DateStart == dateStart && x.FileName == uri).ToList();                
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

            // Clear previous static data if it holds
            SearchResult = null;
            WSSearchResult = null;

            setFileViewBags();
            setWSViewBags();

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
            ViewBag.WSCurrentSort = WSRetrieveResult_SortOrder;

            SetDateRange(startDate, endDate);

            if (page != null)
            {
                Page = (int)page;
            }

            Session["StartDate"] = StartDate;
            Session["EndDate"] = EndDate;
            Session["Keyword"] = WSCurrentSearchKeyword;

            setFileViewBags(page);
            setWSViewBags(page, sortOrderWS);
            

            return PartialView("_PartialWS", null);
        }

        public IList<UpassProgramWebService> WSUpdateRetrieved(string sortOrder, int? page)
        {
            if (WSRetrievedResult == null)
            {
                WSRetrievedResult = (List<UpassProgramWebService>)Session["WSRetrievedResult"];
            }
            var entries = from entry in WSRetrievedResult
                          select entry;

            if (page == null)
            {
                ViewBag.WSDateTimeStartSortParm = WSRetrieveResult_SortOrder == "DateTimeStart" ? "DateTimeStart_desc" : "DateTimeStart";
                ViewBag.CategorySortParm = WSRetrieveResult_SortOrder == "Category" ? "Category_desc" : "Category";
                ViewBag.EventSortParm = WSRetrieveResult_SortOrder == "Event" ? "Event_desc" : "Event";
                ViewBag.GUIDSortParm = WSRetrieveResult_SortOrder == "GUID" ? "GUID_desc" : "GUID";
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

            ViewBag.WSCurrentSort = WSSearchResult_SortOrder;

            var entries = from entry in WSSearchResult
                          select entry;

            if (page == null)
            {
                ViewBag.DateTimeStartSortParm = WSSearchResult_SortOrder == "DateTimeStart" ? "DateTimeStart_desc" : "DateTimeStart";
                ViewBag.CategorySortParm = WSSearchResult_SortOrder == "Category" ? "Category_desc" : "Category";
                ViewBag.EventSortParm = WSSearchResult_SortOrder == "Event" ? "Event_desc" : "Event";
                ViewBag.GUIDSortParm = WSSearchResult_SortOrder == "GUID" ? "GUID_desc" : "GUID";

                ViewBag.StatusSortParm = WSSearchResult_SortOrder == "Status" ? "Status_desc" : "Status";


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
            }

            if (page != null)
            {
                Page = (int)page;
            }
            
            WSSearchResult = entries.ToList();

            setFileViewBags();
            setWSViewBags();
            Session["WSKeyword"] = WSCurrentSearchKeyword;

            return PartialView("_PartialWS", null);

        }

        private IEnumerable<UpassProgramWebService> WSGenListFromLog(DateTime? startDate, DateTime? endDate)
        {
            NcsInfo ret = null;
            if (Logs.GeneralLog == null || Logs.GeneralLog.Count() == 0)
            {
                Logs.GeneralLog = Logs.CreateGeneralEventLog();
            }            
            var entries = Logs.GeneralLog
                .Where(x => x.ProgramID == PROGRAM_ID.UPASS &&                            
                            x.Environment.ToUpper() == HomeController.CurrentEnvironment.ToUpper() &&
                            x.ProcessDatetime >= startDate &&
                            x.ProcessDatetime <= endDate &&
                            x.URIType != "sFTP" &&
                            x.InstitutionID == InstitutionID )
                .OrderByDescending(x => x.ProcessDatetime)
                .GroupBy(x => new { x.ProgramID, x.InstitutionID, x.CategoryID, x.GUID })
                .Select(g => new UpassProgramWebService
                {
                    ID = g.First().ID,
                    Level = g.First().Level,
                    TaskID = g.First().TaskID,
                    StateID = g.First().StateID,
                    InstitutionID = !String.IsNullOrEmpty(g.Key.InstitutionID) ? g.Key.InstitutionID : null,
                    Institution = (ret = Logs.GetNCSInfo(g.Key.InstitutionID)) != null ? ret.Name : null,
                    DateStart = g.First().ProcessDatetime,
                    NCSCustomerID = ret != null ? ret.OrganizationId : 0,
                    Program = g.Key.ProgramID,
                    URI = g.First().URI,
                    URIType = g.First().URIType,
                    CSN = g.First().CardSerialNumber,
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

                    ElectBenefitRequests = g.Where(e => e.CategoryID == CATEGORY_ID_WEBSERVICES.ELECT_BENEFIT).Count(),
                    WaiveBenefitRequests = g.Where(e => e.CategoryID == CATEGORY_ID_WEBSERVICES.WAIVE_BENEFIT).Count(),
                    LinkCardRequests = g.Where(e => e.CategoryID == CATEGORY_ID_WEBSERVICES.LINK_CARD).Count(),
                    UnlinkCardRequests = g.Where(e => e.CategoryID == CATEGORY_ID_WEBSERVICES.UNLINK_CARD).Count(),
                    WebServiceRequests = g.Where(e => e.CategoryID == CATEGORY_ID_WEBSERVICES.WEB_SERVICES).Count(),
                    OtherRequests = g.Where(c => !(c.CategoryID == CATEGORY_ID_WEBSERVICES.WAIVE_BENEFIT ||
                                                    c.CategoryID == CATEGORY_ID_WEBSERVICES.ELECT_BENEFIT ||
                                                    c.CategoryID == CATEGORY_ID_WEBSERVICES.LINK_CARD ||
                                                    c.CategoryID == CATEGORY_ID_WEBSERVICES.UNLINK_CARD ||
                                                    c.CategoryID == CATEGORY_ID_WEBSERVICES.WEB_SERVICES)).Count(),

                    ErrorDescr = g.First().ProcessErrorDescr,
                    StackTrace = g.First().StackTrace,
                    Errors = g.Where(e => e.Level == EVENT_STATUS.ERROR || e.Level == EVENT_STATUS.WARNING).Count(),
                    ClearedErrors = g.Where(c => c.Level == EVENT_STATUS.CLEARED).Count(),
                    Acknowledged = g.Where(a => a.Level == EVENT_STATUS.ACKNOWLEDGED).Count(),

                });

            return entries;
        }

        public PartialViewResult WSSearchGUID(int? page, bool? refresh, string guid)
        {
            if (!String.IsNullOrEmpty(guid))
            {
                List<UpassProgramWebService> lst = new List<UpassProgramWebService>();
                if (WSRetrievedResult == null)
                {
                    WSRetrievedResult = (List<UpassProgramWebService>)Session["WSRetrievedResult"];
                }
                foreach (var e in WSRetrievedResult)
                {
                    UpassProgramWebService t = new UpassProgramWebService();
                    List<Event_ID> fi = new List<Event_ID>();
                    foreach (var f in e.Events)
                    {
                        if (f.GUID != null && f.GUID.ToUpper().Contains(guid.Trim().ToUpper()))
                        {
                            fi.Add(f);
                        }
                    }
                    if (fi.Count() > 0)
                    {
                        t = e;
                        t.Events = fi;
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

            if (page != null)
            {
                Page = (int)page;
            }
            
            WSCurrentSearchKeyword = string.Format(" GUID contains '{0}'", guid);
            Session["WSKeyword"] = WSCurrentSearchKeyword;

            //setFileViewBags();
            setWSViewBags();

            return PartialView("_PartialWS", null);
        }

        public PartialViewResult WSSearchCSN(DateTime? startDate, DateTime? endDate, int? page, bool? refresh, string CSN)
        {
            if (!String.IsNullOrEmpty(CSN))
            {
                List<UpassProgramWebService> lst = new List<UpassProgramWebService>();
                if (WSRetrievedResult == null)
                {
                    WSRetrievedResult = (List<UpassProgramWebService>)Session["WSRetrievedResult"];
                }
                foreach (var e in WSRetrievedResult)
                {
                    UpassProgramWebService t = new UpassProgramWebService();
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
            
            WSCurrentSearchKeyword = string.Format(" Card Serial Number contains '{0}'", CSN);
            Session["WSKeyword"] = WSCurrentSearchKeyword;

            //setFileViewBags();
            setWSViewBags();

            return PartialView("_PartialWS", null);
        }

        [OutputCache(Duration = 3600, Location = OutputCacheLocation.Client, NoStore = true)]
        public ActionResult GetEvents(long ID)
        {
            IList<UpassProgramWebService> result;
            if (WSSearchResult == null)
            {
                if (WSRetrievedResult == null)
                {
                    WSRetrievedResult = (List<UpassProgramWebService>)Session["WSRetrievedResult"];
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
            if (SearchResult != null)
            {
                return new Rotativa.ActionAsPdf("GetFileView", SearchResult)
                {
                    //PageSize = Size.A4,
                    PageOrientation = Rotativa.Options.Orientation.Landscape,
                    PageMargins = { Left = 5, Right = 5 },
                    FileName = "ProgramUpassFiles.pdf",
                };
            }
            else
            {
                if (RetrievedResult == null)
                {
                    RetrievedResult = (List<UpassProgramFile>)Session["RetrievedResult"];
                }
                return new Rotativa.ActionAsPdf("GetFileView", RetrievedResult)
                {
                    //PageSize = Size.A4,
                    PageOrientation = Rotativa.Options.Orientation.Landscape,
                    PageMargins = { Left = 5, Right = 5 },
                    FileName = "ProgramUpassFiles.pdf",
                };
            }
        }

        public ActionResult ExportWSPDF()
        {
            return new Rotativa.ActionAsPdf("GetWSView")
            {
                //PageSize = Size.A4,
                PageOrientation = Rotativa.Options.Orientation.Landscape,
                PageMargins = { Left = 5, Right = 5 }
            };
        }

        public ActionResult GetWSView()
        {
            setWSViewBags();
            ViewBag.WSKeyword = WSCurrentSearchKeyword;
            //ViewBag.WSRetrievedResult = WSRetrievedResult;
            if (WSSearchResult != null && WSSearchResult.Count() > 0)
            {
                ViewBag.WSSearchResult = WSSearchResult;
                ViewBag.WSKeyword = WSCurrentSearchKeyword;
            }

            return View();
        }

        #endregion

        #region ExportFileExcel - Export Files to Excel


        public FileResult ExportFileExcel()
        {
            StartDate = (DateTime)Session["StartDate"];
            EndDate = (DateTime)Session["EndDate"];
            if (RetrievedResult == null)
            {
                RetrievedResult = (List<UpassProgramFile>)Session["RetrievedResult"];
            }

            var model = SearchResult != null ? SearchResult : RetrievedResult;
            var workbook = new XSSFWorkbook();
            var sheet = workbook.CreateSheet("Upass Files");

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

            row = sheet.CreateRow(rowNumber++);
            row.CreateCell(0).SetCellValue(string.Empty);
            row.CreateCell(1).SetCellValue(string.Empty);

            row = infoSheet.CreateRow(rowNumber++);
            row.CreateCell(0).SetCellValue("Total Eligibility Requests");
            c = (XSSFCell)row.GetCell(0);
            c.CellStyle = style2;
            c.CellStyle.SetFont(font);
            row.CreateCell(1).SetCellValue(model.Sum(e => e.Requests));

            row = infoSheet.CreateRow(rowNumber++);
            row.CreateCell(0).SetCellValue("Errors (Acknowledged or Cleared)");
            c = (XSSFCell)row.GetCell(0);
            c.CellStyle = style2;
            c.CellStyle.SetFont(font);
            row.CreateCell(1).SetCellValue(String.Format("{0} ({1})", model.Sum(e => e.Errors), model.Sum(e => e.ClearedErrors) + model.Sum(e => e.Acknowledged)));

            row = infoSheet.CreateRow(rowNumber++);
            row.CreateCell(0).SetCellValue(string.Empty);
            row.CreateCell(1).SetCellValue(string.Empty);

            row = infoSheet.CreateRow(rowNumber++);
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

        #region ExportWSExcel - Export Web Services to Excel


        public FileResult ExportWSExcel()
        {
            StartDate = (DateTime)Session["StartDate"];
            EndDate = (DateTime)Session["EndDate"];
            if (WSRetrievedResult == null)
            {
                WSRetrievedResult = (List<UpassProgramWebService>)Session["WSRetrievedResult"];
            }

            var model = WSSearchResult != null ? WSSearchResult : WSRetrievedResult;
            var workbook = new XSSFWorkbook();
            var sheet = workbook.CreateSheet("Upass WebServices");

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
                row.CreateCell(5).SetCellValue(String.Format("{0} {1} ({2})  {3}",  datarow.Level,
                                                                                    datarow.Errors,
                                                                                    datarow.Acknowledged + datarow.ClearedErrors,
                                                                                    datarow.ErrorDescr));

                foreach (var f in datarow.Events)
                {
                    row = sheet.CreateRow(rowNumber++);
                    row.CreateCell(2).SetCellValue(String.Format("          - {0}   ({1})", f.Event, f.EventID));
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
            row.CreateCell(0).SetCellValue("Link Card Requests");
            c = (XSSFCell)row.GetCell(0);
            c.CellStyle = style2;
            c.CellStyle.SetFont(font);
            row.CreateCell(1).SetCellValue(model.Sum(e => e.LinkCardRequests));

            row = infoSheet.CreateRow(rowNumber++);
            row.CreateCell(0).SetCellValue("Unlink Card Requests");
            c = (XSSFCell)row.GetCell(0);
            c.CellStyle = style2;
            c.CellStyle.SetFont(font);
            row.CreateCell(1).SetCellValue(model.Sum(e => e.UnlinkCardRequests));

            row = infoSheet.CreateRow(rowNumber++);
            row.CreateCell(0).SetCellValue("Web Services Requests");
            c = (XSSFCell)row.GetCell(0);
            c.CellStyle = style2;
            c.CellStyle.SetFont(font);
            row.CreateCell(1).SetCellValue(model.Sum(e => e.WebServiceRequests));

            row = infoSheet.CreateRow(rowNumber++);
            row.CreateCell(0).SetCellValue("Other Requests");
            c = (XSSFCell)row.GetCell(0);
            c.CellStyle = style2;
            c.CellStyle.SetFont(font);
            row.CreateCell(1).SetCellValue(model.Sum(e => e.OtherRequests));

            row = infoSheet.CreateRow(rowNumber++);
            row.CreateCell(0).SetCellValue("Errors (Acknowledged or Cleared)");
            c = (XSSFCell)row.GetCell(0);
            c.CellStyle = style2;
            c.CellStyle.SetFont(font);
            row.CreateCell(1).SetCellValue(String.Format("{0} ({1})", model.Sum(e => e.Errors), model.Sum(e => e.ClearedErrors) + model.Sum(e => e.Acknowledged)));

            row = infoSheet.CreateRow(rowNumber++);
            row.CreateCell(0).SetCellValue(string.Empty);
            row.CreateCell(1).SetCellValue(string.Empty);

            row = infoSheet.CreateRow(rowNumber++);
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

        private void setFileViewBags(int? page = null)
        {
            StartDate = (DateTime)Session["StartDate"];
            EndDate = (DateTime)Session["EndDate"];
            ViewBag.Program = PROGRAM_ID.UPASS;
            NcsInfo ret = Logs.GetNCSInfo(InstitutionID);
            if (ret != null)
            {
                ViewBag.Institution = ret.Name;
                ViewBag.NCSCustomerID = ret.OrganizationId;
                ViewBag.ShortName = ret.ShortName;
            }

            RetrievedResult = GenListFromLog(StartDate, EndDate).ToList();
            RetrievedResult = UpdateRetrieved(page);
            Session["RetrievedResult"] = RetrievedResult;
            if (SearchResult != null)
            {
                ViewBag.TotalEligibilityRequests = SearchResult.Sum(e => e.Requests);
                ViewBag.TotalErrors = SearchResult.Sum(e => e.Errors);
                ViewBag.TotalClearedErrors = SearchResult.Sum(e => e.ClearedErrors);
                ViewBag.TotalAcknowledged = SearchResult.Sum(e => e.Acknowledged);

                SearchResultPageNo = Page;
                ViewBag.SearchResult = SearchResult.ToPagedList(SearchResultPageNo, pageSize);
            }
            else if (RetrievedResult != null)
            {
                ViewBag.TotalEligibilityRequests = RetrievedResult.Sum(e => e.Requests);
                ViewBag.TotalErrors = RetrievedResult.Sum(e => e.Errors);
                ViewBag.TotalClearedErrors = RetrievedResult.Sum(e => e.ClearedErrors);
                ViewBag.TotalAcknowledged = RetrievedResult.Sum(e => e.Acknowledged);


                RetrievedResultPageNo = Page;
                ViewBag.RetrievedResult = RetrievedResult.ToPagedList(RetrievedResultPageNo, pageSize);
            }
        }

        private void setWSViewBags(int? page = null, string sortOrder = null)
        {
            StartDate = (DateTime)Session["StartDate"];
            EndDate = (DateTime)Session["EndDate"];
            ViewBag.Program = PROGRAM_ID.UPASS;
            NcsInfo ret = Logs.GetNCSInfo(InstitutionID);
            if (ret != null)
            {
                ViewBag.Institution = ret.Name;
                ViewBag.NCSCustomerID = ret.OrganizationId;
                ViewBag.ShortName = ret.ShortName;
            }

            WSRetrievedResult = WSGenListFromLog(StartDate, EndDate).ToList();
            WSRetrievedResult = WSUpdateRetrieved(sortOrder, page);
            Session["WSRetrievedResult"] = WSRetrievedResult;
            if (WSSearchResult != null)
            {
                ViewBag.WaiveBenefitRequests = WSSearchResult.Sum(e => e.WaiveBenefitRequests);
                ViewBag.ElectBenefitRequests = WSSearchResult.Sum(e => e.ElectBenefitRequests);
                ViewBag.LinkCardRequests = WSSearchResult.Sum(e => e.LinkCardRequests);
                ViewBag.UnlinkCardRequests = WSSearchResult.Sum(e => e.UnlinkCardRequests);
                ViewBag.WebServiceRequests = WSSearchResult.Sum(e => e.WebServiceRequests);
                ViewBag.OtherRequests = WSSearchResult.Sum(e => e.OtherRequests);
                ViewBag.WSTotalErrors = WSSearchResult.Sum(e => e.Errors);
                ViewBag.WSTotalClearedErrors = WSSearchResult.Sum(e => e.ClearedErrors);
                ViewBag.WSTotalAcknowledged = WSSearchResult.Sum(e => e.Acknowledged);

                WSSearchResult = WSSearchResult.OrderByDescending(x => x.DateStart).ToList();
                WSSearchResultPageNo = Page;
                ViewBag.WSSearchResult = WSSearchResult.ToPagedList(WSSearchResultPageNo, pageSize);
            }
            else if (WSRetrievedResult != null)
            {
                ViewBag.WaiveBenefitRequests = WSRetrievedResult.Sum(e => e.WaiveBenefitRequests);
                ViewBag.ElectBenefitRequests = WSRetrievedResult.Sum(e => e.ElectBenefitRequests);
                ViewBag.LinkCardRequests = WSRetrievedResult.Sum(e => e.LinkCardRequests);
                ViewBag.UnlinkCardRequests = WSRetrievedResult.Sum(e => e.UnlinkCardRequests);
                ViewBag.WebServiceRequests = WSRetrievedResult.Sum(e => e.WebServiceRequests);
                ViewBag.OtherRequests = WSRetrievedResult.Sum(e => e.OtherRequests);
                ViewBag.WSTotalErrors = WSRetrievedResult.Sum(e => e.Errors);
                ViewBag.WSTotalClearedErrors = WSRetrievedResult.Sum(e => e.ClearedErrors);
                ViewBag.WSTotalAcknowledged = WSRetrievedResult.Sum(e => e.Acknowledged);

                //WSRetrievedResult = WSRetrievedResult.OrderByDescending(x => x.DateStart).ToList();
                WSRetrievedResultPageNo = Page;
                ViewBag.WSRetrievedResult = WSRetrievedResult.ToPagedList(WSRetrievedResultPageNo, pageSize);
            }
        }

      
        #endregion



    }
}
