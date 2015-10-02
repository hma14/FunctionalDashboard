    using FunctionalDashboard.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
    using FunctionalDashboard.Dal.DataEntity;
    using PagedList;
using System.IO;
using System.Xml.Linq;
using System.Xml;
using FunctionalDashboard.ViewModels;

namespace FunctionalDashboard.Controllers
{
    public class PpassUserDetailController : BaseController
    {
        private static string InstitutionID { get; set; }
        private static string UniqueParticipantID { get; set; }
        private static string CSN { get; set; }
        public static int Page { get; set; }
        private static string SortOrder { get; set; }
        private static IEnumerable<UserRequestHistory> Entry { get; set; }

        const int pageSize = 10;
        public ActionResult Index(string institutionID, string uniqueParticipantID, string csn)
        {

            if (!string.IsNullOrEmpty(institutionID))
            {
                InstitutionID = institutionID;
                Session["InstitutionID"] = institutionID;
            }
            else if (!String.IsNullOrEmpty((string)Session["InstitutionID"]))
            {
                InstitutionID = (string)Session["InstitutionID"];
            }

            if(!string.IsNullOrEmpty(uniqueParticipantID))
            {
                UniqueParticipantID = uniqueParticipantID;
                Session["UniqueParticipantID"] = uniqueParticipantID;
            }
            else if (!String.IsNullOrEmpty((string)Session["UniqueParticipantID"]))
            {
                UniqueParticipantID = (string)Session["UniqueParticipantID"];
            }

            if (!string.IsNullOrEmpty(csn))
            {
                CSN = csn;
                Session["CSN"] = csn;
            }
            else if (!String.IsNullOrEmpty((string)Session["CSN"]))
            {
                CSN = (string)Session["CSN"];
            }

            // Get current Server from which EventLog is being monitored and display
            SetCurrentServer();

            // Get total memory used so far and set and display
            SetCurrentProcessMemorySize();

            if (Logs.GeneralLog == null || Logs.GeneralLog.Count() == 0)
            {
                Logs.GeneralLog = Logs.CreateGeneralEventLog();
            }
            else
            {
                Logs.GeneralLog = Logs.UpdateGeneralEventLogLevel(Logs.GeneralLog);
            }

            Entry = Logs.GeneralLog
                .Where(x => x.ProgramID == PROGRAM_ID.PPASS &&
                            x.InstitutionID == InstitutionID &&
                            x.UniqueParticipantId == UniqueParticipantID &&
                            (String.IsNullOrEmpty(CSN) ? true : x.CardSerialNumber == CSN))
                .OrderByDescending(x => x.ProcessDatetime)
                .GroupBy(x => new { x.ProcessDatetime, x.RequestTxID })
                .Select(g => new UserRequestHistory
                {
                    DatetimeProcessed = g.Key.ProcessDatetime,
                    RequestTxID = g.Key.RequestTxID,
                    Category = g.First().Category,
                    CategoryID = g.First().CategoryID,
                    Action = g.First().Action,
                    Reason = g.First().ReasonCode,
                    Errors = g.Where(e => e.Level == EVENT_STATUS.ERROR).Count(),
                    ClearedErrors = g.Where(c => c.Level == EVENT_STATUS.CLEARED).Count(),
                    Acknowledged = g.Where(a => a.Level == EVENT_STATUS.ACKNOWLEDGED).Count(),
                });

            Page = 1;
            setViewBags();

            var model = Entry.ToPagedList(Page, pageSize);
            return View(model);

        }

        public PartialViewResult UpdateRetrievedResult(int? page, string sortOrder)
        {
            if (!String.IsNullOrEmpty(sortOrder))
            {
                SortOrder = sortOrder;
            }            

            if (page != null)
            {
                Page = (int)page;
            }

            var Entry = UpdateRetrieved(page);
            setViewBags();
            var model = Entry.ToPagedList(Page, pageSize);
            return PartialView("_UserDetail", model);
        }

        private IList<UserRequestHistory> UpdateRetrieved(int? page)
        {
            if (page == null)
            {
                ViewBag.DateTimeSortParm = SortOrder == "DateTime" ? "DateTime_desc" : "DateTime";
                ViewBag.RequestTxIDSortParm = SortOrder == "RequestTxID" ? "RequestTxID_desc" : "RequestTxID";
                ViewBag.CategorySortParm = SortOrder == "Category" ? "Category_desc" : "Category";
                ViewBag.ActionSortParm = SortOrder == "Action" ? "Action_desc" : "Action";
                ViewBag.ReasonSortParm = SortOrder == "Reason" ? "Reason_desc" : "Reason";
                ViewBag.StatusSortParm = SortOrder == "Status" ? "Status_desc" : "Status";
            }

            switch (SortOrder)
            {
                case "DateTime":
                    Entry = Entry.OrderBy(s => s.DatetimeProcessed);
                    break;
                case "RequestTxID_desc":
                    Entry = Entry.OrderByDescending(s => s.RequestTxID);
                    break;
                case "RequestTxID":
                    Entry = Entry.OrderBy(s => s.RequestTxID);
                    break;
                case "Category_desc":
                    Entry = Entry.OrderByDescending(s => s.Category);
                    break;
                case "Category":
                    Entry = Entry.OrderBy(s => s.Category);
                    break;
                case "Reason_desc":
                    Entry = Entry.OrderByDescending(s => s.Reason);
                    break;
                case "Reason":
                    Entry = Entry.OrderBy(s => s.Reason);
                    break;
                case "Status_desc":
                    Entry = Entry.OrderByDescending(s => s.Errors > 0 ? s.Errors : (s.ClearedErrors > 0 ? s.ClearedErrors : s.Acknowledged));
                    break;
                case "Status":
                    Entry = Entry.OrderBy(s => s.Errors > 0 ? s.Errors : (s.ClearedErrors > 0 ? s.ClearedErrors : s.Acknowledged));
                    break;

                default:
                    Entry = Entry.OrderByDescending(s => s.DatetimeProcessed);
                    break;
            }

            return Entry.ToList();
        }

        private void setViewBags()
        {
            if (!String.IsNullOrEmpty(InstitutionID))
            {
                NcsInfo ni = Logs.GetNCSInfo(InstitutionID);
                ViewBag.Program = ni.ProgramId;
                ViewBag.Name = ni.Name;
                ViewBag.OrganizationId = ni.OrganizationId;
                ViewBag.ShortName = ni.ShortName;
            }
            ViewBag.CurrentSort = SortOrder;
            ViewBag.InstitutionID = InstitutionID;
            ViewBag.UniqueParticipantID = UniqueParticipantID;
            ViewBag.CSN = CSN;
            ViewBag.TotalErrors = Entry.Sum(e => e.Errors);
            ViewBag.TotalClearedErrors = Entry.Sum(e => e.ClearedErrors);
            ViewBag.TotalAcknowledged = Entry.Sum(a => a.Acknowledged);
        }
    }
}
