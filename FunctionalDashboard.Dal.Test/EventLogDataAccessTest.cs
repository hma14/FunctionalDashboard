using System;
using System.Collections.Generic;
using System.Linq;
using FunctionalDashboard.Dal.DataEntity;
using Microsoft.VisualStudio.TestTools.UnitTesting;

namespace FunctionalDashboard.Dal.Test
{
    [TestClass]
    public class EventLogDataAccessTest
    {
        private EventLogDataAccess _da = null;
        private const string ConnectionString = "Data Source=MOFFAT;Initial Catalog=UpassDashDev;Integrated Security=SSPI;";

        public EventLogDataAccessTest()
        {
            _da = new EventLogDataAccess(ConnectionString);
        }

        [TestMethod]
        public void TestRetrieveNcsInfo()
        {
            List<NcsInfo> data = _da.RetrieveNcsInfo().ToList();

            Assert.AreEqual(true, data.Any());

        }

        [TestMethod]
        public void TestRetrieveGeneralEventLog()
        {
            DateTime endDate = DateTime.Now;
            DateTime startDate = endDate.AddDays(-15);
            List<GeneralEventLog> data = _da.RetrieveGeneralEventLog(startDate, endDate).ToList();

            Assert.AreEqual(true, data.Any());

        }

        [TestMethod]
        public void TestRetrieveTLEventLogErrorDesc()
        {
            var err = _da.RetrieveTLEventLogErrorDetail(188).ToList();
            Assert.AreEqual(188, err[0].Id);
            err = _da.RetrieveTLEventLogErrorDetail(1).ToList();
            Assert.AreEqual(0, err.Count);
        }

        [TestMethod]
        public void TestRetrieveSyncUtilityDetail()
        {
            var err = _da.RetrieveSyncUtilityDetail(1213915).ToList();
            Assert.AreEqual(1213915, err[0].ID);
            Assert.AreEqual("c399de03-fa17-41eb-84b2-7f8bba7e8cd5", err[0].SyncId);
            err = _da.RetrieveSyncUtilityDetail(1).ToList();
            Assert.AreEqual(0, err.Count);
        }
    }
}
