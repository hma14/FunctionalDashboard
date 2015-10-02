using System;
using System.Collections.Generic;
using System.Data.Linq.Mapping;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FunctionalDashboard.Dal.DataEntity
{
    public class EventLogDetail
    {
        [Column(DbType = "bigint")]
        public long Id { get; set; }

        [Column(DbType = "varchar(4000)")]
        public string ProcessErrorDescr { get; set; }

        [Column(DbType = "varchar(4000)")]
        public string StackTrace { get; set; }
    }
}
