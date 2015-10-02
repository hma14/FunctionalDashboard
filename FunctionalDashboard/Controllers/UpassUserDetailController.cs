    using FunctionalDashboard.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using PagedList;
using System.IO;
using System.Xml.Linq;
using System.Xml;
using FunctionalDashboard.ViewModels;

namespace FunctionalDashboard.Controllers
{
    public class UpassUserDetailController : BaseController
    {
        private static string InstitutionID { get; set; }
        private static string GUID { get; set; }
        private static string TSID { get; set; }

        public static int Page1 { get; set; }
        public static int Page2 { get; set; }
        public static int Page3 { get; set; }
        private static string SortOrder1 { get; set; }
        private static string SortOrder2 { get; set; }
        private static string SortOrder3 { get; set; }

        private static IEnumerable<SetEligibilityRequest> Entry1 { get; set; }
        private static IEnumerable<SetCardRequest> Entry2 { get; set; }
        private static IEnumerable<SetBenefitRequest> Entry3 { get; set; }

        const int pageSize = 5;

        #region Index
        public ActionResult Index(string institutionID, string guid, string tsid)
        {

            if (!string.IsNullOrEmpty(institutionID))
            {
                InstitutionID = institutionID;
                Session["InstitutionID"] = InstitutionID;
            }

            if(!string.IsNullOrEmpty(guid))
            {
                GUID = guid;
            }

            if (!string.IsNullOrEmpty(tsid))
            {
                TSID = tsid;
            }          


            // Get current Server from which EventLog is being monitored and display
            SetCurrentServer();

            // Get total memory used so far and set and display
            SetCurrentProcessMemorySize();

            Page1 = Page2 = Page3 = 1;

            Entry1 = GenListSetEligibilityRequest();
            ViewBag.SetEligibilityRequest = Entry1.ToPagedList(Page1, pageSize);

            Entry2 = GenListSetCardRequest();
            ViewBag.SetCardRequest = Entry2.ToPagedList(Page2, pageSize);

            Entry3 = GenListSetBenefitRequest();
            ViewBag.SetBenefitRequest = Entry3.ToPagedList(Page3, pageSize);


            setViewBags();

            return View();

        }
        #endregion

        #region UpdateSetEligibilityRequest

        public PartialViewResult UpdateSetEligibilityRequest(int? page, string sortOrder)
        {

            if (!String.IsNullOrEmpty(sortOrder))
            {
                SortOrder1 = sortOrder;
            }

            if (page != null)
            {
                Page1 = (int)page;
            }

            Entry1 = SetEligibilityRequestPaging(page);
            
            setViewBags();
            return PartialView("_UserDetail", null);
        }
       
        private IEnumerable<SetEligibilityRequest> SetEligibilityRequestPaging(int? page)
        {
            if (page == null)
            {
                ViewBag.DateSortParm = SortOrder1 == "Date" ? "Date_desc" : "Date";
                ViewBag.EligSortParm = SortOrder1 == "Elig" ? "Elig_desc" : "Elig";
                ViewBag.DatetimeProcessedSortParm = SortOrder1 == "DatetimeProcessed" ? "DatetimeProcessed_desc" : "DatetimeProcessed";
                ViewBag.StatusSortParm = SortOrder1 == "Status" ? "Status_desc" : "Status";
            }

            switch (SortOrder1)
            {
                case "Date":
                    Entry1 = Entry1.OrderBy(s => s.EligDate);
                    break;
                case "Elig_desc":
                    Entry1 = Entry1.OrderByDescending(s => s.Elig);
                    break;
                case "Elig":
                    Entry1 = Entry1.OrderBy(s => s.Elig);
                    break;
                case "DatetimeProcessed_desc":
                    Entry1 = Entry1.OrderByDescending(s => s.DatetimeProcessed);
                    break;
                case "DatetimeProcessed":
                    Entry1 = Entry1.OrderBy(s => s.DatetimeProcessed);
                    break;
                case "Status_desc":
                    Entry1 = Entry1.OrderByDescending(s => s.Status);
                    break;
                case "Status":
                    Entry1 = Entry1.OrderBy(s => s.Status);
                    break;

                default:
                    Entry1 = Entry1.OrderByDescending(s => s.EligDate);
                    break;
            }

            ViewBag.CurrentSort1 = SortOrder1;
            return Entry1;
        }

        private IEnumerable<SetEligibilityRequest> GenListSetEligibilityRequest()
        {

            if (Logs.GeneralLog == null || Logs.GeneralLog.Count() == 0)
            {
                Logs.GeneralLog = Logs.CreateGeneralEventLog();
            }
            else
            {
                Logs.GeneralLog = Logs.UpdateGeneralEventLogLevel(Logs.GeneralLog);
            }

            var entries = (from e in Logs.GeneralLog
                            where e.ProgramID == PROGRAM_ID.UPASS &&
                                e.InstitutionID == InstitutionID &&
                                (e.UniqueParticipantId == GUID || e.GUID == GUID) &&
                                e.EventID == EVENT_NAME_ID.UpassEligibilityStatusEnded &&
                                e.CategoryID == CATEGORY_ID_WEBSERVICES.ELIGIBILITY_STATUS
                            orderby e.ProcessDatetime descending
                            select new SetEligibilityRequest
                            {
                                DatetimeProcessed = e.ProcessDatetime,
                                EligDate = e.EligDate,
                                Elig = e.Elig,
                                Status = e.Rval,
                            }).ToList();

            return entries;
            
        }

        #endregion

        #region UpdateSetCardRequest

        public PartialViewResult UpdateSetCardRequest(int? page, string sortOrder)
        {
            if (!String.IsNullOrEmpty(sortOrder))
            {
                SortOrder2 = sortOrder;
            }

            if (page != null)
            {
                Page2 = (int)page;
            }

            Entry2 = SetCardRequestPaging(page);

            
            setViewBags();
            
            return PartialView("_UserDetail", null);
        }

        private IEnumerable<SetCardRequest> SetCardRequestPaging(int? page)
        {
            if (page == null)
            {
                ViewBag.CardSerialNumberSortParm = SortOrder2 == "CSN" ? "CSN_desc" : "CSN";
                ViewBag.CategorySortParm = SortOrder2 == "Category" ? "Category_desc" : "Category";
                ViewBag.EventSortParm = SortOrder2 == "Event" ? "Event_desc" : "Event";
                ViewBag.DatetimeProcessedSortParm = SortOrder2 == "DatetimeProcessed" ? "DatetimeProcessed_desc" : "DatetimeProcessed";
                ViewBag.StatusSortParm = SortOrder2 == "Status" ? "Status_desc" : "Status";
            }

            switch (SortOrder2)
            {
                case "Date":
                    Entry2 = Entry2.OrderBy(s => s.CardSerialNumber);
                    break;
                case "Date_desc":
                    Entry2 = Entry2.OrderByDescending(s => s.CardSerialNumber);
                    break;
                case "Category_desc":
                    Entry2 = Entry2.OrderByDescending(s => s.Category);
                    break;
                case "Category":
                    Entry2 = Entry2.OrderBy(s => s.Category);
                    break;
                case "Event_desc":
                    Entry2 = Entry2.OrderByDescending(s => s.Event);
                    break;
                case "Event":
                    Entry2 = Entry2.OrderBy(s => s.Event);
                    break;
                case "DatetimeProcessed":
                    Entry2 = Entry2.OrderBy(s => s.DatetimeProcessed);
                    break;
                case "Status_desc":
                    Entry2 = Entry2.OrderByDescending(s => s.Status);
                    break;
                case "Status":
                    Entry2 = Entry2.OrderBy(s => s.Status);
                    break;

                default:
                    Entry2 = Entry2.OrderByDescending(s => s.DatetimeProcessed);
                    break;
            }

            ViewBag.CurrentSort2 = SortOrder2;

            return Entry2;
        }

        private IEnumerable<SetCardRequest> GenListSetCardRequest()
        {
            if (Logs.GeneralLog == null || Logs.GeneralLog.Count() == 0)
            {
                Logs.GeneralLog = Logs.CreateGeneralEventLog();
            }

            var entries = ( from x in Logs.GeneralLog
                            where x.ProgramID == PROGRAM_ID.UPASS &&
                                  x.InstitutionID == InstitutionID &&
                                  (x.UniqueParticipantId == GUID || x.GUID == GUID) &&
                                  (
                                    x.CategoryID == CATEGORY_ID_WEBSERVICES.LINK_CARD  &&
                                    x.EventID == EVENT_NAME_ID.UpassLCLinkCardRequestedEnded                                  
                                    ||                                                                                                 
                                    x.CategoryID == CATEGORY_ID_WEBSERVICES.UNLINK_CARD  &&
                                    x.EventID == EVENT_NAME_ID.UpassUCUnlinkCardRequestedEnded 
                                  )
                                  orderby x.ProcessDatetime descending
                            select new SetCardRequest
                            {
                                CardSerialNumber = x.CardSerialNumber,
                                DatetimeProcessed = x.ProcessDatetime,
                                Category = x.Category,
                                CategoryID = x.CategoryID,
                                Event = x.Event,
                                EventID = x.EventID,
                                //Mode = x.EventID == EVENT_NAME_ID.UpassLCLinkCardRequestedEnded && x.CategoryID == CATEGORY_ID_WEBSERVICES.LINK_CARD ? "Link" : "Unlink",
                                Status = x.Level,
                            }).ToList();

            return entries;
        }

        #endregion

        #region UpdateSetBenefitRequest

        public PartialViewResult UpdateSetBenefitRequest(int? page, string sortOrder)
        {
            if (!String.IsNullOrEmpty(sortOrder))
            {
                SortOrder3 = sortOrder;
            }

            if (page != null)
            {
                Page3 = (int)page;
            }

            Entry3 = SetBenefitRequestPaging(page);

            
            setViewBags();
            //ViewBag.SetBenefitRequest = Entry3.ToPagedList(Page3, pageSize);
            return PartialView("_UserDetail", null);
        }

        private IEnumerable<SetBenefitRequest> SetBenefitRequestPaging(int? page)
        {
            if (page == null)
            {
                ViewBag.BenefitIDSortParm = SortOrder3 == "BenefitID" ? "BenefitID_desc" : "BenefitID";
                ViewBag.BenefitProductIDSortParm = SortOrder3 == "BenefitProductID" ? "BenefitProductID_desc" : "BenefitProductID";
                ViewBag.BenefitMonthSortParm = SortOrder3 == "BenefitMonth" ? "BenefitMonth_desc" : "BenefitMonth";
                ViewBag.BenefitYearSortParm = SortOrder3 == "BenefitYear" ? "BenefitYear_desc" : "BenefitYear";
                ViewBag.CategorySortParm = SortOrder3 == "Category" ? "Category_desc" : "Category";
                ViewBag.EventSortParm = SortOrder3 == "Event" ? "Event_desc" : "Event";
                ViewBag.DatetimeProcessedSortParm = SortOrder3 == "DatetimeProcessed" ? "DatetimeProcessed_desc" : "DatetimeProcessed";
                ViewBag.StatusSortParm = SortOrder3 == "Status" ? "Status_desc" : "Status";
            }

            switch (SortOrder3)
            {
                case "BenefitID":
                    Entry3 = Entry3.OrderBy(s => s.BenefitID);
                    break;
                case "BenefitProductID_desc":
                    Entry3 = Entry3.OrderByDescending(s => s.BenefitProductID);
                    break;
                case "BenefitProductID":
                    Entry3 = Entry3.OrderBy(s => s.BenefitProductID);
                    break;
                case "BenefitMonth_desc":
                    Entry3 = Entry3.OrderByDescending(s => s.BenefitMonth);
                    break;
                case "BenefitMonth":
                    Entry3 = Entry3.OrderBy(s => s.BenefitMonth);
                    break;
                case "Category_desc":
                    Entry3 = Entry3.OrderByDescending(s => s.Category);
                    break;
                case "Category":
                    Entry3 = Entry3.OrderBy(s => s.Category);
                    break;
                case "Event_desc":
                    Entry3 = Entry3.OrderByDescending(s => s.Event);
                    break;
                case "Event":
                    Entry3 = Entry3.OrderBy(s => s.Event);
                    break;
                case "BenefitYear_desc":
                    Entry3 = Entry3.OrderByDescending(s => s.BenefitYear);
                    break;
                case "BenefitYear":
                    Entry3 = Entry3.OrderBy(s => s.BenefitYear);
                    break;
                case "DatetimeProcessed_desc":
                    Entry3 = Entry3.OrderByDescending(s => s.DatetimeProcessed);
                    break;
                case "DatetimeProcessed":
                    Entry3 = Entry3.OrderBy(s => s.DatetimeProcessed);
                    break;
                case "Status_desc":
                    Entry3 = Entry3.OrderByDescending(s => s.Status);
                    break;
                case "Status":
                    Entry3 = Entry3.OrderBy(s => s.Status);
                    break;

                default:
                    Entry3 = Entry3.OrderByDescending(s => s.BenefitID);
                    break;
            }

            ViewBag.CurrentSort3 = SortOrder3;
            return Entry3;
        }

        private IEnumerable<SetBenefitRequest> GenListSetBenefitRequest()
        {
            if (Logs.GeneralLog == null || Logs.GeneralLog.Count() == 0)
            {
                Logs.GeneralLog = Logs.CreateGeneralEventLog();
            }
#if true
            var entries = (from x in Logs.GeneralLog
                           where x.ProgramID == PROGRAM_ID.UPASS &&
                                 x.InstitutionID == InstitutionID &&
                                 (x.UniqueParticipantId == GUID || x.GUID == GUID) &&
                                 (
                                   x.EventID == EVENT_NAME_ID.UpassABUpdateMemberElectBenefitPendingEnded ||
                                   x.EventID == EVENT_NAME_ID.UpassABAddAutoLoadPendingEnded ||
                                   x.EventID == EVENT_NAME_ID.UpassRBProcessAutoloadPendingEnded
                                 ) &&
                                 (
                                   x.CategoryID == CATEGORY_ID_WEBSERVICES.ELECT_BENEFIT ||
                                   x.CategoryID == CATEGORY_ID_WEBSERVICES.WAIVE_BENEFIT
                                 )
                           orderby x.ProcessDatetime descending
                           select new SetBenefitRequest
                           {
                               BenefitID = x.BenefitID,
                               BenefitProductID = x.BenefitProductID,
                               BenefitMonth = x.BenefitMonth,
                               BenefitYear = x.BenefitYear,
                               DatetimeProcessed = x.ProcessDatetime,
                               Category = x.Category,
                               CategoryID = x.CategoryID,
                               Event = x.Event,
                               EventID = x.EventID,
                               //Mode = x.EventID == EVENT_NAME_ID.UpassABBenefitEnabledEnded && x.CategoryID == CATEGORY_ID_WEBSERVICES.ELECT_BENEFIT ? "Register" : "UnRegister",
                               Status = x.Level,
                           }).ToList();

#else
            var entries = Logs.GeneralLog
                .Where(x => x.ProgramID == PROGRAM_ID.UPASS &&
                            x.InstitutionID == InstitutionID &&
                            (x.UniqueParticipantId == GUID || x.GUID == GUID) &&
                            (
                                x.EventID == EVENT_NAME_ID.UpassABBenefitEnabledEnded ||
                                x.EventID == EVENT_NAME_ID.UpassRBWaiveBenefitRequestedEnded
                            )
                            &&
                            (
                                x.CategoryID == CATEGORY_ID_WEBSERVICES.ELECT_BENEFIT ||
                                x.CategoryID == CATEGORY_ID_WEBSERVICES.WAIVE_BENEFIT
                            ))
                .OrderByDescending(x => x.ProcessDatetime)
                .GroupBy( x => new { x.CategoryID })
                .Select(g => new SetBenefitRequest
                {
                    Benefit = g.First().Benefit,
                    DatetimeProcessed = g.First().ProcessDatetime,
                    Mode = g.First().EventID == EVENT_NAME_ID.UpassABBenefitEnabledEnded && 
                           g.First().CategoryID == CATEGORY_ID_WEBSERVICES.ELECT_BENEFIT ? "Register" : "UnRegister",
                    Status = g.First().Level,
                }).ToList();
#endif

            return entries;
        }

        #endregion






        private void setViewBags()
        {
            if (!String.IsNullOrEmpty(InstitutionID))
            {
                ViewBag.Program = PROGRAM_ID.UPASS; // ni.ProgramId;
                var ni = Logs.GetNCSInfo(InstitutionID);
                if (ni != null)
                {                    
                    ViewBag.Name = ni.Name;
                    ViewBag.OrganizationId = ni.OrganizationId;
                    ViewBag.ShortName = ni.ShortName;
                }
            }
            ViewBag.InstitutionID = InstitutionID;
            ViewBag.GUID = GUID;

            ViewBag.SetEligibilityRequest = Entry1.ToPagedList(Page1, pageSize);
            ViewBag.SetCardRequest = Entry2.ToPagedList(Page2, pageSize);
            ViewBag.SetBenefitRequest = Entry3.ToPagedList(Page3, pageSize);
        }
    }
}
