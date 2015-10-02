using FunctionalDashboard.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using PagedList;
using System.IO;
using System.Xml.Linq;
using System.Xml;
using FunctionalDashboard.ViewModels;

namespace FunctionalDashboard.Controllers
{
    public class XmlDataSyncUtilityController : BaseController
    {
        public ActionResult Index(long id)
        {
            // Get current Server from which EventLog is being monitored and display
            SetCurrentServer();

            // Get total memory used so far and set and display
            SetCurrentProcessMemorySize();

            var entry = Logs.RetrieveSyncUtilityEventLog(id);

            return View(entry);

        }
    }
}
