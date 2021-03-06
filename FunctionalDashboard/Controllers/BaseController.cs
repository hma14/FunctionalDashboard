﻿using FunctionalDashboard.Models;
using FunctionalDashboard.ViewModels;
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Security.Claims;
using System.Security.Principal;
using System.Web;
using System.Web.Mvc;
using FunctionalDashboard.Bal;
using FunctionalDashboard.Dal.DataEntity;
using NLog;
using System.Web.Configuration;


namespace FunctionalDashboard.Controllers
{
    //[CustomAuthorize(Users = @"BCTGTWDOM\hema, BCTGTWDOM\achen, BCTGTWDOM\ksham,  
    //                           BCTGTWDOM\jtang, BCTGTWDOM\vkaranov, BCTGTWDOM\wzhou,
    //                           BCTGTWDOM\mmorley, BCTGTWDOM\pchilds, BCTGTWDOM\wsim,
    //                           BCTGTWDOM\rchurch, BCTGTWDOM\dciocan, BCTGTWDOM\dxciocan, 
    //                           BCTGTWDOM\pkamboj")]
    public class BaseController : Controller
    {
        private readonly static Logger Logging = LogManager.GetCurrentClassLogger();

        public static string CurrentEnvironment = String.Empty;
        public static long MemorySiz = 0;
        public static DateTime LoadStarted { get; set; }
        public static DateTime LoadCompleted { get; set; }
        public static TimeSpan SLTAlertProcessTime { get; set; }

        // Date range
        public DateTime StartDate { get; set; }
        public DateTime EndDate { get; set; }

        public static readonly Dictionary<string, string> ActionMapping = new Dictionary<string, string>      
        {
            { "AB", "Add Benefit"},
            { "NC", "New Card"},
            { "RC", "Resume Card"},
            { "SC", "Suspend Card"},
            { "TC", "Terminate Card"},
        };

        public static readonly Dictionary<string, string> ReasonMapping = new Dictionary<string, string>
        {
            
            { "NB", "New Benefit"},
            { "NP", "New Participant"},
            { "RB", "Renew Benefit"},
            { "RD", "Replacement for Damaged Card"},
            { "RF", "Replacement for faulty card"},
            { "RL", "Replacement for Lost"},
            { "RM", "Unsuspend for Found Misplaced Card"},
            { "RO", "Unsuspend for Outstanding Taxi Saver Payment"},
            { "RS", "Replacement for Stolen Card"},
            { "RX", "Replacement for expired card"},
            { "SM", "Suspend for Card Temporarily Misplaced"},
            { "SO", "Suspend for Outstanding Taxi Saver Payments"},
            { "TC", "Terminate for Changed name or other participant detail"},
            { "TD", "Terminate for Damaged Card"},
            { "TF", "Terminate for Faulty Card"},
            { "TL", "Terminate for Lost Card"},
            { "TP", "Terminate for Participant Left Program"},    
            { "TS", "Terminate for Stolen Card"},   
            { "RR", "Reinstated Access Transit Reason"},
            { "SR", "Suspension Access Transit Reason"},
        };



        #region Get Server(machine) name currently selected by user to monitor EnvetLog data
        public void SetCurrentServer()
        {
            Logs.CurrentEnvironment = HomeController.CurrentEnvironment;
        }
        #endregion

        #region Get total memory used so far
        public void SetCurrentProcessMemorySize()
        {
            Process MyProcess = Process.GetCurrentProcess();
            //return (long) ((double) MyProcess.PrivateMemorySize64 / 1000000.0);
            Logs.MemorySize = (long)((double)MyProcess.PeakPagedMemorySize64 / 1000000.0);
        }
        #endregion

        #region Create new list with date time range between last updated date time and now

        public void OnRefresh()
        {
            Logs.RefreshCachedNcsInfo();

            var list1 = (IList<GeneralEventLog>)DataCache.GetCachedObject(Constants.Key_GeneralEventLog);
            IList<GeneralEventLog> list2 = new List<GeneralEventLog>();
            if (list1 != null && list1.Count > 0)
            {
                list2 = Logs.RetriveGeneralEventLog(Logs.LastRefreshed, null, true);
                var newList = new List<GeneralEventLog>(list1.Count + list2.Count);

                // Merge two list1 and list2 to newList
                newList.AddRange(list1);
                newList.AddRange(list2);
                newList = newList.OrderByDescending(x => x.ProcessDatetime).ToList();
                Logs.GeneralLog = newList;
            }
            else
            {
                // Should not be reaching to this point
                list2 = Logs.RetriveGeneralEventLog(Logs.LastRefreshed);              
                Logs.GeneralLog = list2;
            }
            // Cache the newList
            DataCache.SetCachedObjectPermanent(Constants.Key_GeneralEventLog, Logs.GeneralLog);
            Session["EndDate"] = Logs.LastRefreshed = Logs.EndDate = DateTime.Now;
        }

        #endregion

        #region OnNewStartDate - Create new list which including existing list plus the list covering period between new startDate and current startDate

        public void OnNewStartDate(DateTime startDate)
        {
            Logging.Info("OnNewStartDate: system start date=" + Logs.StartDate + ", requesting start date=" + startDate);
            if (startDate >= Logs.StartDate)
            {
                return;
            }

            Logging.Info("OnNewStartDate: Load more data from DB because requesting start date, " + startDate + " is earlier.");

            var list1 = (IList<GeneralEventLog>)DataCache.GetCachedObject(Constants.Key_GeneralEventLog);
            var list2 = Logs.RetriveGeneralEventLog(startDate, Logs.StartDate);
            if (list1 != null && list1.Count > 0 && list2 != null && list2.Count > 0)
            {
                var newList = new List<GeneralEventLog>(list1.Count + list2.Count);
                newList.AddRange(list2); // list2 is the first part of newList
                newList.AddRange(list1); // append list1 to the newList
                newList = newList.OrderByDescending(x => x.ProcessDatetime).ToList();
                Logs.GeneralLog = newList;                
            }
            else if (list1 == null)
            {
                Logs.GeneralLog = list2;
            }
            else if (list2 == null || list2.Count == 0)
            {
                Logs.GeneralLog = list1;
            }
            // Cache the newList
            DataCache.SetCachedObjectPermanent(Constants.Key_GeneralEventLog, Logs.GeneralLog);
            Session["StartDate"] = Logs.StartDate = startDate;
        }

        #endregion

 


        #region RenderRazorViewToString to render a Razor view into a string.

        public static String RenderRazorViewToString(ControllerContext controllerContext, String viewName, Object model)
        {
            controllerContext.Controller.ViewData.Model = model;

            using (var sw = new StringWriter())
            {
                var ViewResult = ViewEngines.Engines.FindPartialView(controllerContext, viewName);
                var ViewContext = new ViewContext(controllerContext, ViewResult.View, controllerContext.Controller.ViewData, controllerContext.Controller.TempData, sw);
                ViewResult.View.Render(ViewContext, sw);
                ViewResult.ViewEngine.ReleaseView(controllerContext, ViewResult.View);
                return sw.GetStringBuilder().ToString();
            }
        }
        #endregion

        #region RetrieveDataOnDateRange

        public void RetrieveDataOnDateRange(DateTime? startDate, DateTime? endDate, ref  DateTime start)
        {
            if (startDate.HasValue && startDate < Logs.StartDate)
            {
                start = (DateTime)startDate;
                OnNewStartDate(start);
                Session["StartDate"] = Logs.StartDate = start;

            }
        }

        #endregion

        #region GetElapsedTime() for Files

        public TimeSpan GetElapsedTime(IList<File_Info> files)
        {
            // Because ProcessTime is sorted by DESC by default, the first is most recent time stamp
            DateTime first = DateTime.MinValue;
            DateTime last = DateTime.MinValue;
            foreach (var evt in files)
            {
                if (first == DateTime.MinValue)
                {
                    first = evt.ProcessTime;
                }
                last = evt.ProcessTime;
            }
            TimeSpan ts = TimeSpan.MinValue;
            if (first >= last)
            {
                ts = first - last;
            }
            else
            {
                ts = last - first;
            }
            return ts.Duration();
        }

        public TimeSpan GetElapsedTime(IList<Event_ID> events)
        {
            // Because ProcessTime is sorted by DESC by default, the first is most recent time stamp
            DateTime first = DateTime.MinValue;
            DateTime last = DateTime.MinValue;
            foreach (var evt in events)
            {
                if (first == DateTime.MinValue)
                {
                    first = evt.ProcessTime;
                }
                last = evt.ProcessTime;
            }
            TimeSpan ts = TimeSpan.MinValue;
            if (first >= last)
            {
                ts = first - last;
            }
            else
            {
                ts = last - first;
            }
            return ts.Duration();
        }

        #endregion

        #region Set StartDate and EndDate

        protected void SetDateRange(DateTime? startDate, DateTime?endDate)
        {
            if (startDate.HasValue && startDate < (DateTime)Session["StartDate"])
            {
                Session["StartDate"] = StartDate = (DateTime)startDate;
                if (Logs.EndDate < (DateTime) endDate)
                {
                    Logs.EndDate = (DateTime)endDate;
                }
                OnNewStartDate(StartDate);
            }
            else if (startDate.HasValue)
            {
                Session["StartDate"] = StartDate = (DateTime)startDate;
            }
            else
            {
                StartDate = (DateTime)Session["StartDate"];
            }

            if (endDate.HasValue)
            {
                if (endDate > DateTime.Now)
                {
                    endDate = DateTime.Now;
                } 
                if (endDate > EndDate && EndDate != DateTime.MinValue)
                {
                    OnRefresh();
                }
                Session["EndDate"] = EndDate = (DateTime)endDate;
            }
            else if (Session["EndDate"] == null)
            {
                Session["EndDate"] = EndDate = DateTime.Now;
            }
            else
            {
                EndDate = (DateTime)Session["EndDate"];
            }
        }

        #endregion

        #region Initialize Logs settings

        protected void InitializeLogs()
        {
            if (Logs.GeneralLog == null || Logs.GeneralLog.Count() == 0)
            {
                Logs.GeneralLog = Logs.CreateGeneralEventLog();
            }
            if (Session["StartDate"] != null)
            {
                StartDate = (DateTime)Session["StartDate"];
                EndDate = (DateTime)Session["EndDate"];
            }
            else
            {
                Session["StartDate"] = DateTime.Today.AddDays(Convert.ToInt16(WebConfigurationManager.AppSettings["Days"]));
                Session["EndDate"] = DateTime.Now;
                StartDate = (DateTime)Session["StartDate"];
                EndDate = (DateTime)Session["EndDate"];
            }
        }
        #endregion

        #region Update date range
        protected void UpdateDateRange(DateTime? startDate, DateTime? endDate)
        {
            StartDate = (DateTime)Session["StartDate"];
            EndDate = (DateTime)Session["EndDate"];

            if (startDate.HasValue && startDate < (DateTime)Session["StartDate"])
            {
                Session["StartDate"] = StartDate = (DateTime)startDate;
                OnNewStartDate(StartDate);
            }
            else if (startDate.HasValue)
            {
                Session["StartDate"] = StartDate = (DateTime)startDate;
            }

            if (endDate.HasValue)
            {
                if (endDate > DateTime.Now)
                {
                    endDate = DateTime.Now;
                } 
                Session["EndDate"] = EndDate = (DateTime)endDate;
            }
        }
        #endregion

        #region Common code for XML Data details

        protected IList<GeneralEventLog> XmlDataCommon(long ID)
        {
            // Get current Server from which EventLog is being monitored and display
            SetCurrentServer();

            // Get total memory used so far and set and display
            SetCurrentProcessMemorySize();

            if (Logs.GeneralLog == null || Logs.GeneralLog.Count() == 0)
            {
                Logs.GeneralLog = Logs.CreateGeneralEventLog();
            }

            var entry = Logs.GeneralLog.Where(x => x.ID == ID);

            var list = entry.ToList();

            if (list.Any())
            {
                var l = list[0];
                if (!string.IsNullOrEmpty(l.ProcessErrorID))
                {
                    var err = Logs.RetrieveEventProcessError(l.ID);
                    if (err != null)
                    {
                        l.ProcessErrorDescr = err.ProcessErrorDescr;
                        l.StackTrace = err.StackTrace;
                    }
                }
            }
            return list;
        }

        #endregion
    }
}