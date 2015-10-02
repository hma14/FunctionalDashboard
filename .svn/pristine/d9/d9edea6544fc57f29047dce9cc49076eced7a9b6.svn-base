using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FunctionalDashboard.Dal.DataEntity
{
    public class SLTConstants
    {
        public static int EventID = 20000;
        public static string LogName = "CpgLog";
        public static string RulesLogSource = "SLTRulesProcessor";
        public static string TrackingLogSource = "SLTTrackingProcessor";

    }

    public enum RULE_TYPE
    {
        Daily = 1,
        Weekly,
        Monthly
    }

    public enum DAY_OF_WEEK
    {
        NotApplicable,
        Monday,
        Tuesday,
        Wednesday,
        Thursday,
        Friday,
        Saturday,
        Sunday
    }

    public enum SLTSTATUS
    {
        InactiveRule,
        ActiveRule
    }

    public enum TRACKING_STATUS
    {
        Completed,
        Active,
        Warning,
        Breach,
        Cleared
    }

    public class SLTRules
    {
        public int ID { get; set; }
        public int EventID { get; set; }
        public int CategoryID { get; set; }
        public string ProgramID { get; set; }
        public string InstitutionID { get; set; }
        public string RuleDescription { get; set; }
        public RULE_TYPE RuleType { get; set; }
        public DAY_OF_WEEK DayOfWeek { get; set; }
        public int RuleDay { get; set; }
        public DateTime RuleTime { get; set; }
        public int WarningThreshold { get; set; }
        public SLTSTATUS Status { get; set; }
        public DateTime? NextTriggerDatetime { get; set; }
        public DateTime UpdatedDatetime { get; set; }
        public string UpdatedUser { get; set; }
    }


    public class SLTTracking
    {
        public long ID { get; set; }
        public int SLTRuleID { get; set; }
        public string ProgramID { get; set; }
        public string InstitutionID { get; set; }
        public string Institution { get; set; }
        public string Category { get; set; }
        public int CategoryID { get; set; }
        public string Event { get; set; }
        public int EventID { get; set; }
        public string RuleDescription { get; set; }
        public DateTime SLTStartDatetime { get; set; }
        public DateTime SLTWarningDatetime { get; set; }
        public DateTime SLTBreachDatetime { get; set; }
        public DateTime? SLTCompleteDatetime { get; set; }
        public TRACKING_STATUS Status { get; set; }

    }

   
}
