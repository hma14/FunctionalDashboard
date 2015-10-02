using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Configuration;
using System.Data;
using System.Diagnostics;
using System.Linq;
using System.ServiceProcess;
using System.Text;
using System.Threading;
using System.Threading.Tasks;
using System.Security;
using System.Security.Claims;
using FunctionalDashboard.Dal;
using FunctionalDashboard.Dal.DataEntity;

namespace SLTTrackingProcess
{
    public partial class SLTTrackingProcess : ServiceBase
    {
        private System.Diagnostics.EventLog eventLog;
        private string User = String.Empty;
        private static bool isNotFirstTimeFire = false;
        private double TimerInterval;

        public SLTTrackingProcess()
        {
            InitializeComponent();
            User = ConfigurationManager.AppSettings["User"];
            eventLog = new System.Diagnostics.EventLog();
            if (!System.Diagnostics.EventLog.SourceExists(SLTConstants.TrackingLogSource))
            {
                System.Diagnostics.EventLog.CreateEventSource(SLTConstants.TrackingLogSource, SLTConstants.LogName);
            }
            eventLog.Source = SLTConstants.TrackingLogSource;
            eventLog.Log = SLTConstants.LogName;
        }

        protected override void OnStart(string[] args)
        {
            eventLog.WriteEntry("In OnStart");

            TimerInterval = Double.Parse(ConfigurationManager.AppSettings["TimerInterval"]);

            // Set up a timer to trigger every minute.
            System.Timers.Timer timer = new System.Timers.Timer();
            timer.Interval = TimerInterval;
            timer.Elapsed += new System.Timers.ElapsedEventHandler(this.OnTimer);
            timer.Start();
        }

        protected override void OnStop()
        {
            eventLog.WriteEntry("In OnStop");
        }

        public void OnTimer(object sender, System.Timers.ElapsedEventArgs args)
        {
            ProcessTracking();
            isNotFirstTimeFire = true;
        }

        private void ProcessTracking()
        {

            DateTime currentDateTime = DateTime.Now;
#if DEBUG
            eventLog.WriteEntry(String.Format("ProcessTracking(), Current Date time: {0}", currentDateTime), 
                                EventLogEntryType.Information, SLTConstants.EventID);
#endif
            DataAccess dataAccess = null;
            List<SLTTracking> entries = new List<SLTTracking>();
            try
            {
                dataAccess = new DataAccess();
                DataTable dt = dataAccess.SpRetrieveAllCPGFD_SLTTracking();
                entries = (from x in dt.AsEnumerable()
                           select new SLTTracking()
                           {
                               ID = long.Parse(x["ID"].ToString()),
                               EventID = int.Parse(x["EventID"].ToString()),
                               CategoryID = int.Parse(x["CategoryID"].ToString()),
                               ProgramID = x["ProgramID"].ToString(),
                               InstitutionID = x["InstitutionID"].ToString(),
                               RuleDescription = x["RuleDescription"].ToString(),
                               SLTRuleID = int.Parse(x["SLTRuleID"].ToString()),
                               SLTStartDatetime = DateTime.Parse(x["SLTStartDatetime"].ToString()),
                               SLTWarningDatetime = DateTime.Parse(x["SLTWarningDatetime"].ToString()),
                               SLTBreachDatetime = DateTime.Parse(x["SLTBreachDatetime"].ToString()),
                               SLTCompleteDatetime = x["SLTCompleteDatetime"] != DBNull.Value ? Convert.ToDateTime(x["SLTCompleteDatetime"]) : (DateTime?)null,
                               Status = (TRACKING_STATUS)int.Parse(x["Status"].ToString()),
                           }).ToList();

            }
            catch (Exception ex)
            {
                eventLog.WriteEntry(String.Format("Polling database failed - ProcessTracking: {0}", ex.Message), EventLogEntryType.Error, SLTConstants.EventID);
            }
            finally
            {
                dataAccess.CloseConnection();
            }

            foreach (var e in entries)
            {
                DateTime startTrackingDatetime = e.SLTStartDatetime;
                if (isNotFirstTimeFire)
                {
                    startTrackingDatetime = currentDateTime.AddMilliseconds(-TimerInterval);
                }
                try
                {
                    
                    DataTable dtEventLog = dataAccess.SpRetrieveTrackingEntryFromTL_EventLog(e.EventID, e.CategoryID, e.ProgramID, e.InstitutionID,
                                                                                             startTrackingDatetime, e.SLTBreachDatetime);
                    var eventLogEntry = (from x in dtEventLog.AsEnumerable()
                                         select new TL_EventLog()
                                         {
                                             URIType = x["URIType"] != DBNull.Value ? x["URIType"].ToString() : null,
                                             ProcessDatetime = DateTime.Parse(x["ProcessDatetime"].ToString()),
                                         }).ToList();



                    // Actually check if SLT Rule condition fulfilled?                   
                    if (eventLogEntry.FirstOrDefault() != null && eventLogEntry.Count > 0)
                    {
                        // Fulfilled - update CPGFD_SLTTracking table with ProcessDatetime and status = 0
                        dataAccess.SpUpdateCPGFD_SLTTracking(e.ID, eventLogEntry.First().ProcessDatetime, (int)TRACKING_STATUS.Completed, User);
                        continue;

                    }
                    else // SLT Rule Condition is not fulfilled
                    {
#if DEBUG

                        eventLog.WriteEntry(String.Format("Datetime of Warning: {0}, Breach: {1}, Current: {2} ",
                                                          e.SLTWarningDatetime, e.SLTBreachDatetime, currentDateTime),
                                            EventLogEntryType.Information, SLTConstants.EventID);
#endif

                        // Check if SLT Breach/Warning Datetime  < current Datetime
                        bool isBreach = false;
                        bool isWarning = false;
                        isBreach = e.SLTBreachDatetime.Ticks < currentDateTime.Ticks;
                        if (!isBreach)
                        {
                            isWarning = e.SLTWarningDatetime.Ticks < currentDateTime.Ticks;
                        }

                        if (isBreach)
                        {
                            // Update CPGFD_SLTTracking table by setting Status to 3 (Breach)
                            dataAccess.SpUpdateCPGFD_SLTTracking(e.ID, null, (int)TRACKING_STATUS.Breach, User);
                        }
                        else if (isWarning)
                        {
                            // Update CPGFD_SLTTracking table by setting Status to 2 (Warning)
                            dataAccess.SpUpdateCPGFD_SLTTracking(e.ID, null, (int)TRACKING_STATUS.Warning, User);
                        }
#if DEBUG
                        eventLog.WriteEntry(String.Format("Is Breach : {0}, or is Warning: {1} at Datetime: {2}", isBreach, isWarning, currentDateTime),
                                            EventLogEntryType.Information, SLTConstants.EventID);
#endif
                    }
                }
                catch (Exception ex)
                {
                    eventLog.WriteEntry(String.Format("Calling SpRetrieveTrackingEntryFromTL_EventLog() has thrown exception: {0}", ex.Message), EventLogEntryType.Error, SLTConstants.EventID);
                }
                finally
                {
                    dataAccess.CloseConnection();
                }
            }
        }
    }
}
