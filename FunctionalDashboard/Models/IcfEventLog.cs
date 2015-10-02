using System.Data.Linq.Mapping;
using FunctionalDashboard.Dal.DataEntity;

namespace FunctionalDashboard.Models
{
    public class IcfEventLog : EventLogBaseEntity
    {
        [Column(DbType = "nvarchar(150)")]
        public string UploadFileName { get; set; }

        [Column(DbType = "nvarchar(50)")]
        public string ProgramID { get; set; }

        [Column(DbType = "nvarchar(100)")]
        public string Institution { get; set; 
        }
        [Column(DbType = "nvarchar(50)")]
        public string InstitutionID { get; set; }

        [Column(DbType = "nvarchar(5)")]
        public string FileStatus { get; set; }

        [Column(DbType = "Uniquidentifier")]
        public string RequestTxID { get; set; }

        [Column(DbType = "Uniquidentifier")]
        public string UniqueParticipantId { get; set; }

        [Column(DbType = "nvarchar(50)")]
        public string CardSerialNumber { get; set; }

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
        public string URI { get; set; }

        [Column(DbType = "nvarchar(50)")]
        public string URIType { get; set; }

        //[Column(DbType = "Datetime")]
        //public DateTime ProcessDatetime { get; set; }

        [Column(DbType = "nvarchar(50)")]
        public string ProcessErrorID { get; set; }

        [Column(DbType = "nvarchar(4000)")]
        public string ProcessErrorDescr { get; set; }

        //[Column(DbType = "int")]
        //public int CurrentClicked { get; set; }
    }
}