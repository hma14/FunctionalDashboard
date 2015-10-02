using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FunctionalDashboard.Dal.DataEntity
{
    public class TL_EventLog
    {

        public long ID { get; set; }
        public long SourceLogID { get; set; }
        public string LogName { get; set; }
        public string Level { get; set; }
        public string Source { get; set; }
        public string Category { get; set; }
        public int EventID { get; set; }
        public DateTime  LoggedTime { get; set; }
        public string Computer { get; set; }
        public string ProgramID { get; set; }
        public string InstitutionID { get; set; }
        public string UploadFileName { get; set; }
        public string FileStatus { get; set; }
        public string RequestTxID { get; set; }
        public string GUID { get; set; }
        public int? TaskID { get; set; }
        public int? StateID { get; set; }
        public string UniqueParticipantId { get; set; }
        public string CardSerialNumber { get; set; }
        public string ExistingCardSN { get; set; }
        public string Action { get; set; }
        public string ReasonCode { get; set; }
        public string Benefit { get; set; }
        public string CardTypeCode { get; set; }
        public string SuccessFailureCode { get; set; }
        public string SuccessFailureDescr { get; set; }
        public string ActionExecuted { get; set; }
        public string TSID { get; set; }
        public string Elig { get; set; }
        public string EligDate { get; set; }
        public string Rval { get; set; }
        public string Rext { get; set; }
        public int BenefitID { get; set; }
        public long BenefitProductID { get; set; }
        public int BenefitMonth { get; set; }
        public int BenefitYear { get; set; }
        public string URI { get; set; }
        public string URIType { get; set; }
        public DateTime ProcessDatetime { get; set; }
        public string ProcessErrorID { get; set; }


    }
}
