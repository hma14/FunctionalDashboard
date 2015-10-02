using System;
using System.Data.Linq.Mapping;

namespace FunctionalDashboard.Dal.DataEntity
{
    public class EventSentryStatus
    {
        [Column(DbType = "nvarchar(50)")]
        public string Server { get; set; }

        [Column(DbType = "Datetime")]
        public DateTime LastUpdateTime { get; set; }

    }

    [Table]
    [InheritanceMapping(Type = typeof(GeneralEventLog), IsDefault = true, Code = 0)]
    public abstract class EventLogBaseEntity
    {
        [Column(DbType = "bigint", IsDiscriminator = true)]
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

        [Column(DbType = "int")]
        public int Month { get; set; }

        [Column(DbType = "int")]
        public int Year { get; set; }

        [Column(DbType = "int")]
        public int Day { get; set; }

        [Column(DbType = "int")]
        public int CurrentClicked { get; set; }

    }

    public class EventLog : EventLogBaseEntity
    {

        [Column(DbType = "xml")]
        public string XMLData { get; set; }

    }
}