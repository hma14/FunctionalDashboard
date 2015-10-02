﻿using System.Data.Linq.Mapping;
using FunctionalDashboard.Dal.DataEntity;

namespace FunctionalDashboard.Models
{
    public class FufEventLog : EventLogBaseEntity
    {
        [Column(DbType = "nvarchar(50)")]
        public string ProgramID { get; set; }

        [Column(DbType = "nvarchar(50)")]
        public string InstitutionID { get; set; }

        [Column(DbType = "nvarchar(5)")]
        public string FileStatus { get; set; }

        [Column(DbType = "Uniquidentifier")]
        public string RequestTxID { get; set; }

        [Column(DbType = "Uniquidentifier")]
        public string UniqueParticipantId { get; set; }

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

        //[Column(DbType = "xml")]
        //public string XMLData { get; set; }

        //[Column(DbType = "int")]
        //public int CurrentClicked { get; set; }
    }
}