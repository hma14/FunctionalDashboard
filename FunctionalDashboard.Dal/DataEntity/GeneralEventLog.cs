using System;
using System.Data.Linq.Mapping;

namespace FunctionalDashboard.Dal.DataEntity
{
    public class GeneralEventLog : EventLogBaseEntity
    {
        [Column(DbType = "nvarchar(150)")]
        public string UploadFileName { get; set; }

        [Column(DbType = "nvarchar(50)")]
        public string ProgramID { get; set; }

        [Column(DbType = "nvarchar(50)")]
        public string InstitutionID { get; set; }

        [Column(DbType = "nvarchar(5)")]
        public string FileStatus { get; set; }

        [Column(DbType = "varchar(40)")]
        public string RequestTxID { get; set; }

        [Column(DbType = "varchar(36)")]
        public string GUID { get; set; }

        [Column(DbType = "Int")]
        public int ? TaskID { get; set; }

        [Column(DbType = "int")]
        public int? StateID { get; set; }     

        [Column(DbType = "varchar(60)")]
        public string UniqueParticipantId { get; set; }

        [Column(DbType = "nvarchar(50)")]
        public string CardSerialNumber { get; set; }

        [Column(DbType = "nvarchar(50)")]
        public string ExistingCardSN { get; set; }

        [Column(DbType = "nvarchar(5)")]
        public string Action { get; set; }

        [Column(DbType = "nvarchar(5)")]
        public string ReasonCode { get; set; }

        [Column(DbType = "nvarchar(50)")]
        public string Benefit { get; set; }

        [Column(DbType = "nvarchar(50)")]
        public string CardTypeCode { get; set; }

        [Column(DbType = "nvarchar(5)")]
        public string SuccessFailureCode { get; set; }

        [Column(DbType = "nvarchar(4000)")]
        public string SuccessFailureDescr { get; set; }

        [Column(DbType = "nvarchar(50)")]
        public string ActionExecuted { get; set; }

        [Column(DbType = "nvarchar(50)")]
        public string TSID { get; set; }

        [Column(DbType = "nvarchar(50)")]
        public string Elig { get; set; }

        [Column(DbType = "nvarchar(50)")]
        public string EligDate { get; set; }

        [Column(DbType = "nvarchar(50)")]
        public string Rval { get; set; }

        [Column(DbType = "nvarchar(50)")]
        public string Rext { get; set; }

        [Column(DbType = "int")]
        public int BenefitID { get; set; }

        [Column(DbType = "bigint")]
        public long BenefitProductID { get; set; }

        [Column(DbType = "int")]
        public int BenefitMonth { get; set; }

        [Column(DbType = "int")]
        public int BenefitYear { get; set; }

        [Column(DbType = "nvarchar(1000)")]
        public string URI { get; set; }

        [Column(DbType = "nvarchar(50)")]
        public string FileName { get; set; }

        [Column(DbType = "nvarchar(50)")]
        public string URIType { get; set; }

        [Column(DbType = "nvarchar(50)")]
        public string ProcessErrorID { get; set; }

        [Column(DbType = "nvarchar(4000)")]
        public string ProcessErrorDescr { get; set; }

        [Column(DbType = "nvarchar(4000)")]
        public string StackTrace { get; set; }

        [Column(DbType = "nvarchar(50)")]
        public string Location { get; set; }

        [Column(DbType = "int")]
        public int? FareInstrumentID { get; set; }

        [Column(DbType = "int")]
        public int? HHUReasonCode { get; set; }

        [Column(DbType = "int")]
        public int? HHUUserID { get; set; }

        [Column(DbType = "Datetime")]
        public DateTime ConfiscationDatetime { get; set; }

        [Column(DbType = "tinyint")]
        public int? CardLinkState { get; set; }

        [Column(DbType = "tinyint")]
        public int? CardState { get; set; }
        
    }
}