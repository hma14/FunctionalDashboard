using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web.Mvc;
using FunctionalDashboard.Models;
using System.Data;
using FunctionalDashboard.Dal;
using FunctionalDashboard.Dal.DataEntity;
using PagedList;
using FunctionalDashboard.ViewModels;
using System.Web.Configuration;
using System.Web.UI;
using EventSentryStatus = FunctionalDashboard.Models.EventSentryStatus;



namespace FunctionalDashboard.Controllers
{

    public class HomeController : BaseController
    {
        // Tab Monitor
        private static IList<OverviewErrors> _filteredLog1 = null;
        private static IList<LogErrors> _filteredLog2 = null;
        private static IList<WebServiceOperationStatus> _filteredLog3 = null;
        private static IList<ErrorsBase> _filteredLog4 = null;


        private static int _pageNumber1 = 1;
        private static int _pageNumber2 = 1;
        private static int _pageNumber3 = 1;
        private static int _pageNumber4 = 1;

        // Tab Files
        private static IList<PpassFileErrors> _ffilteredLog1 = null;
        private static IList<UpassFileErrors> _ffilteredLog2 = null;
        private static IList<LogErrors> _ffilteredLog3 = null;

        private static int _fpageNumber1 = 1;
        private static int _fpageNumber2 = 1;
        private static int _fpageNumber3 = 1;

        // Tab WebService
        private static IList<PpassWebServiceErrors> _wfilteredLog1 = null;
        private static IList<UpassWebServiceErrors> _wfilteredLog2 = null;
        private static IList<WebServiceOperationStatus> _wfilteredLog3 = null;

        private static int _wpageNumber1 = 1;
        private static int _wpageNumber2 = 1;
        private static int _wpageNumber3 = 1;

        // Tab Application
        private static IList<ErrorsBase> _afilteredLog1 = null;
        private static IList<ErrorsBase> _afilteredLog2 = null;
        private static IList<ErrorsBase> _afilteredLog3 = null;
        private static IList<GeneralEventLog> _syncUtilityGeneralLog = null;


        private static int _apageNumber1 = 1;
        private static int _apageNumber2 = 1;
        private static int _apageNumber3 = 1;



        // Sort Order
        public static string _sortOrder = string.Empty;

        // Envionment for OverView Errors to select
        private static string _environment = WebConfigurationManager.AppSettings["Environment"];

        // Default page size
        const int PageSize = 5;
        public static int Page { get; set; }


        //public static string CurrentEnvironment { get; set; }
        public static Dictionary<string, string> CurrentMode = new Dictionary<string, string>();

        public static string UserFullName { get; set; }


        #region Index


        public ActionResult Index(bool? refresh, bool? refreshSLTAlerts, string id)
        {
            if (refresh != null)
            {
                try
                {
                    OnRefresh();
                    //Logs.RefreshCachedNcsInfo();
                }
                catch (Exception ex)
                {
                    ViewBag.ErrorMsg = ex.Message;
                    return PartialView("_Error", null);
                }
            }

            if (Session["StartDate"] != null && Session["EndDate"] != null)
            {
                StartDate = (DateTime)Session["StartDate"];
                EndDate = (DateTime)Session["EndDate"];
            }
            else
            {
                if (Constants.StartDate == DateTime.MinValue)
                {
                    Constants.StartDate = DateTime.Today.AddDays(Convert.ToInt16(WebConfigurationManager.AppSettings["Days"]));
                }

                if (StartDate == DateTime.MinValue)
                {
                    Session["StartDate"] = StartDate = Constants.StartDate;
                }

                if (EndDate == DateTime.MinValue)
                {
                    Session["EndDate"] = Logs.EndDate = EndDate = DateTime.Now;
                }

                Logs.StartDate = Constants.StartDate;
            }




            if (id != null && id != _environment)
            {
                _environment = id;
            }

            CurrentEnvironment = _environment;


            // Get current Server from which EventLog is being monitored and display
            SetCurrentServer();

            ViewBag.Status = CurrentEnvironment;
            ViewBag.startDate = StartDate;
            ViewBag.endDate = EndDate;
            Page = 1;

            // sort by DateStart on descendent
            try
            {
                _filteredLog1 = GenListFromLog1(StartDate, EndDate).OrderByDescending(x => x.DateStart).ToList();
                _filteredLog2 = GenListFromLog2(StartDate, EndDate).OrderByDescending(x => x.DateStart).ToList();
                _filteredLog3 = GenListFromLog3(StartDate, EndDate).OrderByDescending(x => x.DateStart).ToList();
            }
            catch (Exception ex)
            {
                ViewBag.ErrorMsg = ex.Message;
                return PartialView("_Error", null);
            }


            ViewBag.Partial1 = _filteredLog1.ToPagedList(Page, PageSize);
            ViewBag.Partial2 = _filteredLog2.ToPagedList(Page, PageSize);
            ViewBag.Partial3 = _filteredLog3.ToPagedList(Page, PageSize);
            ViewBag.Partial4 = RefreshSLTTrackingStatus().ToPagedList(_pageNumber4, PageSize);


            // sort by DateStart on descendent
            try
            {

                _ffilteredLog1 = FilesGenListFromLog1(StartDate, EndDate).OrderByDescending(x => x.DateStart).ToList();
                _ffilteredLog2 = FilesGenListFromLog2(StartDate, EndDate).OrderByDescending(x => x.DateStart).ToList();
                _ffilteredLog3 = FilesGenListFromLog3(StartDate, EndDate).OrderByDescending(x => x.DateStart).ToList();
            }
            catch (Exception ex)
            {
                ViewBag.ErrorMsg = ex.Message;
                return PartialView("_Error", null);
            }


            ViewBag.FilesPartial1 = _ffilteredLog1.ToPagedList(Page, PageSize);
            ViewBag.FilesPartial2 = _ffilteredLog2.ToPagedList(Page, PageSize);
            ViewBag.FilesPartial3 = _ffilteredLog3.ToPagedList(Page, PageSize);


            // sort by DateTime DESC
            try
            {
                _wfilteredLog1 = WSGenListFromLog1(StartDate, EndDate).OrderByDescending(x => x.DateStart).ToList();
                _wfilteredLog2 = WSGenListFromLog2(StartDate, EndDate).OrderByDescending(x => x.DateStart).ToList();
                _wfilteredLog3 = WSGenListFromLog3(StartDate, EndDate).OrderByDescending(x => x.DateStart).ToList();
            }
            catch (Exception ex)
            {
                ViewBag.ErrorMsg = ex.Message;
                return PartialView("_Error", null);
            }


            ViewBag.WSPartial1 = _wfilteredLog1.ToPagedList(Page, PageSize);
            ViewBag.WSPartial2 = _wfilteredLog2.ToPagedList(Page, PageSize);
            ViewBag.WSPartial3 = _wfilteredLog3.ToPagedList(Page, PageSize);

            // app tab 
            ViewBag.SyncUtilityLogs = SyncUtilityViewUpdate(StartDate, EndDate, "", null);

            // HHU on app tab
            _afilteredLog3 = AppGenListFromLog3(StartDate, EndDate).OrderByDescending(x => x.DateStart).ToList();
            ViewBag.AppPartial3 = _afilteredLog3.ToPagedList(Page, PageSize);

            // Get total memory used so far and set and display
            SetCurrentProcessMemorySize();

            return View();
        }
        #endregion

        public static void InitCurrentMode()
        {
            if (!CurrentMode.ContainsKey(ENVIRONMENT.Production.ToString()))
            {
                CurrentMode.Add(ENVIRONMENT.Production.ToString(), ENVIRONMENT.Production.ToString());
            }
            if (!CurrentMode.ContainsKey(ENVIRONMENT.Development.ToString()))
            {
                CurrentMode.Add(ENVIRONMENT.Development.ToString(), ENVIRONMENT.Development.ToString());
            }
            if (!CurrentMode.ContainsKey(ENVIRONMENT.ExtQA.ToString()))
            {
                CurrentMode.Add(ENVIRONMENT.ExtQA.ToString(), ENVIRONMENT.ExtQA.ToString());
            }
            if (!CurrentMode.ContainsKey(ENVIRONMENT.IntQA.ToString()))
            {
                CurrentMode.Add(ENVIRONMENT.IntQA.ToString(), ENVIRONMENT.IntQA.ToString());
            }
            if (!CurrentMode.ContainsKey(ENVIRONMENT.Staging.ToString()))
            {
                CurrentMode.Add(ENVIRONMENT.Staging.ToString(), ENVIRONMENT.Staging.ToString());
            }

        }

        #region SLT Alert Tracking

        public PartialViewResult SLTAlerts()
        {
            DateTime startDatetime = DateTime.Now;
            ViewBag.Partial4 = RefreshSLTTrackingStatus().ToPagedList(_pageNumber4, PageSize);
            DateTime endDatetime = Logs.EndDate = DateTime.Now;
            SLTAlertProcessTime = endDatetime - startDatetime;

            return PartialView("_PartialTabMonitorSLTAlerts", null);
        }

        public PartialViewResult SLTAlertsUpdatePartial(string sortOrder4, int? page)
        {
            if (page != null)
            {
                Page = (int)page;
            }
            try
            {
                ViewBag.Partial4 = SLTAlertsUpdate(sortOrder4, page);
            }
            catch (Exception ex)
            {
                ViewBag.ErrorMsg = ex.Message;
                return PartialView("_Error", null);
            }

            return PartialView("_PartialTabMonitorSLTAlerts", null);
        }

        public IPagedList<SLTTracking> SLTAlertsUpdate(string sortOrder, int? page)
        {
            if (page != null)
            {
                Page = (int)page;
            }
            if (Page == 0)
            {
                Page = 1;
            }

            _pageNumber4 = Page;
            var list = RefreshSLTTrackingStatus();
            if (!String.IsNullOrEmpty(sortOrder))
            {
                _sortOrder = sortOrder;
            }

            var entries = from entry in list
                          select entry;

            if (page == null)
            {
                ViewBag.ProgramSortParm = _sortOrder == "Program" ? "Program_desc" : "Program";
                ViewBag.InstitutionSortParm = _sortOrder == "Institution" ? "Institution_desc" : "Institution";
                ViewBag.CategorySortParm = _sortOrder == "Category" ? "Category_desc" : "Category";
                ViewBag.EventSortParm = _sortOrder == "Event" ? "Event_desc" : "Event";
                ViewBag.RuleSortParm = _sortOrder == "Rule" ? "Rule_desc" : "Rule";
                ViewBag.StatusSortParm = _sortOrder == "Status" ? "Status_desc" : "Status";
                ViewBag.SLTStartDatetimeSortParm = _sortOrder == "SLTStartDatetime" ? "SLTStartDatetime_desc" : "SLTStartDatetime";
                ViewBag.NextTriggerDatetimeSortParm = _sortOrder == "NextTriggertDatetime" ? "NextTriggertDatetime_desc" : "NextTriggertDatetime";


                switch (_sortOrder)
                {
                    case "Program_desc":
                        entries = entries.OrderByDescending(s => s.ProgramID);
                        break;
                    case "Program":
                        entries = entries.OrderBy(s => s.ProgramID);
                        break;
                    case "Institution_desc":
                        entries = entries.OrderByDescending(s => s.InstitutionID);
                        break;
                    case "Institution":
                        entries = entries.OrderBy(s => s.InstitutionID);
                        break;
                    case "Category_desc":
                        entries = entries.OrderByDescending(s => s.CategoryID);
                        break;
                    case "Category":
                        entries = entries.OrderBy(s => s.CategoryID);
                        break;
                    case "Event_desc":
                        entries = entries.OrderByDescending(s => s.EventID);
                        break;
                    case "Event":
                        entries = entries.OrderBy(s => s.EventID);
                        break;
                    case "Rule_desc":
                        entries = entries.OrderByDescending(s => s.RuleDescription);
                        break;
                    case "Rule":
                        entries = entries.OrderBy(s => s.RuleDescription);
                        break;
                    case "SLTStartDatetime_desc":
                        entries = entries.OrderByDescending(s => s.SLTStartDatetime);
                        break;
                    case "SLTStartDatetime":
                        entries = entries.OrderBy(s => s.SLTStartDatetime);
                        break;
                    case "NextTriggertDatetime_desc":
                        entries = entries.OrderByDescending(s => s.SLTBreachDatetime);
                        break;
                    case "NextTriggertDatetime":
                        entries = entries.OrderBy(s => s.SLTBreachDatetime);
                        break;
                    case "Status_desc":
                        entries = entries.OrderByDescending(s => s.Status);
                        break;
                    case "Status":
                        entries = entries.OrderBy(s => s.Status);
                        break;

                    default:
                        entries = entries.OrderByDescending(s => s.Status);
                        break;
                }
            }

            return entries.ToPagedList(_pageNumber4, PageSize);

        }

        private List<SLTTracking> RefreshSLTTrackingStatus(bool includeActive = false)
        {
            // Retrieve CPGFD_SLTTracking table
            DataAccess dataAccess = new DataAccess();
            List<SLTTracking> entry = new List<SLTTracking>();
            try
            {
                DataTable dt = dataAccess.SpRetrieveAllCPGFD_SLTTracking();

                entry = (from x in dt.AsEnumerable()
                         select new SLTTracking()
                         {
                             ID = long.Parse(x["ID"].ToString()),
                             SLTRuleID = int.Parse(x["SLTRuleID"].ToString()),
                             ProgramID = x["ProgramID"].ToString(),
                             InstitutionID = x["InstitutionID"].ToString(),
                             Institution = x["Institution"].ToString(),
                             Category = x["Category"].ToString(),
                             CategoryID = int.Parse(x["CategoryID"].ToString()),
                             Event = x["Event"].ToString(),
                             EventID = int.Parse(x["EventID"].ToString()),
                             RuleDescription = x["RuleDescription"].ToString(),
                             SLTStartDatetime = Convert.ToDateTime(x["SLTStartDatetime"]),
                             SLTWarningDatetime = Convert.ToDateTime(x["SLTWarningDatetime"]),
                             SLTBreachDatetime = Convert.ToDateTime(x["SLTBreachDatetime"]),
                             SLTCompleteDatetime = x["SLTCompleteDatetime"] != DBNull.Value ? Convert.ToDateTime(x["SLTCompleteDatetime"]) : (DateTime?)null,
                             Status = (TRACKING_STATUS)int.Parse(x["Status"].ToString()),
                         }).OrderByDescending(x => x.SLTBreachDatetime).ToList();
            }
            catch
            {
                throw;
            }
            if (!includeActive)
            {
                return entry.Where(x => x.Status != TRACKING_STATUS.Active).ToList();
            }
            return entry;
        }

        #endregion

        #region Tab Monitor

        public PartialViewResult MonitorUpdatePartial(DateTime? startDate, DateTime? endDate, string sortOrder, int? page)
        {
            SetDateRange(startDate, endDate);

            if (page != null)
            {
                Page = (int)page;
            }
            try
            {
                ViewBag.Partial1 = Update1(sortOrder, _pageNumber1);
                ViewBag.Partial2 = Update2(sortOrder, _pageNumber2);
                ViewBag.Partial3 = Update3(sortOrder, _pageNumber3);
            }
            catch (Exception ex)
            {
                ViewBag.ErrorMsg = ex.Message;
                return PartialView("_Error", null);
            }

            LoadCompleted = DateTime.Now;
            return PartialView("_PartialTabMonitor", null);
        }

        private IEnumerable<OverviewErrors> GenListFromLog1(DateTime? startDate, DateTime? endDate)
        {
            NcsInfo ret = null;

            if (Logs.GeneralLog == null || Logs.GeneralLog.Count() == 0)
            {
                Logs.GeneralLog = Logs.CreateGeneralEventLog();
            }

            if (Logs.GeneralLog == null)
            {

                throw new Exception("Logs.GeneralLog is null or empty!");
            }

            var entries = Logs.GeneralLog
                .Where(x => x.ProcessDatetime >= startDate &&
                            x.ProcessDatetime <= endDate &&
                            x.Environment.ToUpper() == _environment.ToUpper() &&
                            (x.Level == EVENT_STATUS.ERROR || x.Level == EVENT_STATUS.WARNING ||
                             x.Level == EVENT_STATUS.CLEARED || x.Level == EVENT_STATUS.ACKNOWLEDGED))
                .GroupBy(x => new { x.ProgramID, x.InstitutionID })
                .Select(g => new OverviewErrors
                {
                    InstitutionID = g.Key.InstitutionID,
                    Institution = (ret = Logs.GetNCSInfo(g.Key.InstitutionID)) != null ? ret.Name : null,
                    Event = g.First().Event,
                    EventID = g.First().EventID,
                    CategoryID = g.First().CategoryID,
                    NCSCustomerID = ret != null ? ret.OrganizationId : 0,
                    DateStart = g.First().ProcessDatetime,
                    Program = g.Key.ProgramID,
                    FileErrors = g.Where(f => f.URI != null && f.URIType == "sFTP" && f.Level == EVENT_STATUS.ERROR).Count(),
                    FilesClearedErrors = g.Where(f => f.URIType == "sFTP" && f.Level == EVENT_STATUS.CLEARED).Count(),
                    FilesAcknowledged = g.Where(f => f.URIType == "sFTP" && f.Level == EVENT_STATUS.ACKNOWLEDGED).Count(),
                    WebServiceErrors = g.Where(ws => ws.URIType != "sFTP" && (ws.Level == EVENT_STATUS.ERROR || ws.Level == EVENT_STATUS.WARNING)).Count(),
                    WSClearedErrors = g.Where(ws => ws.URIType != "sFTP" && ws.Level == EVENT_STATUS.CLEARED).Count(),
                    WSAcknowledged = g.Where(ws => ws.URIType != "sFTP" && ws.Level == EVENT_STATUS.ACKNOWLEDGED).Count(),
                    ApplicationErrors = 0, // g.Where(f => f.ProgramID == "APP").Count(),
                    AppClearedErrors = 0,
                    Active = ret != null ? ret.Active : false
                });

            return entries;
        }

        public IPagedList<OverviewErrors> Update1(string sortOrder, int? page)
        {
            if (page != null)
            {
                Page = (int)page;
            }
            if (Page == 0)
            {
                Page = 1;
            }

            _pageNumber1 = Page;
            _filteredLog1 = GenListFromLog1(StartDate, EndDate).ToList();

            if (!String.IsNullOrEmpty(sortOrder))
            {
                _sortOrder = sortOrder;
            }
            ViewBag.CurrentSort1 = _sortOrder;

            var entries = from entry in _filteredLog1
                          select entry;

            if (page == null)
            {
                ViewBag.ProgramSortParm = _sortOrder == "Program" ? "Program_desc" : "Program";
                ViewBag.InstitutionSortParm = _sortOrder == "Institution" ? "Institution_desc" : "Institution";
                ViewBag.NCSCustomerIDSortParm = _sortOrder == "NCSCustomerID" ? "NCSCustomerID_desc" : "NCSCustomerID";
                ViewBag.FileErrorsSortParm = _sortOrder == "FileErrors" ? "FileErrors_desc" : "FileErrors";
                ViewBag.WebServiceErrorsSortParm = _sortOrder == "WebServiceErrors" ? "WebServiceErrors_desc" : "WebServiceErrors";
                ViewBag.ApplicationErrorsSortParm = _sortOrder == "ApplicationErrors" ? "ApplicationErrors_desc" : "ApplicationErrors";
                ViewBag.ActiveSortParm = _sortOrder == "Active" ? "Active_desc" : "Active";


                switch (_sortOrder)
                {
                    case "Program_desc":
                        entries = entries.OrderByDescending(s => s.Program);
                        break;
                    case "Program":
                        entries = entries.OrderBy(s => s.Program);
                        break;
                    case "Institution_desc":
                        entries = entries.OrderByDescending(s => s.Institution);
                        break;
                    case "Institution":
                        entries = entries.OrderBy(s => s.Institution);
                        break;
                    case "NCSCustomerID_desc":
                        entries = entries.OrderByDescending(s => s.NCSCustomerID);
                        break;
                    case "NCSCustomerID":
                        entries = entries.OrderBy(s => s.NCSCustomerID);
                        break;
                    case "FileErrors_desc":
                        entries = entries.OrderByDescending(s => s.FileErrors);
                        break;
                    case "FileErrors":
                        entries = entries.OrderBy(s => s.FileErrors);
                        break;
                    case "WebServiceErrors_desc":
                        entries = entries.OrderByDescending(s => s.WebServiceErrors);
                        break;
                    case "WebServiceErrors":
                        entries = entries.OrderBy(s => s.WebServiceErrors);
                        break;
                    case "ApplicationErrors_desc":
                        entries = entries.OrderByDescending(s => s.ApplicationErrors);
                        break;
                    case "ApplicationErrors":
                        entries = entries.OrderBy(s => s.ApplicationErrors);
                        break;
                    case "Active_desc":
                        entries = entries.OrderByDescending(s => s.Active);
                        break;
                    case "Active":
                        entries = entries.OrderBy(s => s.Active);
                        break;
                    default:
                        entries = entries.OrderByDescending(s => s.DateStart);
                        break;
                }
            }

            return entries.ToPagedList(_pageNumber1, PageSize);

        }

        public PartialViewResult UpdatePartial1(string sortOrder1, int? page)
        {
            StartDate = (DateTime)Session["StartDate"];
            EndDate = (DateTime)Session["EndDate"];
            ViewBag.Partial1 = Update1(sortOrder1, page);
            ViewBag.Partial2 = _filteredLog2.ToPagedList(_pageNumber2, PageSize);
            ViewBag.Partial3 = _filteredLog3.ToPagedList(_pageNumber3, PageSize);
            return PartialView("_PartialTabMonitor", null);
        }

        private IEnumerable<LogErrors> GenListFromLog2(DateTime? startDate, DateTime endDate)
        {
            NcsInfo ret = null;
            if (Logs.GeneralLog == null || Logs.GeneralLog.Count() == 0)
            {
                Logs.GeneralLog = Logs.CreateGeneralEventLog();
            }

            var entries = Logs.GeneralLog
                .Where(x => x.ProcessDatetime >= startDate &&
                            x.ProcessDatetime <= endDate &&
                            x.Environment.ToUpper() == _environment.ToUpper() &&
                            (x.Level == EVENT_STATUS.ERROR || x.Level == EVENT_STATUS.WARNING ||
                             x.Level == EVENT_STATUS.CLEARED || x.Level == EVENT_STATUS.ACKNOWLEDGED) &&
                            x.URIType == "sFTP")
                .GroupBy(x => new { x.ProgramID, x.InstitutionID, x.CategoryID, x.EventID })
                .Select(g => new LogErrors
                {
                    ID = g.First().ID,
                    InstitutionID = g.Key.InstitutionID,
                    Institution = (ret = Logs.GetNCSInfo(g.Key.InstitutionID)) != null ? ret.Name : null,
                    URI = g.First().URI,
                    DateStart = g.First().ProcessDatetime,
                    Program = g.Key.ProgramID,
                    ErrorID = !String.IsNullOrEmpty(g.First().ProcessErrorID) ? int.Parse(g.First().ProcessErrorID) : 0,
                    ErrorDesc = g.First().ProcessErrorDescr,
                    Category = g.First().Category,
                    CategoryID = g.Key.CategoryID,
                    Event = g.First().Event,
                    EventID = g.First().EventID,
                    Requests = g.Where(r => r.RequestTxID != null).Count(),
                    ProcessErrorID = g.First().ProcessErrorID,
                    ProcessErrorDescr = g.First().ProcessErrorDescr,
                    TotalErrors = g.Where(f => f.Level == EVENT_STATUS.ERROR || f.Level == EVENT_STATUS.WARNING).Count(),
                    ClearedErrors = g.Where(c => c.Level == EVENT_STATUS.CLEARED).Count(),
                    Acknowledged = g.Where(a => a.Level == EVENT_STATUS.ACKNOWLEDGED).Count(),
                    CurrentClicked = g.First().CurrentClicked,
                });

            return entries;
        }

        public IPagedList<LogErrors> Update2(string sortOrder, int? page)
        {
            if (page != null)
            {
                Page = (int)page;
            }
            _pageNumber2 = Page;
            _filteredLog2 = GenListFromLog2(StartDate, EndDate).ToList();

            if (!String.IsNullOrEmpty(sortOrder))
            {
                _sortOrder = sortOrder;
            }
            ViewBag.CurrentSort2 = _sortOrder;

            var entries = from entry in _filteredLog2
                          select entry;

            if (page == null)
            {

                ViewBag.DateTimeStartSortParm = _sortOrder == "DateTimeStart" ? "DateTimeStart_desc" : "DateTimeStart";
                ViewBag.ProgramSortParm = _sortOrder == "Program" ? "Program_desc" : "Program";
                ViewBag.InstitutionSortParm = _sortOrder == "Institution" ? "Institution_desc" : "Institution";
                ViewBag.Category2SortParm = _sortOrder == "Category2" ? "Category2_desc" : "Category2";
                ViewBag.Event2SortParm = _sortOrder == "Event2" ? "Event2_desc" : "Event2";
                ViewBag.URISortParm = _sortOrder == "URI" ? "URI_desc" : "URI";
                ViewBag.Status2SortParm = _sortOrder == "Status2" ? "Status2_desc" : "Status2";
                ViewBag.RequestsSortParm = _sortOrder == "Requests" ? "Requests_desc" : "Requests";


                switch (_sortOrder)
                {
                    case "DateTimeStart_desc":
                        entries = entries.OrderByDescending(s => s.DateStart);
                        break;
                    case "DateTimeStart":
                        entries = entries.OrderBy(s => s.DateStart);
                        break;
                    case "Program_desc":
                        entries = entries.OrderByDescending(s => s.Program);
                        break;
                    case "Program":
                        entries = entries.OrderBy(s => s.Program);
                        break;
                    case "Institution_desc":
                        entries = entries.OrderByDescending(s => s.Institution);
                        break;
                    case "Institution":
                        entries = entries.OrderBy(s => s.Institution);
                        break;
                    case "Category2_desc":
                        entries = entries.OrderByDescending(s => s.Category);
                        break;
                    case "Category2":
                        entries = entries.OrderBy(s => s.Category);
                        break;
                    case "Event2_desc":
                        entries = entries.OrderByDescending(s => s.Event);
                        break;
                    case "Event2":
                        entries = entries.OrderBy(s => s.Event);
                        break;
                    case "URI_desc":
                        entries = entries.OrderByDescending(s => s.URI);
                        break;
                    case "URI":
                        entries = entries.OrderBy(s => s.URI);
                        break;
                    case "Status2_desc":
                        entries = entries.OrderByDescending(s => s.TotalErrors);
                        break;
                    case "Status2":
                        entries = entries.OrderBy(s => s.TotalErrors);
                        break;
                    case "Requests_desc":
                        entries = entries.OrderByDescending(s => s.Requests);
                        break;
                    case "Requests":
                        entries = entries.OrderBy(s => s.Requests);
                        break;
                    default:
                        entries = entries.OrderByDescending(s => s.DateStart);
                        break;
                }
            }

            return entries.ToPagedList(_pageNumber2, PageSize);
        }

        public PartialViewResult UpdatePartial2(string sortOrder2, int? page)
        {
            StartDate = (DateTime)Session["StartDate"];
            EndDate = (DateTime)Session["EndDate"];
            ViewBag.Partial2 = Update2(sortOrder2, page);
            ViewBag.Partial1 = _filteredLog1.ToPagedList(_pageNumber1, PageSize);
            ViewBag.Partial3 = _filteredLog3.ToPagedList(_pageNumber3, PageSize);
            return PartialView("_PartialTabMonitor", null);
        }


        private IEnumerable<WebServiceOperationStatus> GenListFromLog3(DateTime? startDate, DateTime endDate)
        {
            NcsInfo ret = null;
            if (Logs.GeneralLog == null || Logs.GeneralLog.Count() == 0)
            {
                Logs.GeneralLog = Logs.CreateGeneralEventLog();
            }

            var entries = Logs.GeneralLog
                .Where(x => x.ProcessDatetime >= startDate &&
                            x.ProcessDatetime <= endDate &&
                            x.Environment.ToUpper() == _environment.ToUpper() &&
                            (x.URIType != "sFTP") &&
                            (x.Level == EVENT_STATUS.ERROR || x.Level == EVENT_STATUS.WARNING ||
                             x.Level == EVENT_STATUS.CLEARED || x.Level == EVENT_STATUS.ACKNOWLEDGED))
                .GroupBy(x => new { x.ProgramID, x.InstitutionID, x.CategoryID, x.GUID })
                .Select(g => new WebServiceOperationStatus
                {
                    ID = g.First().ID,
                    Level = g.First().Level,
                    TaskID = g.First().TaskID,
                    InstitutionID = g.First().InstitutionID,
                    Institution = (ret = Logs.GetNCSInfo(g.First().InstitutionID)) != null ? ret.Name : null,
                    DateStart = g.First().ProcessDatetime,
                    Program = g.Key.ProgramID,
                    CategoryID = g.Key.CategoryID,
                    Category = g.First().Category,
                    GUID = g.Key.GUID,
                    CardSerialNumber = g.First().CardSerialNumber,
                    URI = g.First().URI,
                    ErrorID = !String.IsNullOrEmpty(g.First().ProcessErrorID) ? int.Parse(g.First().ProcessErrorID) : 0,
                    ErrorDesc = g.First().ProcessErrorDescr,
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

                    TotalErrors = g.Where(e => e.Level == EVENT_STATUS.ERROR || e.Level == EVENT_STATUS.WARNING).Count(),
                    ClearedErrors = g.Where(c => c.Level == EVENT_STATUS.CLEARED).Count(),
                    Acknowledged = g.Where(c => c.Level == EVENT_STATUS.ACKNOWLEDGED).Count(),
                    CurrentClicked = g.First().CurrentClicked,
                });

            return entries;
        }

        public IPagedList<WebServiceOperationStatus> Update3(string sortOrder, int? page)
        {
            if (page != null)
            {
                Page = (int)page;
            }
            _pageNumber3 = Page;
            _filteredLog3 = GenListFromLog3(StartDate, EndDate).ToList();

            if (!String.IsNullOrEmpty(sortOrder))
            {
                _sortOrder = sortOrder;
            }
            ViewBag.CurrentSort3 = _sortOrder;
            var entries = from entry in _filteredLog3
                          select entry;

            ViewBag.startDate = StartDate;
            ViewBag.endDate = EndDate;
            if (page == null)
            {
                ViewBag.DateTimeStartSortParm = _sortOrder == "DateTimeStart" ? "DateTimeStart_desc" : "DateTimeStart";
                ViewBag.ProgramSortParm = _sortOrder == "Program" ? "Program_desc" : "Program";
                ViewBag.InstitutionSortParm = _sortOrder == "Institution" ? "Institution_desc" : "Institution";
                ViewBag.Category3SortParm = _sortOrder == "Category3" ? "Category3_desc" : "Category3";
                ViewBag.Event3SortParm = _sortOrder == "Event3" ? "Event3_desc" : "Event3";
                ViewBag.GuidSortParm = _sortOrder == "GUID" ? "GUID_desc" : "GUID";
                ViewBag.Status3SortParm = _sortOrder == "Status3" ? "Status3_desc" : "Status3";


                switch (_sortOrder)
                {
                    //case "CurrentClicked":
                    //    entries = entries.OrderByDescending(s => s.CurrentClicked);
                    //    break;
                    case "DateTimeStart_desc":
                        entries = entries.OrderByDescending(s => s.DateStart);
                        break;
                    case "DateTimeStart":
                        entries = entries.OrderBy(s => s.DateStart);
                        break;
                    case "Program_desc":
                        entries = entries.OrderByDescending(s => s.Program);
                        break;
                    case "Program":
                        entries = entries.OrderBy(s => s.Program);
                        break;
                    case "Institution_desc":
                        entries = entries.OrderByDescending(s => s.Institution);
                        break;
                    case "Institution":
                        entries = entries.OrderBy(s => s.Institution);
                        break;
                    case "Category3_desc":
                        entries = entries.OrderByDescending(s => s.Category);
                        break;
                    case "Category3":
                        entries = entries.OrderBy(s => s.Category);
                        break;
                    case "Event3_desc":
                        entries = entries.OrderByDescending(s => s.Event);
                        break;
                    case "Event3":
                        entries = entries.OrderBy(s => s.Event);
                        break;
                    case "GUID_desc":
                        entries = entries.OrderByDescending(s => s.GUID);
                        break;
                    case "GUID":
                        entries = entries.OrderBy(s => s.GUID);
                        break;

                    case "Status3_desc":
                        entries = entries.OrderByDescending(s => s.TotalErrors);
                        break;
                    case "Status3":
                        entries = entries.OrderBy(s => s.TotalErrors);
                        break;

                    default:
                        entries = entries.OrderByDescending(s => s.DateStart);
                        break;
                }
            }

            return entries.ToPagedList(_pageNumber3, PageSize);

        }

        public PartialViewResult UpdatePartial3(string sortOrder3, int? page)
        {
            StartDate = (DateTime)Session["StartDate"];
            EndDate = (DateTime)Session["EndDate"];
            ViewBag.Partial3 = Update3(sortOrder3, page);
            ViewBag.Partial1 = _filteredLog1.ToPagedList(_pageNumber1, PageSize);
            ViewBag.Partial2 = _filteredLog2.ToPagedList(_pageNumber2, PageSize);
            return PartialView("_PartialTabMonitor", null);
        }



        public IPagedList<ErrorsBase> Update4(string sortOrder, int? page)
        {
            if (page != null)
            {
                Page = (int)page;
            }
            if (Page == 0)
            {
                Page = 1;
            }
            _pageNumber4 = Page;
            _filteredLog4 = GenListFromLog4(Constants.StartDate, EndDate).ToList();


            if (!String.IsNullOrEmpty(sortOrder))
            {
                _sortOrder = sortOrder;
            }
            ViewBag.CurrentSort = _sortOrder;
            ViewBag.startDate = Constants.StartDate;
            ViewBag.endDate = EndDate;

            var entries = from entry in _filteredLog4
                          select entry;

            if (page == null)
            {
                ViewBag.ProcessDatetimeSortParm = _sortOrder == "ProcessDatetime" ? "ProcessDatetime_desc" : "ProcessDatetime";
                ViewBag.CategorySortParm = _sortOrder == "Category" ? "Categorydesc" : "Category";
                ViewBag.EventSortParm = _sortOrder == "Event" ? "Event_desc" : "Event";
                ViewBag.StatusSortParm = _sortOrder == "Status" ? "Status_desc" : "Status";
            }

            switch (_sortOrder)
            {
                case "ProcessDatetime":
                    entries = entries.OrderBy(s => s.ProcessDatetime);
                    break;
                case "Category_desc":
                    entries = entries.OrderByDescending(s => s.CategoryID);
                    break;
                case "Category":
                    entries = entries.OrderBy(s => s.CategoryID);
                    break;
                case "Event_desc":
                    entries = entries.OrderByDescending(s => s.EventID);
                    break;
                case "Event":
                    entries = entries.OrderBy(s => s.EventID);
                    break;
                case "Status_desc":
                    entries = entries.OrderByDescending(s => s.TotalErrors);
                    break;
                case "Status":
                    entries = entries.OrderBy(s => s.TotalErrors);
                    break;
                default:
                    entries = entries.OrderByDescending(s => s.ProcessDatetime);
                    break;
            }
            return entries.ToPagedList(_pageNumber4, PageSize);
        }

        private IEnumerable<ErrorsBase> GenListFromLog4(DateTime startDate, DateTime endDate)
        {
            NcsInfo ret = null;
            if (Logs.GeneralLog == null || Logs.GeneralLog.Count() == 0)
            {
                Logs.GeneralLog = Logs.CreateGeneralEventLog();
            }
            var entries = Logs.GeneralLog
                .Where(x => x.ProcessDatetime >= startDate &&
                            x.ProcessDatetime <= endDate &&
                            x.Environment.ToUpper() == _environment.ToUpper() &&
                            x.CategoryID >= EventCategoryId.ConfiscationRequestedTask &&
                            x.CategoryID <= EventCategoryId.ConfiscationCreateNotificationTaskPendingTask &&
                            (x.Level == EVENT_STATUS.ERROR || x.Level == EVENT_STATUS.WARNING ||
                             x.Level == EVENT_STATUS.CLEARED || x.Level == EVENT_STATUS.ACKNOWLEDGED))
                .GroupBy(x => new { x.CategoryID })
                .Select(g => new ErrorsBase
                {
                    NCSCustomerID = (ret = Logs.GetNCSInfo(g.First().InstitutionID)) != null ? ret.OrganizationId : 0,
                    Level = g.First().Level,
                    ID = g.First().ID,
                    Program = g.First().ProgramID,
                    InstitutionID = g.First().InstitutionID,
                    Institution = ret != null ? ret.Name : null,
                    CategoryID = g.Key.CategoryID,
                    Category = g.First().Category,
                    EventID = g.First().EventID,
                    Event = g.First().Event,
                    TotalErrors = g.Where(f => f.Level == EVENT_STATUS.ERROR || f.Level == EVENT_STATUS.WARNING).Count(),
                    ClearedErrors = g.Where(c => c.Level == EVENT_STATUS.CLEARED).Count(),
                    Acknowledged = g.Where(a => a.Level == EVENT_STATUS.ACKNOWLEDGED).Count(),
                    CurrentClicked = g.First().CurrentClicked,
                });


            return entries;

        }


        public PartialViewResult UpdatePartial4(string sortOrder4, int? page)
        {
            StartDate = (DateTime)Session["StartDate"];
            EndDate = (DateTime)Session["EndDate"];
            ViewBag.Partial5 = Update4(sortOrder4, page);
            ViewBag.Partial1 = _filteredLog1.ToPagedList(_pageNumber1, PageSize);
            ViewBag.Partial2 = _filteredLog2.ToPagedList(_pageNumber2, PageSize);
            ViewBag.Partial3 = _filteredLog3.ToPagedList(_pageNumber3, PageSize);

            return PartialView("_PartialTabMonitor", null);
        }

        [OutputCache(Duration = 3600, Location = OutputCacheLocation.Client, NoStore = true)]
        public ActionResult GetTabMonitorEvents(long ID)
        {
            var result = _filteredLog3.Where(x => x.ID == ID).ToList();

            return View("_PartialEvents", result.FirstOrDefault());
        }


        #endregion

        #region Tab Files

        public PartialViewResult FilesUpdatePartial(DateTime? startDate, DateTime? endDate, string sortOrder, int? page)
        {
            SetDateRange(startDate, endDate);

            ViewBag.FilesPartial1 = FilesUpdate1(sortOrder, _fpageNumber1);
            ViewBag.FilesPartial2 = FilesUpdate2(sortOrder, _fpageNumber2);
            ViewBag.FilesPartial3 = FilesUpdate3(sortOrder, _fpageNumber3);

            LoadCompleted = DateTime.Now;
            return PartialView("_PartialTabFiles", null);
        }

        private IEnumerable<PpassFileErrors> FilesGenListFromLog1(DateTime startDate, DateTime endDate)
        {
            NcsInfo ret = null;
            if (Logs.GeneralLog == null || Logs.GeneralLog.Count() == 0)
            {
                Logs.GeneralLog = Logs.CreateGeneralEventLog();
            }

            var entries = Logs.GeneralLog
                .Where(x => x.ProcessDatetime >= startDate &&
                            x.ProcessDatetime <= endDate &&
                            x.Environment.ToUpper() == _environment.ToUpper() &&
                            x.ProgramID == PROGRAM_ID.PPASS &&
                            x.URIType == "sFTP")
                .GroupBy(x => new { x.ProgramID, x.InstitutionID })
                .Select(g => new PpassFileErrors
                {
                    InstitutionID = !String.IsNullOrEmpty(g.Key.InstitutionID) ? g.Key.InstitutionID : null,
                    Institution = (ret = Logs.GetNCSInfo(g.Key.InstitutionID)) != null ? ret.Name : null,
                    DateStart = g.First().ProcessDatetime,
                    NCSCustomerID = ret != null ? ret.OrganizationId : 0,
                    Program = g.Key.ProgramID,
                    Category = g.First().Category,
                    TotalErrors = g.Where(e => e.Level == EVENT_STATUS.ERROR).Count(),
                    ClearedErrors = g.Where(c => c.Level == EVENT_STATUS.CLEARED).Count(),
                    Acknowledged = g.Where(c => c.Level == EVENT_STATUS.ACKNOWLEDGED).Count(),

                    IufRequests = g.Where(r => r.RequestTxID != null && r.CategoryID == CATEGORY_ID_FILES.IUF).Count(),
                    FufRequests = g.Where(r => r.RequestTxID != null && r.CategoryID == CATEGORY_ID_FILES.FUF).Count(),
                    FcfRequests = g.Where(r => r.RequestTxID != null && r.CategoryID == CATEGORY_ID_FILES.FCF).Count(),
                    IcfRequests = g.Where(r => r.RequestTxID != null && r.CategoryID == CATEGORY_ID_FILES.ICF).Count(),

                });
            return entries;
        }

        public IPagedList<PpassFileErrors> FilesUpdate1(string sortOrder, int? page)
        {
            if (page != null)
            {
                Page = (int)page;
            }
            if (Page == 0)
            {
                Page = 1;
            }
            _fpageNumber1 = Page;

            _ffilteredLog1 = FilesGenListFromLog1(StartDate, EndDate).ToList();

            if (!String.IsNullOrEmpty(sortOrder))
            {
                _sortOrder = sortOrder;
            }
            ViewBag.CurrentSort = _sortOrder;

            var entries = from entry in _ffilteredLog1
                          select entry;

            if (page == null)
            {
                ViewBag.ProgramSortParm = _sortOrder == "Program" ? "Program_desc" : "Program";
                ViewBag.InstitutionSortParm = _sortOrder == "Institution" ? "Institution_desc" : "Institution";
                ViewBag.NCSCustomerIDSortParm = _sortOrder == "NCSCustomerID" ? "NCSCustomerID_desc" : "NCSCustomerID";
                ViewBag.TotalErrorsSortParm = _sortOrder == "TotalErrors" ? "TotalErrors_desc" : "TotalErrors";
                ViewBag.IufRequestsSortParm = _sortOrder == "IufRequests" ? "IufRequests_desc" : "IufRequests";
                ViewBag.FufRequestsSortParm = _sortOrder == "FufRequests" ? "FufRequests_desc" : "FufRequests";
                ViewBag.IcfRequestsSortParm = _sortOrder == "IcfRequests" ? "IcfRequests_desc" : "IcfRequests";
                ViewBag.FcfRequestsSortParm = _sortOrder == "FcfRequests" ? "FcfRequests_desc" : "FcfRequests";
            }

            switch (_sortOrder)
            {
                case "Program_desc":
                    entries = entries.OrderByDescending(s => s.Program);
                    break;
                case "Program":
                    entries = entries.OrderBy(s => s.Program);
                    break;
                case "Institution_desc":
                    entries = entries.OrderByDescending(s => s.Institution);
                    break;
                case "Institution":
                    entries = entries.OrderBy(s => s.Institution);
                    break;
                case "NCSCustomerID_desc":
                    entries = entries.OrderByDescending(s => s.NCSCustomerID);
                    break;
                case "NCSCustomerID":
                    entries = entries.OrderBy(s => s.NCSCustomerID);
                    break;
                case "TotalErrors_desc":
                    entries = entries.OrderByDescending(s => s.TotalErrors > 0 ? s.TotalErrors : (s.ClearedErrors > 0 ? s.ClearedErrors : s.Acknowledged));
                    break;
                case "TotalErrors":
                    entries = entries.OrderBy(s => s.TotalErrors > 0 ? s.TotalErrors : (s.ClearedErrors > 0 ? s.ClearedErrors : s.Acknowledged));
                    break;
                case "IufRequests_desc":
                    entries = entries.OrderByDescending(s => s.IufRequests);
                    break;
                case "IufRequests":
                    entries = entries.OrderBy(s => s.IufRequests);
                    break;
                case "FufRequests_desc":
                    entries = entries.OrderByDescending(s => s.FufRequests);
                    break;
                case "FufRequests":
                    entries = entries.OrderBy(s => s.FufRequests);
                    break;
                case "IcfRequests_desc":
                    entries = entries.OrderByDescending(s => s.IcfRequests);
                    break;
                case "IcfRequests":
                    entries = entries.OrderBy(s => s.IcfRequests);
                    break;
                case "FcfRequests_desc":
                    entries = entries.OrderByDescending(s => s.FcfRequests);
                    break;
                case "FcfRequests":
                    entries = entries.OrderBy(s => s.FcfRequests);
                    break;
                default:
                    entries = entries.OrderByDescending(s => s.DateStart);
                    break;
            }
            return entries.ToPagedList(_fpageNumber1, PageSize);
        }

        public PartialViewResult FilesUpdatePartial1(string sortOrder4, int? page)
        {
            StartDate = (DateTime)Session["StartDate"];
            EndDate = (DateTime)Session["EndDate"];
            ViewBag.FilesPartial1 = FilesUpdate1(sortOrder4, page);
            ViewBag.FilesPartial2 = _ffilteredLog2.ToPagedList(_fpageNumber2, PageSize);
            ViewBag.FilesPartial3 = _ffilteredLog3.ToPagedList(_fpageNumber3, PageSize);
            return PartialView("_PartialTabFiles", null);
        }


        private IEnumerable<UpassFileErrors> FilesGenListFromLog2(DateTime startDate, DateTime endDate)
        {
            NcsInfo ret = null;
            if (Logs.GeneralLog == null || Logs.GeneralLog.Count() == 0)
            {
                Logs.GeneralLog = Logs.CreateGeneralEventLog();
            }
            var entries = Logs.GeneralLog
                .Where(x => x.ProcessDatetime >= startDate &&
                            x.ProcessDatetime <= endDate &&
                            x.Environment.ToUpper() == _environment.ToUpper() &&
                            x.ProgramID == PROGRAM_ID.UPASS &&
                            x.URIType == "sFTP")
                .GroupBy(x => new { x.ProgramID, x.InstitutionID })
                .Select(g => new UpassFileErrors
                {
                    ID = g.First().ID,
                    InstitutionID = g.Key.InstitutionID,
                    Institution = (ret = Logs.GetNCSInfo(g.Key.InstitutionID)) != null ? ret.Name : null,
                    NCSCustomerID = ret != null ? ret.OrganizationId : 0,
                    DateStart = (DateTime)g.First().ProcessDatetime,
                    Program = g.Key.ProgramID,
                    Category = g.First().Category,
                    Requests = g.Where(r => r.UniqueParticipantId != null).Count(),
                    Status = g.First().FileStatus,
                    TotalErrors = g.Where(f => f.Level == EVENT_STATUS.ERROR).Count(),
                    ClearedErrors = g.Where(c => c.Level == EVENT_STATUS.CLEARED).Count(),
                    Acknowledged = g.Where(a => a.Level == EVENT_STATUS.ACKNOWLEDGED).Count(),
                });

            return entries;
        }

        public IPagedList<UpassFileErrors> FilesUpdate2(string sortOrder, int? page)
        {
            if (page != null)
            {
                Page = (int)page;
            }
            _fpageNumber2 = Page;

            _ffilteredLog2 = FilesGenListFromLog2(StartDate, EndDate).ToList();

            if (!String.IsNullOrEmpty(sortOrder))
            {
                _sortOrder = sortOrder;
            }
            ViewBag.CurrentSort = _sortOrder;

            var entries = from entry in _ffilteredLog2
                          select entry;

            if (page == null)
            {

                ViewBag.DateTimeStartSortParm = _sortOrder == "DateTimeStart" ? "DateTimeStart_desc" : "DateTimeStart";
                ViewBag.ProgramSortParm = _sortOrder == "Program" ? "Program_desc" : "Program";
                ViewBag.InstitutionSortParm = _sortOrder == "Institution" ? "Institution_desc" : "Institution";
                ViewBag.TotalErrorsSortParm = _sortOrder == "Errors" ? "Errors_desc" : "Errors";
                ViewBag.SystemSortParm = _sortOrder == "Event" ? "Event_desc" : "Event";
                ViewBag.Status2SortParm = _sortOrder == "Status2" ? "Status2_desc" : "Status2";
                ViewBag.RequestsSortParm = _sortOrder == "Requests" ? "Requests_desc" : "Requests";
            }

            switch (_sortOrder)
            {
                case "DateTimeStart_desc":
                    entries = entries.OrderByDescending(s => s.DateStart);
                    break;
                case "DateTimeStart":
                    entries = entries.OrderBy(s => s.DateStart);
                    break;
                case "Program_desc":
                    entries = entries.OrderByDescending(s => s.Program);
                    break;
                case "Program":
                    entries = entries.OrderBy(s => s.Program);
                    break;
                case "Institution_desc":
                    entries = entries.OrderByDescending(s => s.Institution);
                    break;
                case "Institution":
                    entries = entries.OrderBy(s => s.Institution);
                    break;
                case "Errors_desc":
                    entries = entries.OrderByDescending(s => s.TotalErrors);
                    break;
                case "Errors":
                    entries = entries.OrderBy(s => s.TotalErrors);
                    break;
                case "Requests_desc":
                    entries = entries.OrderByDescending(s => s.Requests);
                    break;
                case "Requests":
                    entries = entries.OrderBy(s => s.Requests);
                    break;
                case "Status2_desc":
                    entries = entries.OrderByDescending(s => s.TotalErrors > 0 ? s.TotalErrors : (s.ClearedErrors > 0 ? s.ClearedErrors : s.Acknowledged));
                    break;
                case "Status2":
                    entries = entries.OrderBy(s => s.TotalErrors > 0 ? s.TotalErrors : (s.ClearedErrors > 0 ? s.ClearedErrors : s.Acknowledged));
                    break;
                default:
                    entries = entries.OrderByDescending(s => s.DateStart);
                    break;
            }

            return entries.ToPagedList(_fpageNumber2, PageSize);
        }

        public PartialViewResult FilesUpdatePartial2(string sortOrder5, int? page)
        {
            StartDate = (DateTime)Session["StartDate"];
            EndDate = (DateTime)Session["EndDate"];
            ViewBag.FilesPartial2 = FilesUpdate2(sortOrder5, page);
            ViewBag.FilesPartial1 = _ffilteredLog1.ToPagedList(_fpageNumber1, PageSize);
            ViewBag.FilesPartial3 = _ffilteredLog3.ToPagedList(_fpageNumber3, PageSize);
            return PartialView("_PartialTabFiles", null);
        }


        private IEnumerable<LogErrors> FilesGenListFromLog3(DateTime startDate, DateTime endDate)
        {
            NcsInfo ret = null;
            if (Logs.GeneralLog == null || Logs.GeneralLog.Count() == 0)
            {
                Logs.GeneralLog = Logs.CreateGeneralEventLog();
            }

            var entries = Logs.GeneralLog
                .Where(x => x.ProcessDatetime >= startDate &&
                            x.ProcessDatetime <= endDate &&
                            !String.IsNullOrEmpty(x.URI) &&
                            (x.URI.ToUpper().Contains("IUF_") ||
                             x.URI.ToUpper().Contains("ICF_") ||
                             x.URI.ToUpper().Contains("FUF_") ||
                             x.URI.ToUpper().Contains("FCF_") ||
                             x.URI.Contains(PROGRAM_ID.UPASS)) &&
                            x.Environment.ToUpper() == _environment.ToUpper() &&
                            x.URIType == "sFTP")
                .GroupBy(x => new { x.ProgramID, x.InstitutionID, x.CategoryID, x.EventID })
                .Select(g => new LogErrors
                {
                    ID = g.First().ID,
                    InstitutionID = g.Key.InstitutionID,
                    Institution = (ret = Logs.GetNCSInfo(g.Key.InstitutionID)) != null ? ret.Name : null,
                    FileName = g.First().FileName,
                    URI = g.First().URI,
                    DateStart = g.First().ProcessDatetime,
                    Program = g.Key.ProgramID,
                    ErrorID = !String.IsNullOrEmpty(g.First().ProcessErrorID) ? int.Parse(g.First().ProcessErrorID) : 0,
                    ErrorDesc = g.First().ProcessErrorDescr,
                    CategoryID = g.Key.CategoryID,
                    Category = g.First().Category,
                    Event = g.First().Event,
                    EventID = g.Key.EventID,
                    UniqueParticipantID = g.First().UniqueParticipantId,
                    //Requests = g.Where(r => r.RequestTxID != null).Count(),
                    Requests = g.Where(r => r.RequestTxID != null || r.UniqueParticipantId != null).Count(),
                    ProcessErrorID = g.First().ProcessErrorID,
                    ProcessErrorDescr = g.First().ProcessErrorDescr,
                    TotalErrors = g.Where(f => f.Level == EVENT_STATUS.ERROR).Count(),
                    ClearedErrors = g.Where(c => c.Level == EVENT_STATUS.CLEARED).Count(),
                    Acknowledged = g.Where(a => a.Level == EVENT_STATUS.ACKNOWLEDGED).Count(),
                    Computer = g.First().Computer,
                    CurrentClicked = g.First().CurrentClicked,
                });

            return entries;
        }

        public IPagedList<LogErrors> FilesUpdate3(string sortOrder, int? page)
        {
            if (page != null)
            {
                Page = (int)page;
            }
            _fpageNumber3 = Page;

            _ffilteredLog3 = FilesGenListFromLog3(StartDate, EndDate).ToList();

            if (!String.IsNullOrEmpty(sortOrder))
            {
                _sortOrder = sortOrder;
            }
            ViewBag.CurrentSort = _sortOrder;

            var entries = from entry in _ffilteredLog3
                          select entry;

            ViewBag.startDate = StartDate;
            ViewBag.endDate = EndDate;
            if (page == null)
            {

                ViewBag.DateTimeStartSortParm = _sortOrder == "DateTimeStart" ? "DateTimeStart_desc" : "DateTimeStart";
                ViewBag.ProgramSortParm = _sortOrder == "Program" ? "Program_desc" : "Program";
                ViewBag.InstitutionSortParm = _sortOrder == "Institution" ? "Institution_desc" : "Institution";
                ViewBag.ServicesParm = _sortOrder == "Category" ? "Category_desc" : "Category";
                ViewBag.URISortParm = _sortOrder == "URI" ? "URI_desc" : "URI";
                ViewBag.Status3SortParm = _sortOrder == "Status3" ? "Status3_desc" : "Status3";
                ViewBag.RequestsSortParm = _sortOrder == "Requests" ? "Requests_desc" : "Requests";
            }

            switch (_sortOrder)
            {
                case "DateTimeStart_desc":
                    entries = entries.OrderByDescending(s => s.DateStart);
                    break;
                case "DateTimeStart":
                    entries = entries.OrderBy(s => s.DateStart);
                    break;
                case "Program_desc":
                    entries = entries.OrderByDescending(s => s.Program);
                    break;
                case "Program":
                    entries = entries.OrderBy(s => s.Program);
                    break;
                case "Institution_desc":
                    entries = entries.OrderByDescending(s => s.Institution);
                    break;
                case "Institution":
                    entries = entries.OrderBy(s => s.Institution);
                    break;
                case "Category_desc":
                    entries = entries.OrderByDescending(s => s.Category);
                    break;
                case "Category":
                    entries = entries.OrderBy(s => s.Category);
                    break;
                case "URI_desc":
                    entries = entries.OrderByDescending(s => s.URI);
                    break;
                case "URI":
                    entries = entries.OrderBy(s => s.URI);
                    break;
                case "Status3_desc":
                    entries = entries.OrderByDescending(s => s.TotalErrors > 0 ? s.TotalErrors : (s.ClearedErrors > 0 ? s.ClearedErrors : s.Acknowledged));
                    break;
                case "Status3":
                    entries = entries.OrderBy(s => s.TotalErrors > 0 ? s.TotalErrors : (s.ClearedErrors > 0 ? s.ClearedErrors : s.Acknowledged));
                    break;
                case "Requests_desc":
                    entries = entries.OrderByDescending(s => s.Requests);
                    break;
                case "Requests":
                    entries = entries.OrderBy(s => s.Requests);
                    break;
                default:
                    entries = entries.OrderByDescending(s => s.DateStart);
                    break;
            }

            return entries.ToPagedList(_fpageNumber3, PageSize);
        }

        public PartialViewResult FilesUpdatePartial3(string sortOrder6, int? page)
        {
            StartDate = (DateTime)Session["StartDate"];
            EndDate = (DateTime)Session["EndDate"];
            ViewBag.FilesPartial3 = FilesUpdate3(sortOrder6, page);
            ViewBag.FilesPartial1 = _ffilteredLog1.ToPagedList(_fpageNumber1, PageSize);
            ViewBag.FilesPartial2 = _ffilteredLog2.ToPagedList(_fpageNumber2, PageSize);
            return PartialView("_PartialTabFiles", null);
        }
        #endregion

        #region Tab WebService

        public PartialViewResult WSUpdatePartial(DateTime? startDate, DateTime? endDate, string sortOrder, int? page)
        {
            SetDateRange(startDate, endDate);

            ViewBag.WSPartial1 = WSUpdate1(sortOrder, _wpageNumber1);
            ViewBag.WSPartial2 = WSUpdate2(sortOrder, _wpageNumber2);
            ViewBag.WSPartial3 = WSUpdate3(sortOrder, _wpageNumber3);


            LoadCompleted = DateTime.Now;
            return PartialView("_PartialTabWS", null);
        }


        private IEnumerable<PpassWebServiceErrors> WSGenListFromLog1(DateTime startDate, DateTime endDate)
        {
            NcsInfo ret = null;
            if (Logs.GeneralLog == null || Logs.GeneralLog.Count() == 0)
            {
                Logs.GeneralLog = Logs.CreateGeneralEventLog();
            }

            var entries = Logs.GeneralLog
                .Where(x => x.ProcessDatetime >= startDate &&
                            x.ProcessDatetime <= endDate &&
                            x.Environment.ToUpper() == _environment.ToUpper() &&
                            x.ProgramID == PROGRAM_ID.PPASS
                            && x.URIType == "API")
                .GroupBy(x => new { x.ProgramID, x.InstitutionID })
                .Select(g => new PpassWebServiceErrors
                {
                    InstitutionID = g.Key.InstitutionID,
                    Institution = (ret = Logs.GetNCSInfo(g.Key.InstitutionID)) != null ? ret.Name : null,
                    DateStart = (DateTime)g.First().ProcessDatetime,
                    NCSCustomerID = ret != null ? ret.OrganizationId : 0,
                    Program = g.Key.ProgramID,
                    Category = g.First().Category,

                    NewCards = g.Where(c => c.CategoryID == CATEGORY_ID_WEBSERVICES.NEW_CARD).Count(),
                    TerminateCards = g.Where(c => c.CategoryID == CATEGORY_ID_WEBSERVICES.TERMINATE_CARD).Count(),
                    ReplacementCards = g.Where(c => c.CategoryID == CATEGORY_ID_WEBSERVICES.REPLACEMENT_CARD).Count(),
                    SuspendCards = g.Where(c => c.CategoryID == CATEGORY_ID_WEBSERVICES.SUSPEND_CARD).Count(),
                    ResumeCards = g.Where(c => c.CategoryID == CATEGORY_ID_WEBSERVICES.REPLACEMENT_CARD).Count(),

                    TotalErrors = g.Where(e => e.Level == EVENT_STATUS.ERROR || e.Level == EVENT_STATUS.WARNING).Count(),
                    ClearedErrors = g.Where(c => c.Level == EVENT_STATUS.CLEARED).Count(),
                    Acknowledged = g.Where(a => a.Level == EVENT_STATUS.ACKNOWLEDGED).Count(),
                });
            return entries;
        }

        public IPagedList<PpassWebServiceErrors> WSUpdate1(string sortOrder, int? page)
        {
            if (page != null)
            {
                Page = (int)page;
            }
            _wpageNumber1 = Page;
            _wfilteredLog1 = WSGenListFromLog1(StartDate, EndDate).ToList();

            if (!String.IsNullOrEmpty(sortOrder))
            {
                _sortOrder = sortOrder;
            }
            ViewBag.CurrentSort = _sortOrder;

            var entries = from entry in _wfilteredLog1
                          select entry;

            if (page == null)
            {
                ViewBag.ProgramSortParm = _sortOrder == "Program" ? "Program_desc" : "Program";
                ViewBag.InstitutionSortParm = _sortOrder == "Institution" ? "Institution_desc" : "Institution";
                ViewBag.NCSCustomerIDSortParm = _sortOrder == "NCSCustomerID" ? "NCSCustomerID_desc" : "NCSCustomerID";
                ViewBag.TotalErrorsSortParm = _sortOrder == "TotalErrors" ? "TotalErrors_desc" : "TotalErrors";
                ViewBag.NewCardSortParm = _sortOrder == "NewCard" ? "NewCard_desc" : "NewCard";
                ViewBag.TerminateCardSortParm = _sortOrder == "TerminateCard" ? "TerminateCard_desc" : "TerminateCard";
                ViewBag.ReplacementCardSortParm = _sortOrder == "ReplacementCard" ? "ReplacementCard_desc" : "ReplacementCard";
                ViewBag.SuspendCardSortParm = _sortOrder == "SuspendCard" ? "SuspendCard_desc" : "SuspendCard";
                ViewBag.ResumeCardSortParm = _sortOrder == "ResumeCard" ? "ResumeCard_desc" : "ResumeCard";
            }

            switch (_sortOrder)
            {
                case "Program_desc":
                    entries = entries.OrderByDescending(s => s.Program);
                    break;
                case "Program":
                    entries = entries.OrderBy(s => s.Program);
                    break;
                case "Institution_desc":
                    entries = entries.OrderByDescending(s => s.Institution);
                    break;
                case "Institution":
                    entries = entries.OrderBy(s => s.Institution);
                    break;
                case "NCSCustomerID_desc":
                    entries = entries.OrderByDescending(s => s.NCSCustomerID);
                    break;
                case "NCSCustomerID":
                    entries = entries.OrderBy(s => s.NCSCustomerID);
                    break;
                case "TotalErrors_desc":
                    entries = entries.OrderByDescending(s => s.TotalErrors);
                    break;
                case "TotalErrors":
                    entries = entries.OrderBy(s => s.TotalErrors);
                    break;
                case "NewCard_desc":
                    entries = entries.OrderByDescending(s => s.NewCards);
                    break;
                case "NewCard":
                    entries = entries.OrderBy(s => s.NewCards);
                    break;
                case "TerminateCard_desc":
                    entries = entries.OrderByDescending(s => s.TerminateCards);
                    break;
                case "TerminateCard":
                    entries = entries.OrderBy(s => s.TerminateCards);
                    break;
                case "ReplacementCard_desc":
                    entries = entries.OrderByDescending(s => s.ReplacementCards);
                    break;
                case "ReplacementCard":
                    entries = entries.OrderBy(s => s.ReplacementCards);
                    break;
                case "SuspendCard_desc":
                    entries = entries.OrderByDescending(s => s.SuspendCards);
                    break;
                case "SuspendCard":
                    entries = entries.OrderBy(s => s.SuspendCards);
                    break;
                case "ResumeCard_desc":
                    entries = entries.OrderByDescending(s => s.ResumeCards);
                    break;
                case "ResumeCard":
                    entries = entries.OrderBy(s => s.ResumeCards);
                    break;

                default:
                    entries = entries.OrderByDescending(s => s.DateStart);
                    break;
            }
            return entries.ToPagedList(_wpageNumber1, PageSize);
        }

        public PartialViewResult WSUpdatePartial1(string sortOrder7, int? page)
        {
            StartDate = (DateTime)Session["StartDate"];
            EndDate = (DateTime)Session["EndDate"];
            ViewBag.WSPartial1 = WSUpdate1(sortOrder7, page);
            ViewBag.WSPartial2 = _wfilteredLog2.ToPagedList(_wpageNumber2, PageSize);
            ViewBag.WSPartial3 = _wfilteredLog3.ToPagedList(_wpageNumber3, PageSize);
            return PartialView("_PartialTabWS", null);
        }


        private IEnumerable<UpassWebServiceErrors> WSGenListFromLog2(DateTime startDate, DateTime endDate)
        {
            NcsInfo ret = null;
            if (Logs.GeneralLog == null || Logs.GeneralLog.Count() == 0)
            {
                Logs.GeneralLog = Logs.CreateGeneralEventLog();
            }
            var entries = Logs.GeneralLog
                .Where(x => x.ProcessDatetime >= startDate &&
                            x.ProcessDatetime <= endDate &&
                            x.Environment.ToUpper() == _environment.ToUpper() &&
                            x.ProgramID == PROGRAM_ID.UPASS &&
                            (x.URIType == "API" || x.URIType == "NoURI" || x.URIType == "Webservice"))
                .GroupBy(x => new { x.ProgramID, x.InstitutionID })
                .Select(g => new UpassWebServiceErrors
                {
                    InstitutionID = (g.Key.InstitutionID != null) ? g.Key.InstitutionID : null,
                    Institution = (ret = Logs.GetNCSInfo(g.Key.InstitutionID)) != null ? ret.Name : null,
                    DateStart = (DateTime)g.First().ProcessDatetime,
                    NCSCustomerID = ret != null ? ret.OrganizationId : 0,
                    Program = g.Key.ProgramID,
                    Category = g.First().Category,

                    WaiveBenefits = g.Where(c => c.CategoryID == CATEGORY_ID_WEBSERVICES.WAIVE_BENEFIT).Count(),
                    ElectBenefits = g.Where(c => c.CategoryID == CATEGORY_ID_WEBSERVICES.ELECT_BENEFIT).Count(),
                    LinkCards = g.Where(c => c.CategoryID == CATEGORY_ID_WEBSERVICES.LINK_CARD).Count(),
                    UnlinkCards = g.Where(c => c.CategoryID == CATEGORY_ID_WEBSERVICES.UNLINK_CARD).Count(),
                    UpassWebServices = g.Where(c => c.CategoryID == CATEGORY_ID_WEBSERVICES.WEB_SERVICES).Count(),
                    Others = g.Where(c => !(c.CategoryID == CATEGORY_ID_WEBSERVICES.WAIVE_BENEFIT ||
                                            c.CategoryID == CATEGORY_ID_WEBSERVICES.ELECT_BENEFIT ||
                                            c.CategoryID == CATEGORY_ID_WEBSERVICES.LINK_CARD ||
                                            c.CategoryID == CATEGORY_ID_WEBSERVICES.UNLINK_CARD ||
                                            c.CategoryID == CATEGORY_ID_WEBSERVICES.WEB_SERVICES)).Count(),
                    TotalErrors = g.Where(e => e.Level == EVENT_STATUS.ERROR || e.Level == EVENT_STATUS.WARNING).Count(),
                    ClearedErrors = g.Where(c => c.Level == EVENT_STATUS.CLEARED).Count(),
                    Acknowledged = g.Where(a => a.Level == EVENT_STATUS.ACKNOWLEDGED).Count(),

                });

            return entries;
        }

        public IPagedList<UpassWebServiceErrors> WSUpdate2(string sortOrder, int? page)
        {
            if (page != null)
            {
                Page = (int)page;
            }
            _wpageNumber2 = Page;
            _wfilteredLog2 = WSGenListFromLog2(StartDate, EndDate).ToList();

            if (!String.IsNullOrEmpty(sortOrder))
            {
                _sortOrder = sortOrder;
            }
            ViewBag.CurrentSort = _sortOrder;

            var entries = from entry in _wfilteredLog2
                          select entry;

            if (page == null)
            {
                ViewBag.ProgramSortParm = _sortOrder == "Program" ? "Program_desc" : "Program";
                ViewBag.InstitutionSortParm = _sortOrder == "Institution" ? "Institution_desc" : "Institution";
                ViewBag.TotalErrorsSortParm = _sortOrder == "Errors" ? "Errors_desc" : "Errors";
                ViewBag.WaiveBenefitSortParm = _sortOrder == "WaiveBenefit" ? "WaiveBenefit_desc" : "WaiveBenefit";
                ViewBag.ElectBenefitSortParm = _sortOrder == "ElectBenefit" ? "ElectBenefit_desc" : "ElectBenefit";
                ViewBag.LinkCardSortParm = _sortOrder == "LinkCard" ? "LinkCard_desc" : "LinkCard";
                ViewBag.UnlinkCardSortParm = _sortOrder == "UnlinkCard" ? "UnlinkCard_desc" : "UnlinkCard";
                ViewBag.WebServicesSortParm = _sortOrder == "WebService" ? "WebService_desc" : "WebService";
            }

            switch (_sortOrder)
            {
                case "Program_desc":
                    entries = entries.OrderByDescending(s => s.Program);
                    break;
                case "Program":
                    entries = entries.OrderBy(s => s.Program);
                    break;
                case "Institution_desc":
                    entries = entries.OrderByDescending(s => s.Institution);
                    break;
                case "Institution":
                    entries = entries.OrderBy(s => s.Institution);
                    break;
                case "Errors_desc":
                    entries = entries.OrderByDescending(s => s.TotalErrors > 0 ? s.TotalErrors : s.ClearedErrors);
                    break;
                case "Errors":
                    entries = entries.OrderBy(s => s.TotalErrors > 0 ? s.TotalErrors : s.ClearedErrors);
                    break;
                case "WaiveBenefit_desc":
                    entries = entries.OrderByDescending(s => s.WaiveBenefits);
                    break;
                case "WaiveBenefit":
                    entries = entries.OrderBy(s => s.WaiveBenefits);
                    break;
                case "ElectBenefit_desc":
                    entries = entries.OrderByDescending(s => s.ElectBenefits);
                    break;
                case "ElectBenefit":
                    entries = entries.OrderBy(s => s.ElectBenefits);
                    break;
                case "LinkCard_desc":
                    entries = entries.OrderByDescending(s => s.LinkCards);
                    break;
                case "LinkCard":
                    entries = entries.OrderBy(s => s.LinkCards);
                    break;
                case "UnlinkCard_desc":
                    entries = entries.OrderByDescending(s => s.UnlinkCards);
                    break;
                case "UnlinkCard":
                    entries = entries.OrderBy(s => s.UnlinkCards);
                    break;
                case "WebService_desc":
                    entries = entries.OrderByDescending(s => s.UpassWebServices);
                    break;
                case "WebService":
                    entries = entries.OrderBy(s => s.UpassWebServices);
                    break;

                default:
                    entries = entries.OrderByDescending(s => s.DateStart);
                    break;
            }

            return entries.ToPagedList(_wpageNumber2, PageSize);
        }

        public PartialViewResult WSUpdatePartial2(string sortOrder8, int? page)
        {
            StartDate = (DateTime)Session["StartDate"];
            EndDate = (DateTime)Session["EndDate"];
            ViewBag.WSPartial2 = WSUpdate2(sortOrder8, page);
            ViewBag.WSPartial1 = _wfilteredLog1.ToPagedList(_wpageNumber1, PageSize);
            ViewBag.WSPartial3 = _wfilteredLog3.ToPagedList(_wpageNumber3, PageSize);
            return PartialView("_PartialTabWS", null);
        }


        private IEnumerable<WebServiceOperationStatus> WSGenListFromLog3(DateTime startDate, DateTime endDate)
        {
            NcsInfo ret = null;
            if (Logs.GeneralLog == null || Logs.GeneralLog.Count() == 0)
            {
                Logs.GeneralLog = Logs.CreateGeneralEventLog();
            }

            var entries = Logs.GeneralLog
                .Where(x => x.ProcessDatetime >= startDate &&
                            x.ProcessDatetime <= endDate &&
                            x.Environment.ToUpper() == _environment.ToUpper() &&
                            x.URIType != "sFTP")
                .GroupBy(x => new { x.ProgramID, x.InstitutionID, x.CategoryID, x.GUID })
                .Select(g => new WebServiceOperationStatus
                {
                    ID = g.First().ID,
                    TaskID = g.First().TaskID,
                    InstitutionID = g.Key.InstitutionID,
                    Institution = (ret = Logs.GetNCSInfo(g.Key.InstitutionID)) != null ? ret.Name : null,
                    DateStart = g.First().ProcessDatetime,
                    Program = g.Key.ProgramID,
                    CategoryID = g.Key.CategoryID,
                    Category = g.First().Category,
                    GUID = g.Key.GUID,
                    CardSerialNumber = g.First().CardSerialNumber,
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
                        TaskID = g.First().TaskID,
                        LogLevel = e.Level
                    }).ToList(),
                    UniqueParticipantID = g.First().UniqueParticipantId,
                    URI = g.First().URI,
                    TotalErrors = g.Where(s => s.Level == EVENT_STATUS.ERROR || s.Level == EVENT_STATUS.WARNING).Count(),
                    ClearedErrors = g.Where(c => c.Level == EVENT_STATUS.CLEARED).Count(),
                    Acknowledged = g.Where(a => a.Level == EVENT_STATUS.ACKNOWLEDGED).Count(),
                });

            return entries;
        }

        public IPagedList<WebServiceOperationStatus> WSUpdate3(string sortOrder, int? page)
        {
            if (page != null)
            {
                Page = (int)page;
            }
            _wpageNumber3 = Page;
            _wfilteredLog3 = WSGenListFromLog3(StartDate, EndDate).ToList();

            if (!String.IsNullOrEmpty(sortOrder))
            {
                _sortOrder = sortOrder;
            }

            ViewBag.CurrentSort = _sortOrder;

            var entries = from entry in _wfilteredLog3
                          select entry;

            if (page == null)
            {

                ViewBag.DateTimeStartSortParm = _sortOrder == "DateTimeStart" ? "DateTimeStart_desc" : "DateTimeStart";
                ViewBag.ProgramSortParm = _sortOrder == "Program" ? "Program_desc" : "Program";
                ViewBag.InstitutionSortParm = _sortOrder == "Institution" ? "Institution_desc" : "Institution";
                ViewBag.CategorySortParm = _sortOrder == "Category" ? "Category_desc" : "Category";
                ViewBag.EventSortParm = _sortOrder == "Event" ? "Event_desc" : "Event";
                ViewBag.GUIDSortParm = _sortOrder == "GUID" ? "GUID_desc" : "GUID";
                //ViewBag.ElapsedTimeSortParm = _sortOrder == "ElapsedTime" ? "ElapsedTime_desc" : "ElapsedTime";
                ViewBag.StatusSortParm = _sortOrder == "Status" ? "Status_desc" : "Status";
            }

            switch (_sortOrder)
            {
                case "DateTimeStart":
                    entries = entries.OrderBy(s => s.DateStart);
                    break;
                case "Program_desc":
                    entries = entries.OrderByDescending(s => s.Program);
                    break;
                case "Program":
                    entries = entries.OrderBy(s => s.Program);
                    break;
                case "Institution_desc":
                    entries = entries.OrderByDescending(s => s.Institution);
                    break;
                case "Institution":
                    entries = entries.OrderBy(s => s.Institution);
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
                //case "ElapsedTime_desc":
                //    entries = entries.OrderByDescending(s => s.Events.First().ProcessTime);
                //    break;
                //case "ElapsedTime":
                //    entries = entries.OrderBy(s => s.Events.First().ProcessTime);
                //    break;
                case "Status_desc":
                    entries = entries.OrderByDescending(s => s.TotalErrors > 0 ? s.TotalErrors : (s.ClearedErrors > 0 ? s.ClearedErrors : s.Acknowledged));
                    break;
                case "Status":
                    entries = entries.OrderBy(s => s.TotalErrors > 0 ? s.TotalErrors : (s.ClearedErrors > 0 ? s.ClearedErrors : s.Acknowledged));
                    break;

                default:
                    entries = entries.OrderByDescending(s => s.DateStart);
                    break;
            }

            return entries.ToPagedList(_wpageNumber3, PageSize);
        }

        public PartialViewResult WSUpdatePartial3(string sortOrder9, int? page)
        {
            StartDate = (DateTime)Session["StartDate"];
            EndDate = (DateTime)Session["EndDate"];
            ViewBag.WSPartial3 = WSUpdate3(sortOrder9, page);
            ViewBag.WSPartial1 = _wfilteredLog1.ToPagedList(_wpageNumber1, PageSize);
            ViewBag.WSPartial2 = _wfilteredLog2.ToPagedList(_wpageNumber2, PageSize);
            return PartialView("_PartialTabWS", null);
        }

        [OutputCache(Duration = 3600, Location = OutputCacheLocation.Client, NoStore = true)]
        public ActionResult GetTabWSEvents(long ID)
        {
            var result = _wfilteredLog3.Where(x => x.ID == ID).ToList();

            return View("_PartialEvents", result.FirstOrDefault());
        }

#if false
        public void UpdateGeneralLog(int cate, int evt, long dateStartTicks, int status)
        {
            //var ErrorList = Logs.GenerateErrorList();
            var log = Logs.GeneralLog.ToList();
            if (status == (int)STATUS.ACTIVE)
            {
                var subList = log.Where(x => x.Level == EVENT_STATUS.ERROR && x.EventID == evt && x.CategoryID == cate && x.ProcessDatetime.Ticks <= dateStartTicks).ToList();
                foreach (GeneralEventLog l in subList)
                {
                    l.Level = EVENT_STATUS.CLEARED;
                }
            }
            else
            {
                var subList = log.Where(x => x.Level == EVENT_STATUS.CLEARED && x.EventID == evt && x.CategoryID == cate && x.ProcessDatetime.Ticks <= dateStartTicks).ToList();
                foreach (GeneralEventLog l in subList)
                {
                    l.Level = EVENT_STATUS.ERROR;
                }
            }
        }
#endif
        #endregion

        #region JavaScript call back functions


        // Overload above method and will eventually replace the overloaded one

        public ActionResult UpdateErrorListStatus(string programID, string institutionID, int cate, int evt, long processDatetimeTicks, int status, long ID)
        {
            try
            {
                DataAccess da = new DataAccess();
                if (cate > 0 && evt > 0)
                {
                    da.SpUpdateErrorList(evt, cate, processDatetimeTicks, status, User.Identity.Name, programID, institutionID);
                    Logs.GeneralLog = Logs.UpdateGeneralEventLogLevel(Logs.GeneralLog, cate, evt, processDatetimeTicks, status, programID, institutionID);
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
            StartDate = (DateTime)Session["StartDate"];
            EndDate = (DateTime)Session["EndDate"];

            ViewBag.Partial1 = Update1(null, _pageNumber1);
            ViewBag.Partial2 = Update2(null, _pageNumber2);
            ViewBag.Partial3 = Update3(null, _pageNumber3);

            return PartialView("_PartialTabMonitor", null);
        }

        public ActionResult FilesUpdateErrorListStatus(string programID, string institutionID, int cate, int evt, long processDatetimeTicks, int status, long ID)
        {
            try
            {
                DataAccess da = new DataAccess();
                if (cate > 0 && evt > 0)
                {
                    da.SpUpdateErrorList(evt, cate, processDatetimeTicks, status, User.Identity.Name, programID, institutionID);
                    Logs.GeneralLog = Logs.UpdateGeneralEventLogLevel(Logs.GeneralLog, cate, evt, processDatetimeTicks, status, programID, institutionID);
                    //Logs.GeneralLog = Logs.UpdateGeneralEventLogLevel(Logs.GeneralLog, ID, status);
                    //Logs.GeneralLog = Logs.UpdateGeneralEventLogLevel(Logs.GeneralLog);
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
            StartDate = (DateTime)Session["StartDate"];
            EndDate = (DateTime)Session["EndDate"];

            ViewBag.FilesPartial1 = FilesUpdate1(null, _fpageNumber1);
            ViewBag.FilesPartial2 = FilesUpdate2(null, _fpageNumber2);
            ViewBag.FilesPartial3 = FilesUpdate3(null, _fpageNumber3);

            return PartialView("_PartialTabFiles", null);
        }

        public void SaveMessage(int cate, int evt, string message, bool isSaved, long processDatetimeTicks,
                                string program, string institutionId)
        {
            if (isSaved == false)
            {
                try
                {
                    DataAccess da = new DataAccess();
                    if (!String.IsNullOrEmpty(message))
                    {
                        message = message.Replace(@"&lt;", "<");
                        message = message.Replace(@"&gt;", ">");
                        da.SpInsertErrorMsg(cate, evt, message, processDatetimeTicks, (int)STATUS.ERROR, User.Identity.Name, program, institutionId);
                    }
                }
                catch (SqlException ex)
                {
                    throw ex;
                }
            }
        }

        public ActionResult RetrieveErrorMessage(int cate, int evt, long processDatetimeTicks,
                                                string programID = null, string institutionID = null)
        {
            List<ErrorMessage> msgList = new List<ErrorMessage>();
            int isExist = 0;
            try
            {
                DataAccess da = new DataAccess();
                SqlDataReader reader = da.SpRetrieveErrorMsg(cate, evt, processDatetimeTicks, programID, institutionID);

                while (reader.Read())
                {
                    ErrorMessage msg = new ErrorMessage();
                    msg.Message = (string)reader["Message"];
                    msg.UpdatedBy = (string)reader["UpdatedBy"];
                    msg.UpdatedDate = (DateTime)reader["UpdatedDatetime"];
                    msgList.Add(msg);
                }
                reader.Close();
                isExist = da.SpIsExistInErrorList(cate, evt, processDatetimeTicks, programID, institutionID);
            }
            catch (SqlException ex)
            {
                ViewBag.ErrorMsg = ex.Message;
                return PartialView("_Error", null);
            }
            msgList = msgList.OrderByDescending(x => x.UpdatedDate).ToList();

            if (isExist > 0)
            {
                return PartialView("_PartialTabMonitorShowErrorMessage", msgList);
            }
            else
            {
                return null;
            }
        }

        public ActionResult RetrieveSLTTrackingHistory(int cate, int evt, string programID, string institutionID)
        {
            List<ErrorMessage> msgList = new List<ErrorMessage>();
            int isExist = 0;
            try
            {
                DataAccess da = new DataAccess();
                SqlDataReader reader = da.SpRetrieveSLTTrackingHistory(cate, evt, programID, institutionID);

                while (reader.Read())
                {
                    ErrorMessage msg = new ErrorMessage();
                    msg.Message = (string)reader["Message"];
                    msg.UpdatedBy = (string)reader["UpdatedBy"];
                    msg.UpdatedDate = (DateTime)reader["UpdatedDatetime"];
                    msgList.Add(msg);
                }
                reader.Close();
            }
            catch (SqlException ex)
            {
                ViewBag.ErrorMsg = ex.Message;
                return PartialView("_Error", null);
            }
            msgList = msgList.OrderByDescending(x => x.UpdatedDate).ToList();

            return PartialView("_PartialTabMonitorShowErrorMessage", msgList);
        }

        public void SaveSLTTrackingHistory(int trackingID, string message)
        {

            try
            {
                DataAccess da = new DataAccess();
                if (!String.IsNullOrEmpty(message))
                {
                    message = message.Replace(@"&lt;", "<");
                    message = message.Replace(@"&gt;", ">");
                    da.SpInsertSLTTrackingHistory(trackingID, message, User.Identity.Name);
                }
            }
            catch (SqlException ex)
            {
                throw ex;
            }

        }

        public ActionResult UpdateDateStatus(DateTime start, DateTime end, bool updatedForSLTAlert = false)
        {
            DataLoadStatus dls = new DataLoadStatus { StartDate = start, EndDate = end, forSLTAlert = updatedForSLTAlert };
            return PartialView("_Status", dls);
        }


        // Knowledge Base popup
        public ActionResult RetrieveCPGFD_KB(int evtId, int cateId)
        {
            try
            {

                DataAccess da = new DataAccess();
                SqlDataReader reader = da.SpRetrieveCPGFD_KB(evtId, cateId);
                List<KnowledgeBase> list = new List<KnowledgeBase>();

                while (reader.Read())
                {
                    KnowledgeBase msg = new KnowledgeBase();
                    msg.EventID = (int)reader["EventID"];
                    msg.CategoryID = (int)reader["CategoryID"];
                    msg.Status = (Byte)reader["Status"];
                    msg.Description = (string)reader["Description"];
                    msg.PotentialErrors = (string)reader["PotentialErrors"];
                    msg.BusinessImpact = (string)reader["BusinessImpact"];
                    msg.Sev = (Byte)reader["Sev"];
                    msg.Resolutions = (string)reader["Resolutions"];
                    msg.CreatedBy = (string)reader["CreatedBy"];
                    msg.CreatedDatetime = (DateTime)reader["CreatedDatetime"];
                    msg.UpdatedBy = (string)reader["UpdatedBy"];
                    msg.UpdatedDatetime = (DateTime)reader["UpdatedDatetime"];

                    list.Add(msg);
                }
                reader.Close();
                return Json(list, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public ActionResult SaveCPGFD_KB(int evtId, int cateId, int status, string description, string potentialErrors,
                                 string businessImpact, int sev, string resolutions, bool isSaved)
        {
            if (isSaved == false)
            {
                try
                {

                    if (!String.IsNullOrEmpty(description))
                    {
                        description = description.Replace(@"&lt;", "<");
                        description = description.Replace(@"&gt;", ">");
                    }
                    if (!String.IsNullOrEmpty(potentialErrors))
                    {
                        potentialErrors = potentialErrors.Replace(@"&lt;", "<");
                        potentialErrors = potentialErrors.Replace(@"&gt;", ">");
                    }
                    if (!String.IsNullOrEmpty(businessImpact))
                    {
                        businessImpact = businessImpact.Replace(@"&lt;", "<");
                        businessImpact = businessImpact.Replace(@"&gt;", ">");
                    }
                    if (!String.IsNullOrEmpty(resolutions))
                    {
                        resolutions = resolutions.Replace(@"&lt;", "<");
                        resolutions = resolutions.Replace(@"&gt;", ">");
                    }


                    DataAccess da = new DataAccess();
                    da.SpUpdateCPGFD_KB(evtId, cateId, status, description, potentialErrors,
                                        businessImpact, sev, resolutions, User.Identity.Name);
                }
                catch (Exception ex)
                {
                    throw ex;
                }
            }
            return Json(new { }, JsonRequestBehavior.AllowGet);
        }

        public ActionResult ClearSLTAlertEntry(long id, TRACKING_STATUS status, string user)
        {
            try
            {
                DataAccess da = new DataAccess();
                da.SpUpdateCPGFD_SLTTracking(id, null, (int)status, user);
            }
            catch (Exception ex)
            {
                ViewBag.ErrorMsg = ex.Message;
                return PartialView("_Error", null);
            }
            ViewBag.Partial4 = RefreshSLTTrackingStatus().ToPagedList(_pageNumber4, PageSize);
            return PartialView("_PartialTabMonitorSLTAlerts", null);
        }

        #endregion

        #region Tab Application
        [HttpPost]
        public PartialViewResult AppUpdatePartial(DateTime startDate, DateTime endDate, string sortOrder, int? page)
        {
            SetDateRange(startDate, endDate);

            try
            {
                ViewBag.SyncUtilityLogs = SyncUtilityViewUpdate(startDate, endDate, sortOrder, page);
                ViewBag.AppPartial3 = AppUpdate3(sortOrder, _apageNumber3);
            }
            catch (Exception ex)
            {
                ViewBag.ErrorMsg = ex.Message;
                return PartialView("_Error", null);
            }

            return PartialView("_PartialTabApp1", null);
        }

        private IEnumerable<ErrorsBase> AppGenListFromLog1(IList<GeneralEventLog> log)
        {
            NcsInfo ret = null;

            log = log.Where(l => l.Computer.ToUpper() == _environment.ToUpper()).ToList();
            var entries = from entry in log
                          where entry.InstitutionID != null
                          group entry by entry.InstitutionID into g

                          select new ErrorsBase
                          {
                              InstitutionID = g.Key,
                              Institution = (ret = Logs.GetNCSInfo(g.Key)) != null ? ret.Name : null,
                              DateStart = Convert.ToDateTime(g.First().ProcessDatetime),
                              NCSCustomerID = ret != null ? ret.OrganizationId : 0,
                              Program = g.First().ProgramID,
                              Category = g.First().Category,
                              TotalErrors = g.Where(e => e.Level == "Error").Count(),

                          };
            return entries;
        }

        public IPagedList<ErrorsBase> AppUpdate1(DateTime? startDate, DateTime? endDate, string sortOrder, int? page)
        {
            _apageNumber1 = (page ?? 1);

            IList<GeneralEventLog> log = null;
            if (startDate.HasValue || endDate.HasValue)
            {
                log = Logs.GeneralLog.Where(l => l.ProcessDatetime >= startDate && l.ProcessDatetime <= endDate).ToList();
                _afilteredLog1 = AppGenListFromLog1(log).ToList();
                StartDate = (DateTime)startDate;
                EndDate = (DateTime)endDate;
            }
            else if (startDate.HasValue)
            {
                log = Logs.GeneralLog.Where(l => l.ProcessDatetime >= startDate && l.ProcessDatetime <= EndDate).ToList();
                _afilteredLog1 = AppGenListFromLog1(log).ToList();
                StartDate = (DateTime)startDate;
            }
            else if (endDate.HasValue)
            {
                log = Logs.GeneralLog.Where(l => l.ProcessDatetime >= StartDate && l.ProcessDatetime <= endDate).ToList();
                _afilteredLog1 = AppGenListFromLog1(log).ToList();
                EndDate = (DateTime)endDate;
            }

            if (!String.IsNullOrEmpty(sortOrder))
            {
                _sortOrder = sortOrder;
            }
            ViewBag.CurrentSort = _sortOrder;
            ViewBag.startDate = StartDate;
            ViewBag.endDate = EndDate;

            var entries = from entry in _afilteredLog1
                          select entry;

            if (page == null && !startDate.HasValue && !endDate.HasValue)
            {
                ViewBag.ProgramSortParm = _sortOrder == "Program" ? "Program_desc" : "Program";
                ViewBag.InstitutionSortParm = _sortOrder == "Institution" ? "Institution_desc" : "Institution";
                ViewBag.NCSCustomerIDSortParm = _sortOrder == "NCSCustomerID" ? "NCSCustomerID_desc" : "NCSCustomerID";
                ViewBag.TotalErrorsSortParm = _sortOrder == "TotalErrors" ? "TotalErrors_desc" : "TotalErrors";
            }

            switch (_sortOrder)
            {
                case "Program_desc":
                    entries = entries.OrderByDescending(s => s.Program);
                    break;
                case "Institution_desc":
                    entries = entries.OrderByDescending(s => s.Institution);
                    break;
                case "Institution":
                    entries = entries.OrderBy(s => s.Institution);
                    break;
                case "NCSCustomerID_desc":
                    entries = entries.OrderByDescending(s => s.NCSCustomerID);
                    break;
                case "NCSCustomerID":
                    entries = entries.OrderBy(s => s.NCSCustomerID);
                    break;
                case "TotalErrors_desc":
                    entries = entries.OrderByDescending(s => s.TotalErrors);
                    break;
                case "TotalErrors":
                    entries = entries.OrderBy(s => s.TotalErrors);
                    break;
                default:
                    entries = entries.OrderBy(s => s.Program);
                    break;
            }
            return entries.ToPagedList(_apageNumber1, PageSize);
        }

        public PartialViewResult AppUpdatePartial1(DateTime? startDate, DateTime? endDate, string sortOrder10, int? page)
        {
            ViewBag.AppPartial1 = AppUpdate1(startDate, endDate, sortOrder10, page);
            ViewBag.AppPartial2 = _afilteredLog2.ToPagedList(_apageNumber2, PageSize);
            return PartialView("_PartialTabApp2", null);
        }

        private IEnumerable<ErrorsBase> AppGenListFromLog2(IList<GeneralEventLog> log)
        {
            NcsInfo ret = null;

            log = log.Where(l => l.Computer == _environment).ToList();
            var entries = from entry in log
                          where entry.InstitutionID != null
                          group entry by entry.InstitutionID into g

                          select new ErrorsBase
                          {
                              InstitutionID = g.Key,
                              Institution = (ret = Logs.GetNCSInfo(g.Key)) != null ? ret.Name : null,
                              DateStart = Convert.ToDateTime(g.First().ProcessDatetime),
                              NCSCustomerID = ret != null ? ret.OrganizationId : 0,
                              Program = g.First().ProgramID,
                              Category = g.First().Category,
                              TotalErrors = g.Where(e => e.Level == "Error").Count(),

                          };
            return entries;
        }

        private IPagedList<GeneralEventLog> SyncUtilityViewUpdate(DateTime startDate, DateTime endDate, string sortOrder, int? page)
        {
            {
                var log = Logs.GeneralLog.Where(l => l.ProcessDatetime >= startDate && l.ProcessDatetime <= endDate).ToList();
                //_afilteredLog2 = AppGenListFromLog2(log).ToList();
                _syncUtilityGeneralLog = FilterSyncUtilityLogs(log).ToList();

            }

            if (String.IsNullOrEmpty(sortOrder))
            {
                sortOrder = SortColumnName.ProcessDatetime + "_desc";
            }

            ViewBag.CurrentSort = sortOrder;
            ViewBag.startDate = StartDate;
            ViewBag.endDate = EndDate;

            ViewBag.DateTimeSortParm = sortOrder == SortColumnName.ProcessDatetime
                ? SortColumnName.ProcessDatetime + "_desc"
                : SortColumnName.ProcessDatetime;
            ViewBag.EventSortParm = sortOrder == SortColumnName.Event
                ? SortColumnName.Event + "_desc"
                : SortColumnName.Event;
            ViewBag.StatusSortParm = sortOrder == SortColumnName.Status
                ? SortColumnName.Status + "_desc"
                : SortColumnName.Status;

            //return _syncUtilityGeneralLog.ToPagedList((page?? 1), PageSize);
            return SortAndPageLogs(_syncUtilityGeneralLog, sortOrder, (page ?? 1));
        }

        private static IPagedList<GeneralEventLog> SortAndPageLogs(IEnumerable<GeneralEventLog> entries, string sortOrder, int page, int pageSize = PageSize)
        {
            switch (sortOrder)
            {
                case SortColumnName.ProcessDatetime + "_desc":
                    entries = entries.OrderByDescending(s => s.ProcessDatetime);
                    break;
                case SortColumnName.ProcessDatetime:
                    entries = entries.OrderBy(s => s.ProcessDatetime);
                    break;
                case SortColumnName.Program + "_desc":
                    entries = entries.OrderByDescending(s => s.ProgramID);
                    break;
                case SortColumnName.Program:
                    entries = entries.OrderBy(s => s.ProgramID);
                    break;
                case SortColumnName.Institution + "_desc":
                    entries = entries.OrderByDescending(s => s.InstitutionID);
                    break;
                case SortColumnName.Institution:
                    entries = entries.OrderBy(s => s.InstitutionID);
                    break;
                case SortColumnName.Event + "_desc":
                    entries = entries.OrderByDescending(s => s.Event);
                    break;
                case SortColumnName.Event:
                    entries = entries.OrderBy(s => s.Event);
                    break;
                case SortColumnName.Status + "_desc":
                    entries = entries.OrderByDescending(s => s.ProcessErrorID);
                    break;
                case SortColumnName.Status:
                    entries = entries.OrderBy(s => s.ProcessErrorID);
                    break;
            }
            return entries.ToPagedList(page, pageSize);
        }

        private static IEnumerable<GeneralEventLog> FilterSyncUtilityLogs(IEnumerable<GeneralEventLog> log)
        {
            var entries = log.Where(l => l.CategoryID == EventCategoryId.SyncUtility && l.Environment == _environment).OrderByDescending(l => l.LoggedTime);
            return entries;
        }

        public PartialViewResult AppUpdatePartial2(DateTime? startDate, DateTime? endDate, string sortOrder11, int? page)
        {
            var sortOrder = sortOrder11;

            ViewBag.CurrentSort = sortOrder;
            ViewBag.startDate = StartDate;
            ViewBag.endDate = EndDate;

            ViewBag.DateTimeSortParm = sortOrder == SortColumnName.ProcessDatetime
                ? SortColumnName.ProcessDatetime + "_desc"
                : SortColumnName.ProcessDatetime;
            ViewBag.EventSortParm = sortOrder == SortColumnName.Event
                ? SortColumnName.Event + "_desc"
                : SortColumnName.Event;
            ViewBag.StatusSortParm = sortOrder == SortColumnName.Status
                ? SortColumnName.Status + "_desc"
                : SortColumnName.Status;

            ViewBag.SyncUtilityLogs = SortAndPageLogs(_syncUtilityGeneralLog, sortOrder, (page ?? 1));
            return PartialView("_PartialTabApp2", null);
        }


        private IEnumerable<ErrorsBase> AppGenListFromLog3(DateTime startDate, DateTime endDate)
        {
#if true
            NcsInfo ret = null;
            if (Logs.GeneralLog == null || Logs.GeneralLog.Count() == 0)
            {
                Logs.GeneralLog = Logs.CreateGeneralEventLog();
            }
            var entries = Logs.GeneralLog
                .Where(x => x.ProcessDatetime >= startDate &&
                            x.ProcessDatetime <= endDate &&
                            x.Environment.ToUpper() == _environment.ToUpper() &&
                            x.CategoryID >= EventCategoryId.ConfiscationRequestedTask &&
                            x.CategoryID <= EventCategoryId.ConfiscationCreateNotificationTaskPendingTask)
                .GroupBy(x => new { x.CategoryID })
                .Select(g => new ErrorsBase
                {
                    NCSCustomerID = (ret = Logs.GetNCSInfo(g.First().InstitutionID)) != null ? ret.OrganizationId : 0,
                    Level = g.First().Level,
                    ID = g.First().ID,
                    Program = g.First().ProgramID,
                    InstitutionID = g.First().InstitutionID,
                    Institution = ret != null ? ret.Name : null,
                    CategoryID = g.Key.CategoryID,
                    Category = g.First().Category,
                    EventID = g.First().EventID,
                    Event = g.First().Event,
                    ProcessDatetime = g.First().ProcessDatetime,
                    TotalErrors = g.Where(f => f.Level == EVENT_STATUS.ERROR || f.Level == EVENT_STATUS.WARNING).Count(),
                    ClearedErrors = g.Where(c => c.Level == EVENT_STATUS.CLEARED).Count(),
                    Acknowledged = g.Where(a => a.Level == EVENT_STATUS.ACKNOWLEDGED).Count(),
                    CurrentClicked = g.First().CurrentClicked,
                });


            return entries;
#else
            NcsInfo ret = null;
            if (Logs.GeneralLog == null || Logs.GeneralLog.Count() == 0)
            {
                Logs.GeneralLog = Logs.CreateGeneralEventLog();
            }
            var entries = Logs.GeneralLog
                .Where(x => x.ProcessDatetime >= startDate &&
                            x.ProcessDatetime <= endDate &&
                            x.Environment.ToUpper() == _environment.ToUpper() &&
                            x.CategoryID >= CATEGORY_ID_CONFISCATION.ConfiscationRequestedTask &&
                            x.CategoryID <= CATEGORY_ID_CONFISCATION.ConfiscationCreateNotificationTaskPendingTask &&
                            (x.Level == EVENT_STATUS.ERROR || x.Level == EVENT_STATUS.WARNING ||
                             x.Level == EVENT_STATUS.CLEARED || x.Level == EVENT_STATUS.ACKNOWLEDGED))
                .GroupBy(x => new { x.ProgramID, x.InstitutionID, x.CategoryID, x.EventID, x.ProcessErrorDescr })
                .Select(g => new HHUEventLog
                {
                    NCSCustomerID = (ret = Logs.GetNCSInfo(g.Key.InstitutionID)) != null ? ret.OrganizationId : 0,
                    Level = g.First().Level,
                    ID = g.First().ID,
                    ProgramID = g.First().ProgramID,
                    InstitutionID = g.Key.InstitutionID,
                    Institution = ret != null ? ret.Name : null,
                    CategoryID = g.Key.CategoryID,
                    Category = g.First().Category,
                    EventID = g.Key.EventID,
                    Event = g.First().Event,
                    URI = g.First().URI,
                    URIType = g.First().URIType,
                    ProcessDatetime = g.First().ProcessDatetime,
                    Location = g.First().Location,
                    FareInstrumentID = (int)g.First().FareInstrumentID,
                    HHUReasonCode = (int)g.First().HHUReasonCode,
                    HHUUserID = (int)g.First().HHUUserID,
                    ConfiscationDatetime = g.First().ConfiscationDatetime,
                    CardLinkState = (int)g.First().CardLinkState,
                    CardState = (int)g.First().CardState,
                    ProcessErrorID = g.First().ProcessErrorID,
                    ProcessErrorDescr = g.First().ProcessErrorDescr,
                    TotalErrors = g.Where(f => f.Level == EVENT_STATUS.ERROR || f.Level == EVENT_STATUS.WARNING).Count(),
                    ClearedErrors = g.Where(c => c.Level == EVENT_STATUS.CLEARED).Count(),
                    Acknowledged = g.Where(a => a.Level == EVENT_STATUS.ACKNOWLEDGED).Count(),
                    CurrentClicked = g.First().CurrentClicked,
                });

            return entries;
#endif
        }

        public IPagedList<ErrorsBase> AppUpdate3(string sortOrder, int? page)
        {
            if (page != null)
            {
                Page = (int)page;
            }
            if (Page == 0)
            {
                Page = 1;
            }
            _apageNumber3 = Page;
            _afilteredLog3 = AppGenListFromLog3((DateTime)Session["StartDate"], (DateTime)Session["EndDate"]).ToList();

            if (!String.IsNullOrEmpty(sortOrder))
            {
                _sortOrder = sortOrder;
            }
            ViewBag.CurrentSort = _sortOrder;

            var entries = from entry in _afilteredLog3
                          select entry;

            if (page == null)
            {
                ViewBag.ProcessDatetimeSortParm = _sortOrder == "ProcessDatetime" ? "ProcessDatetime_desc" : "ProcessDatetime";
                ViewBag.CategorySortParm = _sortOrder == "Category" ? "Categorydesc" : "Category";
                ViewBag.EventSortParm = _sortOrder == "Event" ? "Event_desc" : "Event";
                ViewBag.StatusSortParm = _sortOrder == "Status" ? "Status_desc" : "Status";
            }

            switch (_sortOrder)
            {
                case "ProcessDatetime":
                    entries = entries.OrderBy(s => s.ProcessDatetime);
                    break;
                case "Category_desc":
                    entries = entries.OrderByDescending(s => s.CategoryID);
                    break;
                case "Category":
                    entries = entries.OrderBy(s => s.CategoryID);
                    break;
                case "Event_desc":
                    entries = entries.OrderByDescending(s => s.EventID);
                    break;
                case "Event":
                    entries = entries.OrderBy(s => s.EventID);
                    break;
                case "Status_desc":
                    entries = entries.OrderByDescending(s => s.TotalErrors);
                    break;
                case "Status":
                    entries = entries.OrderBy(s => s.TotalErrors);
                    break;
                default:
                    entries = entries.OrderByDescending(s => s.ProcessDatetime);
                    break;
            }
            return entries.ToPagedList(_apageNumber3, PageSize);
        }

        public PartialViewResult AppUpdatePartial3(string sortOrder10, int? page)
        {
            ViewBag.AppPartial3 = AppUpdate3(sortOrder10, page);
            return PartialView("_PartialTabApp3", null);
        }




        public PartialViewResult AppSyncUtilityOnDateRangeChanges(DateTime startDate, DateTime endDate, string sortOrder = " ", int? page = 1)
        {
            //SetDateRange(startDate, endDate);

            try
            {
                ViewBag.SyncUtilityLogs = SyncUtilityViewUpdate(startDate, endDate, sortOrder, page);
            }
            catch (Exception ex)
            {
                ViewBag.ErrorMsg = ex.Message;
                return PartialView("_Error", null);
            }

            return PartialView("_PartialTabApp2", null);
        }


        public PartialViewResult AppHHUOnDateRangeChanges(DateTime startDate, DateTime endDate, string sortOrder = " ", int? page = 1)
        {
            //SetDateRange(startDate, endDate);

            try
            {
                ViewBag.AppPartial3 = AppUpdate3(sortOrder, page);
            }
            catch (Exception ex)
            {
                ViewBag.ErrorMsg = ex.Message;
                return PartialView("_Error", null);
            }

            return PartialView("_PartialTabApp3", null);
        }


        #endregion

        #region Check EventSentry Status

        public ActionResult MonitorEventSentry()
        {
            List<EventSentryStatus> lst;
            try
            {
                DataAccess da = new DataAccess();
                DataTable dt;
                da.OpenConnection();
                dt = da.SpRetrieveEventSentryStatus();
                lst = (from c in dt.AsEnumerable()
                       select new EventSentryStatus()
                       {
                           Server = c[0].ToString(),
                           LastUpdateTime = DateTime.Parse(c[1].ToString()),
                       }
                      ).ToList();
            }
            catch (SqlException ex)
            {
                ViewBag.ErrorMsg = ex.Message;
                return PartialView("_Error", null);
            }

            return PartialView("_PartialEventSentryStatus", lst);
        }

        #endregion

        #region UpdateStatus

        public ActionResult UpdateStatus()
        {
            DataLoadStatus dls = new DataLoadStatus { StartDate = StartDate, EndDate = EndDate };

            return View("_Status", dls);
        }

        #endregion

    }
}
