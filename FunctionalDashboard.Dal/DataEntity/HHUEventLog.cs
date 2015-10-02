using System;
using System.Data.Linq.Mapping;

namespace FunctionalDashboard.Dal.DataEntity
{
    public class HHUEventLog
    {
        [Column(DbType = "bigint")]
        public long ID { get; set; }

        [Column(DbType = "bigint")]
        public long SourceLogID { get; set; }

        [Column(DbType = "nvarchar(50)")]
        public string Source { get; set; }

        [Column(DbType = "nvarchar(50)")]
        public string LogName { get; set; }

        [Column(DbType = "nvarchar(50)")]
        public string ProgramID { get; set; }

        [Column(DbType = "nvarchar(50)")]
        public string InstitutionID { get; set; }

        [Column(DbType = "nvarchar(50)")]
        public string Event { get; set; }

        [Column(DbType = "int")]
        public int EventID { get; set; }

        [Column(DbType = "int")]
        public int CategoryID { get; set; }

        [Column(DbType = "nvarchar(50)")]
        public string Category { get; set; }

        [Column(DbType = "nvarchar(50)")]
        public string Level { get; set; }

        [Column(DbType = "nvarchar(50)")]
        public string Computer { get; set; }

        [Column(DbType = "nvarchar(50)")]
        public string Environment { get; set; }

        [Column(DbType = "datetime")]
        public DateTime LoggedTime { get; set; }

        [Column(DbType = "datetime")]
        public DateTime ProcessDatetime { get; set; }

        [Column(DbType = "varchar(20)")]
        public string TaskID { get; set; }

        [Column(DbType = "varchar(20)")]
        public string StateID { get; set; }

        [Column(DbType = "varchar(50)")]
        public string Location { get; set; }

        [Column(DbType = "varchar(20)")]
        public string FareInstrumentID { get; set; }

        [Column(DbType = "varchar(20)")]
        public string HHUReasonCode { get; set; }

        [Column(DbType = "varchar(20)")]
        public string HHUUserID { get; set; }

        [Column(DbType = "varchar(20)")]
        public string CardLinkState { get; set; }

        [Column(DbType = "varchar(20)")]
        public string TSID { get; set; }

        [Column(DbType = "varchar(20)")]
        public string CardState { get; set; }

        [Column(DbType = "varchar(20)")]
        public string CardSerialNumber { get; set; }

        [Column(DbType = "datetime")]
        public DateTime? ConfiscationDatetime { get; set; }

        [Column(DbType = "nvarchar(1000)")]
        public string URI { get; set; }

        [Column(DbType = "nvarchar(50)")]
        public string URIType { get; set; }

        [Column(DbType = "nvarchar(50)")]
        public string ProcessErrorID { get; set; }

        [Column(DbType = "varchar(4000)")]
        public string ProcessErrorDescr { get; set; }

        [Column(DbType = "varchar(4000)")]
        public string StackTrace { get; set; }

    }
}