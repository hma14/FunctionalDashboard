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
    public class XmlDataUpassWSController : XmlDataController
    {
        //public ActionResult Index(string program, long processTimeTicks, int ? taskID, string category, int eventID, string guid, string uri, string level)
        public ActionResult Index(long ID)
        {
            //return XmlData(program, processTimeTicks, taskID, category, eventID, guid, uri, level);
            return View(XmlDataCommon(ID));
        }
    }
}
