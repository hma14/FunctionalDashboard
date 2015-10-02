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
    public class XmlDataPpassWSController : XmlDataController
    {
        public ActionResult Index(long ID)
        {
            return View(XmlDataCommon(ID));
        }
    }
}
