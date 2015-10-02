using System;
using System.Data.Linq.Mapping;
using FunctionalDashboard.Dal.DataEntity;

namespace FunctionalDashboard.Models
{
    public class PpassEventLog : EventLogBaseEntity
    {
        [Column(DbType = "nvarchar(50)")]
        public string ProgramID { get; set; }

        [Column(DbType = "nvarchar(50)")]
        public string InstitutionID { get; set; }

        [Column(DbType = "Uniquidentifier")]
        public string UniqueParticipantId { get; set; }

        [Column(DbType = "int")]
        public int TaskID { get; set; }

        [Column(DbType = "int")]
        public int StateID { get; set; }

        [Column(DbType = "nvarchar(50)")]
        public string CardSerialNumber { get; set; }

        [Column(DbType = "nvarchar(50)")]
        public string URI { get; set; }

        [Column(DbType = "nvarchar(50)")]
        public string URIType { get; set; }

        //[Column(DbType = "datetime")]
        //public DateTime ProcessDatetime { get; set; }

        [Column(DbType = "nvarchar(50)")]
        public string ProcessErrorID { get; set; }

        [Column(DbType = "nvarchar(4000)")]
        public string ProcessErrorDescr { get; set; }

        //[Column(DbType = "int")]
        //public int CurrentClicked { get; set; }

    }
}