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
    public class XmlDataPpassUserDetailController : BaseController
    {
        private static DateTime ProcessTime { get; set; }

        public ActionResult Index(string institutionID,
                                  string uniqueParticipantID,
                                  string csn,
                                  long? processTimeTicks,
                                  string requestTxID,
                                  string type,
                                  string action,
                                  string reason
                                  )
        {
            if (processTimeTicks != null)
            {
                ProcessTime = new DateTime((long)processTimeTicks);
                TempData["ProcessTimeTicks"] = processTimeTicks;
            }
            else
            {
                Logs.GeneralLog = Logs.UpdateGeneralEventLogLevel(Logs.GeneralLog);
            }

            if (!string.IsNullOrEmpty(institutionID))
            {
                TempData["InstitutionID"] = institutionID;
            }

            if (!string.IsNullOrEmpty(uniqueParticipantID))
            {
                TempData["UniqueParticipantID"] = uniqueParticipantID;
            }

            if (!string.IsNullOrEmpty(csn))
            {
                TempData["CSN"] = csn;
            }


            // Get current Server from which EventLog is being monitored and display
            SetCurrentServer();

            // Get total memory used so far and set and display
            SetCurrentProcessMemorySize();

            if (Logs.GeneralLog == null || Logs.GeneralLog.Count() == 0)
            {
                Logs.GeneralLog = Logs.CreateGeneralEventLog();
            }

            var entry = Logs.GeneralLog.Where(x => x.ProgramID != PROGRAM_ID.UPASS &&
                                                   x.URIType == "sFTP" &&
                                                   x.InstitutionID == institutionID &&
                                                   x.UniqueParticipantId == uniqueParticipantID &&
                                                   x.RequestTxID == requestTxID &&
                //x.URI.ToUpper().Contains(type.ToUpper()) &&
                //x.Action == action &&
                //x.ReasonCode == reason &&
                                                   x.ProcessDatetime.Ticks == ProcessTime.Ticks
                                              );
            if (!String.IsNullOrEmpty(csn))
            {
                entry = entry.Where(x => x.CardSerialNumber == csn).ToList();
            }
            return View(entry);            
        }      
    }
}
