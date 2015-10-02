using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SLTTrackingProcess.Models
{
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
 

    public class SLTTracking
    {
        public long ID { get; set; }
        public int SLTRuleID { get; set; }
        public int EventID { get; set; }
        public int CategoryID { get; set; }
        public string ProgramID { get; set; }
        public string InstitutionID { get; set; }
        public string RuleDescription { get; set; }
        public DateTime SLTStartDatetime { get; set; }
        public DateTime SLTWarningDatetime { get; set; }
        public DateTime SLTBreachDatetime { get; set; }
        public DateTime? SLTCompleteDatetime { get; set; }
        public TRACKING_STATUS Status { get; set; }
               
    } 
}
