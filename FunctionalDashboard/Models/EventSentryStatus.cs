using System;
using System.Data.Linq.Mapping;

namespace FunctionalDashboard.Models
{
    public class EventSentryStatus
    {
        [Column(DbType = "nvarchar(50)")]
        public string Server { get; set; }

        [Column(DbType = "Datetime")]
        public DateTime LastUpdateTime { get; set; }

    }
}