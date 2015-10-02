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
using System.Security.Principal;
using FunctionalDashboard.Dal;
using FunctionalDashboard.Dal.DataEntity;

namespace SLTRulesProcess
{
    public partial class SLTRulesProcess : ServiceBase
    {
        private System.Diagnostics.EventLog eventLog;
        private string User = String.Empty;

        public SLTRulesProcess()
        {
            InitializeComponent();
            User = ConfigurationManager.AppSettings["User"];
            eventLog = new System.Diagnostics.EventLog();
            if (!System.Diagnostics.EventLog.SourceExists(SLTConstants.RulesLogSource))
            {
                System.Diagnostics.EventLog.CreateEventSource(SLTConstants.RulesLogSource, SLTConstants.LogName);
            }
            eventLog.Source = SLTConstants.RulesLogSource;
            eventLog.Log = SLTConstants.LogName;
        }

        protected override void OnStart(string[] args)
        {
            eventLog.WriteEntry("In OnStart");

            // Set up a timer to trigger every minute.
            System.Timers.Timer timer = new System.Timers.Timer();
            timer.Interval = Double.Parse(ConfigurationManager.AppSettings["TimerInterval"]);
            timer.Elapsed += new System.Timers.ElapsedEventHandler(this.OnTimer);
            timer.Start();
        }

        public void OnTimer(object sender, System.Timers.ElapsedEventArgs args)
        {
            ProcessRules();
        }



        protected override void OnStop()
        {
            eventLog.WriteEntry("In OnStop");
        }

        private DateTime CalNextTriggerDatetime(RULE_TYPE ruleType, int dayOfWeek, int ruleDay, DateTime d1, DateTime d2)
        {
            eventLog.WriteEntry("CalNextTriggerDatetime()", EventLogEntryType.Information, SLTConstants.EventID);

            int days = 0, hours = 0, minutes = 0, seconds = 0;

            DateTime retDateTime = DateTime.MinValue;
            switch (ruleType)
            {
                case RULE_TYPE.Daily:
                    hours = d1.Hour - d2.Hour;
                    minutes = d1.Minute - d2.Minute;
                    seconds = d1.Second - d2.Second;

                    if ((hours < 0) || (hours == 0) && (minutes < 0) || (hours == 0) && (minutes == 0) && (seconds < 0))
                    {
                        retDateTime = d2.AddDays(1);
                        retDateTime = retDateTime.AddHours(hours);
                    }
                    else
                    {
                        retDateTime = d2.AddHours(hours);
                    }
                   
                    retDateTime = retDateTime.AddMinutes(minutes);
                    retDateTime = retDateTime.AddSeconds(seconds);
                    retDateTime = retDateTime.AddMilliseconds(-d2.Millisecond);
                    
                    break;
                case RULE_TYPE.Weekly:
                    int currentDayOfWeek = (int)d2.DayOfWeek;
                    if (currentDayOfWeek == 0) // 0 is Sunday in DateTime.DayOfWeek
                    {
                        currentDayOfWeek = 7;  // 7 is Sunday in our world
                    }
                    days = dayOfWeek - currentDayOfWeek;
                    hours = d1.Hour - d2.Hour;
                    minutes = d1.Minute - d2.Minute;
                    seconds = d1.Second - d2.Second;
                    if (days < 0 || (days == 0) && (hours < 0) || (days == 0) && (hours == 0) && (minutes < 0) || 
                        (days == 0) && (hours == 0) && (minutes == 0) && (seconds < 0))
                    {
                        retDateTime = d2.AddDays(7 + days);
                    }
                    else
                    {
                        retDateTime = d2.AddDays(days);
                    }
                    
                    retDateTime = retDateTime.AddHours(hours);
                    retDateTime = retDateTime.AddMinutes(minutes);
                    retDateTime = retDateTime.AddSeconds(seconds);
                    retDateTime = retDateTime.AddMilliseconds(-d2.Millisecond);

                    break;
                case RULE_TYPE.Monthly:
                    days = ruleDay - d2.Day;
                    hours = d1.Hour - d2.Hour;
                    minutes = d1.Minute - d2.Minute;
                    seconds = d1.Second - d2.Second;
                    if (days < 0 || (days == 0) && (hours < 0) || (days == 0) && (hours == 0) && (minutes < 0) ||
                        (days == 0) && (hours == 0) && (minutes == 0) && (seconds < 0))
                    {
                        retDateTime = d2.AddMonths(1);
                        retDateTime = retDateTime.AddDays(days);
                    }
                    else
                    {
                        retDateTime = d2.AddDays(days);
                    }

                    retDateTime = retDateTime.AddHours(hours);
                    retDateTime = retDateTime.AddMinutes(minutes);
                    retDateTime = retDateTime.AddSeconds(seconds);
                    retDateTime = retDateTime.AddMilliseconds(-d2.Millisecond);


                    break;
                default:
                    break;
            }

            return retDateTime;
        }

        private void ProcessRules()
        {
            eventLog.WriteEntry("ProcessRules()", EventLogEntryType.Information, SLTConstants.EventID);

            DateTime currentDateTime = DateTime.Now;
            DataAccess dataAccess = null;
            List<SLTRules> entries = new List<SLTRules>();

            try
            {
                dataAccess = new DataAccess();
                DataTable dt = dataAccess.SpRetrieveCPGFD_SLTRules();
                entries = (from x in dt.AsEnumerable()
                           select new SLTRules()
                           {
                               ID = int.Parse(x["ID"].ToString()),
                               EventID = int.Parse(x["EventID"].ToString()),
                               CategoryID = int.Parse(x["CategoryID"].ToString()),
                               ProgramID = x["ProgramID"].ToString(),
                               InstitutionID = x["InstitutionID"].ToString(),
                               RuleDescription = x["RuleDescription"].ToString(),
                               RuleType = (RULE_TYPE)int.Parse(x["RuleType"].ToString()),
                               DayOfWeek = (DAY_OF_WEEK)int.Parse(x["DayOfWeek"].ToString()),
                               RuleDay = int.Parse(x["RuleDay"].ToString()),
                               RuleTime = DateTime.Parse(x["RuleTime"].ToString()),
                               WarningThreshold = int.Parse(x["WarningThreshold"].ToString()),
                               Status = (SLTSTATUS)int.Parse(x["Status"].ToString()),
                               NextTriggerDatetime = x["NextTriggerDatetime"] != DBNull.Value ? (DateTime) DateTime.Parse(x["NextTriggerDatetime"].ToString()) : (DateTime?)null,
                               UpdatedDatetime = DateTime.Parse(x["UpdatedDatetime"].ToString()),
                               UpdatedUser = x["UpdatedUser"].ToString(),
                           }).ToList();
            }
            catch (Exception ex)
            {
                eventLog.WriteEntry(String.Format("Polling database failed: {0}", ex.Message), EventLogEntryType.Error, SLTConstants.EventID);
            }
            finally
            {
                dataAccess.CloseConnection();
            }

            if (entries != null && entries.Count > 0)
            {
                // Check each entry 
                foreach (var e in entries)
                {
                    
                    DateTime nextTriggerDatetime = DateTime.MinValue;
                    DateTime warningDateTime = DateTime.MinValue;

                    // Check if NextTriggerDatetime is set or not
                    if (e.NextTriggerDatetime == null)
                    {
                        // NextTriggerDatetime is not defined, and set one
                        nextTriggerDatetime = CalNextTriggerDatetime((RULE_TYPE)e.RuleType, (int) e.DayOfWeek, e.RuleDay, e.RuleTime, currentDateTime);

                        try
                        {
                            // Actually update NextTriggerDatetime in table CPGFD_SLTRules
                            dataAccess.SpUpdateCPGFD_SLTRules_By_NextTriggerDatetime(e.EventID, e.CategoryID, e.ProgramID, e.InstitutionID, nextTriggerDatetime, User);
                        }
                        catch (Exception ex)
                        {
                            eventLog.WriteEntry(String.Format("Calling SpUpdateCPGFD_SLTRules_By_NextTriggerDatetime() failed: {0}", ex.Message), EventLogEntryType.Error, SLTConstants.EventID);
                        }
                        finally
                        {
                            dataAccess.CloseConnection();
                        }


                        // Calculate previous nextTriggerDatetime - only on initial time for this entry
                        switch (e.RuleType)
                        {
                            case RULE_TYPE.Daily:
                                e.NextTriggerDatetime = nextTriggerDatetime.AddDays(-1);
                                break;
                            case RULE_TYPE.Weekly:
                                e.NextTriggerDatetime = nextTriggerDatetime.AddDays(-7);
                                break;
                            case RULE_TYPE.Monthly:
                                e.NextTriggerDatetime = nextTriggerDatetime.AddMonths(-1);
                                break;
                            default:
                                break;
                        }
                    }
                    else
                    {
                        if (currentDateTime > e.NextTriggerDatetime)
                        {
                            nextTriggerDatetime = CalNextTriggerDatetime((RULE_TYPE)e.RuleType,(int) e.DayOfWeek, e.RuleDay, e.RuleTime, currentDateTime);

                            try
                            {
                                // Actually update NextTriggerDatetime in table CPGFD_SLTRules
                                dataAccess.SpUpdateCPGFD_SLTRules_By_NextTriggerDatetime(e.EventID, e.CategoryID, e.ProgramID, e.InstitutionID, nextTriggerDatetime, User);
                            }
                            catch (Exception ex)
                            {
                                eventLog.WriteEntry(String.Format("Calling SpUpdateCPGFD_SLTRules_By_NextTriggerDatetime() failed: {0}", ex.Message), EventLogEntryType.Error, SLTConstants.EventID);
                            }
                        }
                        else
                        {
                            continue;
                        }
                    }

                    warningDateTime = nextTriggerDatetime.AddHours(-e.WarningThreshold);
                    try
                    {
                        // No Active SLT tracking entry exists, create one
                        dataAccess.SpInsertCPGFD_SLTTracking(e.EventID, e.CategoryID, e.ProgramID, e.InstitutionID, e.ID, e.RuleDescription,
                                                             (DateTime)e.NextTriggerDatetime, warningDateTime, nextTriggerDatetime,
                                                             null, (int)TRACKING_STATUS.Active, User);
                    }
                    catch (Exception ex)
                    {
                        eventLog.WriteEntry(String.Format("Calling SpInsertCPGFD_SLTTracking() failed: {0}", ex.Message), EventLogEntryType.Error, SLTConstants.EventID);
                    }
                    finally
                    {
                        dataAccess.CloseConnection();
                    }

                } // foreach
            }
        }
    }
}
