using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.Linq;
using System.Data.Linq.Mapping;
using System.Linq;
using System.Reflection;
using System.Text;
using System.Threading.Tasks;
using FunctionalDashboard.Dal.DataEntity;

namespace FunctionalDashboard.Dal
{
    public class EventLogDataAccess : DataContext 
    {
        private static string ConnectionString = ConfigurationManager.ConnectionStrings["DashBoardDB"].ConnectionString;

        public EventLogDataAccess()
            : base(ConnectionString)
        {
            CommandTimeout = 0;
        }

        public EventLogDataAccess(string connectionString)
            : base(connectionString)
        {
            CommandTimeout = 0;
        }

        [Function(Name = "usp_RetrieveTLEventLog")]
        public IEnumerable<GeneralEventLog> RetrieveGeneralEventLog(
            [Parameter(Name = "startDate", DbType = "datetime")] DateTime startDate,
            [Parameter(Name = "endDate", DbType = "datetime")] DateTime endDate)
        {
            var result = this.ExecuteMethodCall(this, (MethodInfo)(MethodBase.GetCurrentMethod()), startDate, endDate);
            return (IEnumerable<GeneralEventLog>)result.ReturnValue;
        }

        [Function(Name = "usp_RetrieveNCSInfo")]
        public IEnumerable<NcsInfo> RetrieveNcsInfo()
        {
            var result = this.ExecuteMethodCall(this, (MethodInfo) (MethodBase.GetCurrentMethod()));
            return (IEnumerable<NcsInfo>)result.ReturnValue;
        }

        [Function(Name = "usp_RetrieveTLEventLogErrorDetail")]
        public IEnumerable<EventLogDetail> RetrieveTLEventLogErrorDetail(
            [Parameter(Name = "logId", DbType = "bigint")]long logId)
        {
            var result = this.ExecuteMethodCall(this, (MethodInfo)(MethodBase.GetCurrentMethod()), logId);
            return (IEnumerable<EventLogDetail>)result.ReturnValue;
        }


        [Function(Name = "usp_RetrieveSyncUtilityDetail")]
        public IEnumerable<SyncUtilityEventLog> RetrieveSyncUtilityDetail(
            [Parameter(Name = "logId", DbType = "bigint")]long logId)
        {
            var result = this.ExecuteMethodCall(this, (MethodInfo)(MethodBase.GetCurrentMethod()), logId);
            return (IEnumerable<SyncUtilityEventLog>)result.ReturnValue;
        }

        [Function(Name = "usp_RetrieveHHUDetail")]
        public IEnumerable<HHUEventLog> RetrieveHHUDetail(
            [Parameter(Name = "logId", DbType = "bigint")]long logId)
        {
            var result = this.ExecuteMethodCall(this, (MethodInfo)(MethodBase.GetCurrentMethod()), logId);
            return (IEnumerable<HHUEventLog>)result.ReturnValue;
        }

        [Function(Name = "usp_RetrieveAllHHUDetails")]
        public IEnumerable<HHUEventLog> RetrieveHHUDetail()
        {
            var result = this.ExecuteMethodCall(this, (MethodInfo)(MethodBase.GetCurrentMethod()));
            return (IEnumerable<HHUEventLog>)result.ReturnValue;
        }

    }
}
