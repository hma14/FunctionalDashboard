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
    public class XmlDataHHUController : BaseController
    {
        public ActionResult Index(long ID)
        {
            var entry = Logs.RetrieveHHUEventLog(ID);
            return View(entry);
        }
    }
}
