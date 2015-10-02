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
using System.Globalization;

namespace FunctionalDashboard.Controllers
{
    public class XmlDataController : BaseController
    {
        public ActionResult XmlData(string program, long processTimeTicks, int? taskID, string category, int eventID, string guid, string uri, string level)
        {
            DateTime processTime = new DateTime(processTimeTicks);
            if (Logs.GeneralLog == null || Logs.GeneralLog.Count() == 0)
            {
                Logs.GeneralLog = Logs.CreateGeneralEventLog();
            }

            var entry = Logs.GeneralLog
                        .Where(x => x.ProgramID == program &&
                                    x.TaskID == taskID &&
                                    (x.URIType != "sFTP") &&
                                    x.Category == category &&
                                    x.EventID == eventID &&
                                    x.Level == level &&
                                    x.ProcessDatetime == processTime);
            if (uri != null)
            {
                entry = entry.Where(x => x.URI == uri);
            }

            // Get current Server from which EventLog is being monitored and display
            SetCurrentServer();

            // Get total memory used so far and set and display
            SetCurrentProcessMemorySize();

            return View(entry);
        }

        public ActionResult XmlData(long ID)
        {
            if (Logs.GeneralLog == null || Logs.GeneralLog.Count() == 0)
            {
                Logs.GeneralLog = Logs.CreateGeneralEventLog();
            }            

            var entry = Logs.GeneralLog
                        .Where(x => x.ID == ID);

            var list = entry.ToList();

            if (list.Any())
            {
                var l = list[0];
                if (!string.IsNullOrEmpty(l.ProcessErrorID))
                {
                    var err = Logs.RetrieveEventProcessError(l.ID);
                    if (err != null)
                    {
                        l.ProcessErrorDescr = err.ProcessErrorDescr;
                        l.StackTrace = err.StackTrace;
                    }
                }
            }

            

            Session["InstitutionID"] = (string) entry.First().InstitutionID;

            // Get current Server from which EventLog is being monitored and display
            SetCurrentServer();

            // Get total memory used so far and set and display
            SetCurrentProcessMemorySize();

           // return View(entry);
            return View(list);
        }
    }
}
