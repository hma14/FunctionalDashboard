using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web.Mvc;


namespace FunctionalDashboard.Controllers
{
    public class UnauthorisedController : Controller
    {    
        public ActionResult Index()
        {
            ViewBag.User = User.Identity.Name;
            return View();
        }       
    }
}
