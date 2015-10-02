using System;
using System.Data.Linq.Mapping;

namespace FunctionalDashboard.Dal.DataEntity
{
    public class SyncUtilityEventLog 
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

        [Column(DbType = "varchar(40)")]
        public string SyncId { get; set; }

        [Column(DbType = "int")]
        public int BenefitId { get; set; }

        [Column(DbType = "varchar(50)")]
        public string BenefitName { get; set; }

        [Column(DbType = "varchar(50)")]
        public string BenefitNameOld { get; set; }

        [Column(DbType = "varchar(50)")]
        public string ProductName { get; set; }

        [Column(DbType = "varchar(50)")]
        public string ProductNameOld { get; set; }

        [Column(DbType = "varchar(50)")]
        public string ProcessErrorID { get; set; }

        [Column(DbType = "varchar(4000)")]
        public string ProcessErrorDescr { get; set; }

        [Column(DbType = "varchar(4000)")]
        public string StackTrace { get; set; }
    }
}