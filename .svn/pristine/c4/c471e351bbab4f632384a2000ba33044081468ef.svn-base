using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;


namespace FunctionalDashboard.Dal
{
    public class DataAccess 
    {
        private SqlConnection sqlConnection;
        
        private string connectionString()
        {
            return ConfigurationManager.ConnectionStrings["DashBoardDB"].ConnectionString;
        }


        public DataAccess()
        {
            try
            {
                if (sqlConnection == null)
                {
                    sqlConnection = new SqlConnection(connectionString());
                    if (sqlConnection.State == System.Data.ConnectionState.Closed)
                    {
                        sqlConnection.Open();
                    }
                }
            }
            catch
            {
                throw;
            }
        }

        public SqlConnection OpenConnection()
        {
            try
            {
                if (sqlConnection.State == ConnectionState.Closed)
                {
                    sqlConnection.Open();
                }
            }
            catch
            {
                throw;
            }
            return sqlConnection;
        }

        public void CloseConnection()
        {
            if (sqlConnection.State == ConnectionState.Open)
            {
                sqlConnection.Close();
            }
        }

        #region  For Functional Dashboard

        public SqlDataReader RetrieveGeneralEventLog(DateTime startDate, DateTime endDate)
        {
            try
            {

                using (SqlCommand cmd = new SqlCommand("RetrieveTLEventLog", sqlConnection))
                {
                    cmd.CommandTimeout = 0;
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;

                    // Since startDate is using Local Time, NLog using UTC Time, we need to covert to UTC Time
                    cmd.Parameters.AddWithValue("@startDate", startDate.ToUniversalTime());
                    cmd.Parameters.AddWithValue("@endDate", endDate.ToUniversalTime());

                    if (cmd.Connection.State == ConnectionState.Closed)
                    {
                        cmd.Connection.Open();
                    }
                    return cmd.ExecuteReader();
                }
            }
            catch
            {
                throw;
            }
        }

        public SqlDataReader RetrieveEventLog(string spName, DateTime startDate, DateTime endDate)
        {
            try
            {

                using (SqlCommand cmd = new SqlCommand(spName, sqlConnection))
                {
                    cmd.CommandTimeout = 0;
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;

                    // Since startDate is using Local Time, NLog using UTC Time, we need to covert to UTC Time
                    cmd.Parameters.AddWithValue("@startDate", startDate.ToUniversalTime());
                    cmd.Parameters.AddWithValue("@endDate", endDate.ToUniversalTime());

                    if (cmd.Connection.State == ConnectionState.Closed)
                    {
                        cmd.Connection.Open();
                    }
                    return cmd.ExecuteReader();
                }
            }
            catch
            {
                throw;
            }
        }

 
        public SqlDataReader SpRetrieveNCSInfo()
        {
            try
            {
                using (SqlCommand cmd = new SqlCommand("RetrieveNCSInfo", sqlConnection))
                {
                    cmd.CommandTimeout = 0;
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;

                    if (cmd.Connection.State == ConnectionState.Closed)
                    {
                        cmd.Connection.Open();
                    }
                    return cmd.ExecuteReader();
                }
            }
            catch
            {
                throw;
            }
        }

        public DataTable SpRetrieveEventSentryStatus()
        {
            try
            {
                using (SqlCommand cmd = new SqlCommand("RetrieveEventSentryStatus", sqlConnection))
                {
                    cmd.CommandTimeout = 0;
                    cmd.CommandType = CommandType.StoredProcedure;

                    if (cmd.Connection.State == ConnectionState.Closed)
                    {
                        cmd.Connection.Open();
                    }
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);
                    return dt;
                }
            }
            catch
            {
                throw;
            }
        }

        public DataTable SpRetrieveErrorExceptions()
        {
            try
            {
                using (SqlCommand cmd = new SqlCommand("RetrieveErrorExceptions", sqlConnection))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                   
                    if (cmd.Connection.State == ConnectionState.Closed)
                    {
                        cmd.Connection.Open();
                    }
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);
                    return dt;
                }
            }
            catch
            {
                throw;
            }
        }

        

        public int SpRetrieveErrorStatus(int eventID, int categoryID, DateTime ? dt = null)
        {
            try
            {
                using (SqlCommand cmd = new SqlCommand("RetrieveErrorStatus", sqlConnection))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@eventID", eventID);
                    cmd.Parameters.AddWithValue("@categoryID", categoryID);
                    if (dt.HasValue)
                    {
                        cmd.Parameters.AddWithValue("@processDatetime", (DateTime) dt);
                    }
                    if (cmd.Connection.State == ConnectionState.Closed)
                    {
                        cmd.Connection.Open();
                    }
                    return Convert.ToInt32(cmd.ExecuteScalar());
                }
            }
            catch
            {
                throw;
            }
        }

        public void SpUpdateErrorList(int eventID, int categoryID, 
                                      long datetimeTicks, int status, string user, 
                                      string programID = null, string institutionID = null)
        {
            try
            {
                using (SqlCommand cmd = new SqlCommand("UpdateErrorList", sqlConnection))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@eventID", eventID);
                    cmd.Parameters.AddWithValue("@categoryID", categoryID);
                    cmd.Parameters.AddWithValue("@processDatetime", datetimeTicks);
                    cmd.Parameters.AddWithValue("@status", status);
                    cmd.Parameters.AddWithValue("@updatedby", user);
                    cmd.Parameters.AddWithValue("@programID", programID);
                    cmd.Parameters.AddWithValue("@institutionID", institutionID);

                    if (cmd.Connection.State == ConnectionState.Closed)
                    {
                        cmd.Connection.Open();
                    }
                    cmd.ExecuteNonQuery();
                }
            }
            catch
            {
                throw;
            }
        }

        public DataTable SpRetrieveErrorListRecords()
        {
            try
            {
                using (SqlCommand cmd = new SqlCommand("RetrieveErrorListRecords", sqlConnection))
                {
                    cmd.CommandType = CommandType.StoredProcedure;                    
                    if (cmd.Connection.State == ConnectionState.Closed)
                    {
                        cmd.Connection.Open();
                    }
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);
                    return dt;
                }
            }
            catch
            {
                throw;
            }
        }

        public void SpInsertErrorMsg(int cate, int evt, string message,
                                     long processDatetimeTicks, int status, string updatedBy, 
                                     string programID = null, string institutionID = null)
        {
            try
            {
                using (SqlCommand cmd = new SqlCommand("InsertErrorMsg", sqlConnection))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@cate", cate);
                    cmd.Parameters.AddWithValue("@evt", evt);
                    cmd.Parameters.AddWithValue("@message", message);
                    cmd.Parameters.AddWithValue("@status", status);
                    cmd.Parameters.AddWithValue("@updatedBy", updatedBy);
                    cmd.Parameters.AddWithValue("@processDatetime", processDatetimeTicks);
                    cmd.Parameters.AddWithValue("@programID", programID);
                    cmd.Parameters.AddWithValue("@institutionID", institutionID);

                    if (cmd.Connection.State == ConnectionState.Closed)
                    {
                        cmd.Connection.Open();
                    }
                    cmd.ExecuteNonQuery();
                }
            }
            catch
            {
                throw;
            }
        }
        public SqlDataReader SpRetrieveErrorMsg(int cate, int evt, long processDatetimeTicks,
                                                string program = null, string institutionID = null)
        {
            try
            {
                using (SqlCommand cmd = new SqlCommand("RetrieveCPGFD_ErrorMsg", sqlConnection))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@cate", cate);
                    cmd.Parameters.AddWithValue("@evt", evt);
                    cmd.Parameters.AddWithValue("@processDatetime", processDatetimeTicks);
                    cmd.Parameters.AddWithValue("@programID", program);
                    cmd.Parameters.AddWithValue("@institutionID", institutionID);
                    if (cmd.Connection.State == ConnectionState.Closed)
                    {
                        cmd.Connection.Open();
                    }
                    return cmd.ExecuteReader();
                }
            }
            catch
            {
                throw;
            }
        }

        public int SpIsExistInErrorList(int cate, int evt, long processDatetimeTicks,
                                        string program = null, string institutionID = null)
        {
            try
            {
                using (SqlCommand cmd = new SqlCommand("IsExistInErrorList", sqlConnection))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@cate", cate);
                    cmd.Parameters.AddWithValue("@evt", evt);
                    cmd.Parameters.AddWithValue("@processDatetime", processDatetimeTicks);
                    cmd.Parameters.AddWithValue("@programID", program);
                    cmd.Parameters.AddWithValue("@institutionID", institutionID);
                    if (cmd.Connection.State == ConnectionState.Closed)
                    {
                        cmd.Connection.Open();
                    }
                    return (int) cmd.ExecuteScalar();
                }
            }
            catch
            {
                throw;
            }
        }

        public void SpUpdateCPGFD_KB(int evtId, int cateId, int status, string description, 
                                     string potentialErrors, string businessImpact,
                                     int sev, string resolutions, string updatedBy)
        {
            try
            {
                using (SqlCommand cmd = new SqlCommand("UpdateCPGFD_KB", sqlConnection))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@eventID", evtId);
                    cmd.Parameters.AddWithValue("@categoryID", cateId);
                    cmd.Parameters.AddWithValue("@status", status);
                    cmd.Parameters.AddWithValue("@description", description);
                    cmd.Parameters.AddWithValue("@potentialErrors", potentialErrors);
                    cmd.Parameters.AddWithValue("@businessImpact", businessImpact);
                    cmd.Parameters.AddWithValue("@sev", sev);
                    cmd.Parameters.AddWithValue("@resolutions", resolutions);
                    cmd.Parameters.AddWithValue("@updatedBy", updatedBy);

                    if (cmd.Connection.State == ConnectionState.Closed)
                    {
                        cmd.Connection.Open();
                    }
                    cmd.ExecuteNonQuery();
                }
            }
            catch
            {
                throw;
            }
        }

        public SqlDataReader SpRetrieveCPGFD_KB(int evtId, int cateId)
        {
            try
            {
                using (SqlCommand cmd = new SqlCommand("RetrieveCPGFD_KB", sqlConnection))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@eventID", evtId);
                    cmd.Parameters.AddWithValue("@categoryID", cateId);

                    if (cmd.Connection.State == ConnectionState.Closed)
                    {
                        cmd.Connection.Open();
                    }
                    return cmd.ExecuteReader();
                }
            }
            catch
            {
                throw;
            }
        }

        #endregion


        #region  For SLT Alert Windows Services

        public DataTable SpRetrieveTrackingEntryFromTL_EventLog(int eventID, int categoryID, string programID, string institutionID, 
                                                                DateTime startDatetime, DateTime breachDatetime)
        {
            try
            {
                using (SqlCommand cmd = new SqlCommand("RetrieveTrackingEntryFromTL_EventLog", sqlConnection))
                {
                    cmd.CommandTimeout = 600;
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@eventID", eventID);
                    cmd.Parameters.AddWithValue("@categoryID", categoryID);
                    cmd.Parameters.AddWithValue("@programID", programID);
                    cmd.Parameters.AddWithValue("@institutionID", institutionID);
                    cmd.Parameters.AddWithValue("@startDatetime", startDatetime);
                    cmd.Parameters.AddWithValue("@breachDatetime", breachDatetime);

                    if (cmd.Connection.State == ConnectionState.Closed)
                    {
                        cmd.Connection.Open();
                    }
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);
                    return dt;
                }
            }
            catch
            {
                throw;
            }
        }

        public DataTable SpRetrieveCPGFD_SLTRules()
        {
            try
            {
                using (SqlCommand cmd = new SqlCommand("RetrieveCPGFD_SLTRules", sqlConnection))
                {
                    cmd.CommandType = CommandType.StoredProcedure;

                    if (cmd.Connection.State == ConnectionState.Closed)
                    {
                        cmd.Connection.Open();
                    }
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);
                    return dt;
                }
            }
            catch
            {
                throw;
            }
        }

        public void SpUpdateCPGFD_SLTRules_By_NextTriggerDatetime(int eventID, int categoryID, string programID, string institutionID,
                                                                  DateTime nextTriggerDatetime, string user)
        {
            try
            {
                using (SqlCommand cmd = new SqlCommand("UpdateCPGFD_SLTRules_By_NextTriggerDatetime", sqlConnection))
                {
                    
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@eventID", eventID);
                    cmd.Parameters.AddWithValue("@categoryID", categoryID);
                    cmd.Parameters.AddWithValue("@programID", programID);
                    cmd.Parameters.AddWithValue("@institutionID", institutionID);
                    cmd.Parameters.AddWithValue("@nextTriggerDatetime", nextTriggerDatetime);
                    cmd.Parameters.AddWithValue("@user", user);

                    if (cmd.Connection.State == ConnectionState.Closed)
                    {
                        cmd.Connection.Open();
                    }
                    cmd.ExecuteNonQuery();
                }
            }
            catch
            {
                throw;
            }
        }

        public void SpInsertCPGFD_SLTTracking(int eventID, int categoryID, string programID, string institutionID, 
                                              int ruleID, string ruleDescription, 
                                              DateTime startDatetime, DateTime warningDateTime, DateTime breachDateTime,
                                              DateTime? completeDatetime, int status, string user)
        {
            try
            {
                using (SqlCommand cmd = new SqlCommand("InsertCPGFD_SLTTracking", sqlConnection))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@eventID", eventID);
                    cmd.Parameters.AddWithValue("@categoryID", categoryID);
                    cmd.Parameters.AddWithValue("@programID", programID);
                    cmd.Parameters.AddWithValue("@institutionID", institutionID);
                    cmd.Parameters.AddWithValue("@ruleID", ruleID);
                    cmd.Parameters.AddWithValue("@ruleDescription", ruleDescription);                    
                    cmd.Parameters.AddWithValue("@startDatetime", startDatetime);
                    cmd.Parameters.AddWithValue("@warningDateTime", warningDateTime);
                    cmd.Parameters.AddWithValue("@breachDateTime", breachDateTime);
                    cmd.Parameters.AddWithValue("@completeDatetime", completeDatetime != null ? completeDatetime : (DateTime?) null);
                    cmd.Parameters.AddWithValue("@status", status);
                    cmd.Parameters.AddWithValue("@user", user);

                    if (cmd.Connection.State == ConnectionState.Closed)
                    {
                        cmd.Connection.Open();
                    }
                    cmd.ExecuteNonQuery();
                }
            }
            catch
            {
                throw;
            }
        }

        public int SpExistInCPGFD_SLTTracking(long ruleID)
        {
            try
            {
                using (SqlCommand cmd = new SqlCommand("ExistInCPGFD_SLTTracking", sqlConnection))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@ruleID", ruleID);

                    if (cmd.Connection.State == ConnectionState.Closed)
                    {
                        cmd.Connection.Open();
                    }
                    return Convert.ToInt32(cmd.ExecuteScalar());
                }
            }
            catch
            {
                throw;
            }
        }

        public DataTable SpRetrieveCPGFD_SLTTracking(long ruleID)
        {
            try
            {
                using (SqlCommand cmd = new SqlCommand("RetrieveCPGFD_SLTTracking", sqlConnection))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@ruleID", ruleID);

                    if (cmd.Connection.State == ConnectionState.Closed)
                    {
                        cmd.Connection.Open();
                    }
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);
                    return dt;
                }
            }
            catch
            {
                throw;
            }
        }

        public DataTable SpRetrieveAllCPGFD_SLTTracking()
        {
            try
            {
                using (SqlCommand cmd = new SqlCommand("RetrieveAllCPGFD_SLTTracking", sqlConnection))
                {
                    cmd.CommandType = CommandType.StoredProcedure;                    
                    if (cmd.Connection.State == ConnectionState.Closed)
                    {
                        cmd.Connection.Open();
                    }
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);
                    return dt;
                }
            }
            catch
            {
                throw;
            }
        }

        public void SpUpdateCPGFD_SLTTracking(long id, DateTime? completeDatetime, int status, string user)
        {
            try
            {
                if (String.IsNullOrEmpty(user))
                {
                    user = ConfigurationManager.AppSettings["User"];
                }

                using (SqlCommand cmd = new SqlCommand("UpdateCPGFD_SLTTracking", sqlConnection))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@id", id);
                    cmd.Parameters.AddWithValue("@completeDatetime", completeDatetime != null ? completeDatetime : (DateTime?)null);
                    cmd.Parameters.AddWithValue("@status", status);
                    cmd.Parameters.AddWithValue("@user", user);

                    if (cmd.Connection.State == ConnectionState.Closed)
                    {
                        cmd.Connection.Open();
                    }
                    cmd.ExecuteNonQuery();
                }
            }
            catch
            {
                throw;
            }
        }

        public SqlDataReader SpRetrieveSLTTrackingHistory(int cate, int evt, string program, string institutionID)
        {
            try
            {
                using (SqlCommand cmd = new SqlCommand("RetrieveSLTTrackingHistory", sqlConnection))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@cate", cate);
                    cmd.Parameters.AddWithValue("@evt", evt);
                    cmd.Parameters.AddWithValue("@programID", program);
                    cmd.Parameters.AddWithValue("@institutionID", institutionID);
                    if (cmd.Connection.State == ConnectionState.Closed)
                    {
                        cmd.Connection.Open();
                    }
                    return cmd.ExecuteReader();
                }
            }
            catch
            {
                throw;
            }
        }


        public void SpInsertSLTTrackingHistory(int trackingID, string message, string updatedBy)
        {
            try
            {
                using (SqlCommand cmd = new SqlCommand("InsertSLTTrackingHistory", sqlConnection))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@SLTTrackingID", trackingID);
                    cmd.Parameters.AddWithValue("@message", message);
                    cmd.Parameters.AddWithValue("@updatedBy", updatedBy);

                    if (cmd.Connection.State == ConnectionState.Closed)
                    {
                        cmd.Connection.Open();
                    }
                    cmd.ExecuteNonQuery();
                }
            }
            catch
            {
                throw;
            }
        }
        
        #endregion

    }
}