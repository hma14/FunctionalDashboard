using System.Data.Linq.Mapping;

namespace FunctionalDashboard.Dal.DataEntity
{
    public class NcsInfo
    {
        [Column(DbType = "varchar(10)")]
        public string InstitutionId { get; set; }
        [Column(DbType = "int")]
        public int OrganizationId { get; set; }
        [Column(DbType = "varchar(10)")]
        public string ProgramId { get; set; }
        [Column(DbType = "bit")]
        public bool Active { get; set; }
        [Column(DbType = "varchar(100)")]
        public string  Name { get; set; }

        [Column(DbType = "varchar(24)")]
        public string ShortName { get; set; }

    } 
}