using System;
using System.Data.Linq.Mapping;

namespace FunctionalDashboard.Models
{
    public class CPGFD_ErrorList
    {
        [Column(DbType = "varchar(10)")]
        public string ProgramID { get; set; }

        [Column(DbType = "varchar(10)")]
        public string InstitutionID { get; set; }

        [Column(DbType = "int")]
        public int EventID { get; set; }

        [Column(DbType = "int")]
        public int CategoryID { get; set; }

        [Column(DbType = "bigint")]
        public long ProcessDatetime { get; set; }

        [Column(DbType = "tinyint")]
        public int Status { get; set; }

        [Column(DbType = "nvarchar(50)")]
        public string UpdatedBy { get; set; }

        [Column(DbType = "Datetime")]
        public DateTime UpdatedDatetime { get; set; }

    }
}