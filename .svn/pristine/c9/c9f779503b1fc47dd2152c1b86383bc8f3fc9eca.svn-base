using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using FunctionalDashboard.Models;
using System.Data;
using FunctionalDashboard.Dal.DataEntity;
using PagedList;
using System.Web.Configuration;
using System.IO;
using NPOI.HSSF.UserModel;
using System.Globalization;
using NPOI.XSSF.UserModel;
using System.Drawing;
using FunctionalDashboard.Dal;


namespace FunctionalDashboard.Controllers
{
    public class HhuController : BaseController
    {
        // local variables to store consistant values passed from View
        private static string _level = String.Empty;
        private static string _category = String.Empty;
        private static string _eventName = String.Empty;
        private static string _environment = String.Empty;
        private static string _ProgramID = String.Empty;
        private static string _institutionId = String.Empty;
        private static string _cardSerialNumber = String.Empty;
        private static string _taskID = String.Empty;
        private static string _location = String.Empty;
        private static string _fareInstrumentID = String.Empty;
        private static string _processErrorID = String.Empty;
        private static IList<HHUEventLog> RetrievedResult { get; set; }
        private const int pageSize = 10;


        public ActionResult Index(int? page)
        {
            InitializeLogs();

            var entries = Logs.RetrieveHHUEventLog().ToList();
            RetrievedResult = entries;
            CreateDropDownLists(entries);

            

            var ent = from e in entries
                      orderby e.ProcessDatetime descending
                      select e;

            ViewBag.CurrentSort = "processTime_desc";
            ViewBag.LogName = "HHU - Confiscation Log";
            int pageNumber = (page ?? 1);


            // Get total memory used so far and set and display
            SetCurrentProcessMemorySize();

            return View(ent.ToPagedList(pageNumber, pageSize));
        }


        public PartialViewResult AjaxUpdate(string level,
                                            string category,
                                            string eventName,
                                            string env,
                                            string ProgramID,
                                            string institutionId,
                                            string cardSerialNumber,
                                            string taskID,
                                            string location,
                                            string fareInstrumentID,
                                            string processErrorID,
                                            string sortOrder,
                                            string currentFilter,
                                            int? page,
                                            DateTime? startDate,
                                            DateTime? endDate
                                            )
        {
            UpdateDateRange(startDate, endDate);

            var entries = Logs.RetrieveHHUEventLog().ToList();
            CreateDropDownLists(entries);

            // Level
            if (!String.IsNullOrEmpty(level))
            {
                _level = level;
            }
            else if (level == String.Empty)
            {
                _level = String.Empty;
            }
            if (!String.IsNullOrEmpty(_level))
            {
                entries = FilterByLogLevel(entries, _level);
            }

            // Category
            if (!String.IsNullOrEmpty(category))
            {
                _category = category.Split()[0];
            }
            else if (category == String.Empty)
            {
                _category = String.Empty;
            }
            if (!String.IsNullOrEmpty(_category))
            {
                entries = FilterByCategory(entries, _category);
            }

            // Event Name
            if (!String.IsNullOrEmpty(eventName))
            {
                _eventName = eventName.Split()[0];
            }
            else if (eventName == String.Empty)
            {
                _eventName = String.Empty;
            }
            if (!String.IsNullOrEmpty(_eventName))
            {
                entries = FilterByEvent(entries, _eventName);
            }

            // Emvironment
            if (!String.IsNullOrEmpty(env))
            {
                _environment = env;
            }
            else if (env == String.Empty)
            {
                _environment = String.Empty;
            }
            if (!String.IsNullOrEmpty(_environment))
            {
                entries = FilterByEnvironment(entries, _environment);
            }

            // ProgramID
            if (!String.IsNullOrEmpty(ProgramID))
            {
                _ProgramID = ProgramID;
            }
            else if (ProgramID == String.Empty)
            {
                _ProgramID = String.Empty;
            }
            if (!String.IsNullOrEmpty(_ProgramID))
            {
                entries = FilterByProgId(entries, _ProgramID);
            }

            // InstitutionID
            if (!String.IsNullOrEmpty(institutionId))
            {
                _institutionId = institutionId;
            }
            else if (institutionId == String.Empty)
            {
                _institutionId = String.Empty;
            }
            if (!String.IsNullOrEmpty(_institutionId))
            {
                entries = FilterByInstitutionId(entries, _institutionId);
            }

            // Location 
            if (!String.IsNullOrEmpty(location))
            {
                _location = location;
            }
            else if (location == String.Empty)
            {
                _location = String.Empty;
            }
            if (!String.IsNullOrEmpty(_location))
            {
                entries = FilterByLocation(entries, _location);
            }

            // FareInstrumentID
            if (!String.IsNullOrEmpty(fareInstrumentID))
            {
                _fareInstrumentID = fareInstrumentID;
            }
            else if (fareInstrumentID == String.Empty)
            {
                _fareInstrumentID = String.Empty;
            }
            if (!String.IsNullOrEmpty(_fareInstrumentID))
            {
                entries = FilterByFareInstrumentID(entries, _fareInstrumentID);
            }

            // CardSerialNumber - Textbox
            if (!String.IsNullOrEmpty(cardSerialNumber))
            {
                _cardSerialNumber = cardSerialNumber;
            }
            else if (cardSerialNumber == String.Empty)
            {
                _cardSerialNumber = String.Empty;
            }
            if (!String.IsNullOrEmpty(_cardSerialNumber))
            {
                entries = FilterByCardNo(entries, _cardSerialNumber);
            }

            // TaskId
            if (!String.IsNullOrEmpty(taskID))
            {
                _taskID = taskID;
            }
            else if (taskID == String.Empty)
            {
                _taskID = String.Empty;
            }
            if (!String.IsNullOrEmpty(_taskID))
            {
                entries = FilterByTaskId(entries, _taskID);
            }
            // ProcessErrorID
            if (!String.IsNullOrEmpty(processErrorID))
            {
                _processErrorID = processErrorID;
            }
            else if (processErrorID == String.Empty)
            {
                _processErrorID = String.Empty;
            }
            if (!String.IsNullOrEmpty(_processErrorID))
            {
                entries = FilterByErrorId(entries, _processErrorID);
            }


            // Sorting
            //
            if (page == null && startDate == (DateTime?)null && endDate == (DateTime?)null)
            {
                //ViewBag.ProcessTimeSortParm = String.IsNullOrEmpty(sortOrder) ? "processTime_desc" : "";
                ViewBag.ProcessTimeSortParm = sortOrder == "processTime" ? "processTime_desc" : "processTime";
                ViewBag.CategorySortParm = sortOrder == "Category" ? "Category_desc" : "Category";
                ViewBag.EventSortParm = sortOrder == "Event" ? "Event_desc" : "Event";
                ViewBag.TaskIDSortParm = sortOrder == "TaskID" ? "TaskID_desc" : "TaskID";
                ViewBag.StateIdSortParm = sortOrder == "StateID" ? "StateId_desc" : "StateID";
                ViewBag.ProgramIDSortParm = sortOrder == "ProgramID" ? "ProgramID_desc" : "ProgramID";
                ViewBag.InstitutionIdSortParm = sortOrder == "InstitutionID" ? "InstitutionId_desc" : "InstitutionID";
                ViewBag.LocationSortParm = sortOrder == "Location" ? "Location_desc" : "Location";
                ViewBag.FareInstrumentIDSortParm = sortOrder == "FareInstrumentID" ? "FareInstrumentID_desc" : "FareInstrumentID";
                ViewBag.HHUReasonCodeSortParm = sortOrder == "HHUReasonCode" ? "HHUReasonCode_desc" : "HHUReasonCode";
                ViewBag.HHUReasonCodeSortParm = sortOrder == "HHUUserID" ? "HHUUserID_desc" : "HHUUserID";
                ViewBag.ConfiscationDatetimeSortParm = sortOrder == "ConfiscationDatetime" ? "ConfiscationDatetime_desc" : "ConfiscationDatetime";
                ViewBag.CardLinkStateSortParm = sortOrder == "CardLinkState" ? "CardLinkState_desc" : "CardLinkState";
                ViewBag.CardStateSortParm = sortOrder == "CardState" ? "CardState_desc" : "CardState";
                ViewBag.CardSerialNumberStateSortParm = sortOrder == "CardSerialNumber" ? "CardSerialNumber_desc" : "CardSerialNumber";
                ViewBag.URISortParm = sortOrder == "URI" ? "URI_desc" : "URI";
                ViewBag.URITypeSortParm = sortOrder == "URIType" ? "URIType_desc" : "URIType";
                ViewBag.ErrorIDSortParm = sortOrder == "ErrorID" ? "ErrorID_desc" : "ErrorID";
                ViewBag.ErrorDescrSortParm = sortOrder == "ErrorDescr" ? "ErrorDescr_desc" : "ErrorDescr";
            }
            var ent = from e in entries
                      select e;

            switch (sortOrder)
            {
                case "processTime_desc":
                    ent = ent.OrderByDescending(s => s.ProcessDatetime);
                    break;
                case "processTime":
                    ent = ent.OrderBy(s => s.ProcessDatetime);
                    break;
                case "Category_desc":
                    ent = ent.OrderByDescending(s => s.Category);
                    break;
                case "Category":
                    ent = ent.OrderBy(s => s.Category);
                    break;
                case "Event_desc":
                    ent = ent.OrderByDescending(s => s.Event);
                    break;
                case "Event":
                    ent = ent.OrderBy(s => s.Event);
                    break;
                case "ProgramID_desc":
                    ent = ent.OrderByDescending(s => s.ProgramID);
                    break;
                case "ProgramID":
                    ent = ent.OrderBy(s => s.ProgramID);
                    break;
                case "InstitutionId_desc":
                    ent = ent.OrderByDescending(s => s.InstitutionID);
                    break;
                case "InstitutionID":
                    ent = ent.OrderBy(s => s.InstitutionID);
                    break;
                case "Location_desc":
                    ent = ent.OrderByDescending(s => s.Location);
                    break;
                case "Location":
                    ent = ent.OrderBy(s => s.Location);
                    break;
                case "FareInstrumentID_desc":
                    ent = ent.OrderByDescending(s => s.FareInstrumentID);
                    break;
                case "FareInstrumentID":
                    ent = ent.OrderBy(s => s.FareInstrumentID);
                    break;
                case "HHUReasonCode_desc":
                    ent = ent.OrderByDescending(s => s.HHUReasonCode);
                    break;
                case "HHUReasonCode":
                    ent = ent.OrderBy(s => s.HHUReasonCode);
                    break;
                case "HHUUserID_desc":
                    ent = ent.OrderByDescending(s => s.HHUUserID);
                    break;
                case "HHUUserID":
                    ent = ent.OrderBy(s => s.HHUUserID);
                    break;
                case "ConfiscationDatetime_desc":
                    ent = ent.OrderByDescending(s => s.ConfiscationDatetime);
                    break;
                case "ConfiscationDatetime":
                    ent = ent.OrderBy(s => s.ConfiscationDatetime);
                    break;
                case "CardLinkState_desc":
                    ent = ent.OrderByDescending(s => s.CardLinkState);
                    break;
                case "CardLinkState":
                    ent = ent.OrderBy(s => s.CardLinkState);
                    break;
                case "CardState_desc":
                    ent = ent.OrderByDescending(s => s.CardState);
                    break;
                case "CardState":
                    ent = ent.OrderBy(s => s.CardState);
                    break;
                case "CardSerialNumber_desc":
                    ent = ent.OrderByDescending(s => s.CardSerialNumber);
                    break;
                case "CardSerialNumber":
                    ent = ent.OrderBy(s => s.CardSerialNumber);
                    break;
                case "URI_desc":
                    ent = ent.OrderByDescending(s => s.URI);
                    break;
                case "URI":
                    ent = ent.OrderBy(s => s.URI);
                    break;
                case "URIType_desc":
                    ent = ent.OrderByDescending(s => s.URIType);
                    break;
                case "URIType":
                    ent = ent.OrderBy(s => s.URIType);
                    break;
                case "ErrorID_desc":
                    ent = ent.OrderByDescending(s => s.ProcessErrorID);
                    break;
                case "ErrorID":
                    ent = ent.OrderBy(s => s.ProcessErrorID);
                    break;
                case "ErrorDescr":
                    ent = ent.OrderBy(s => s.ProcessErrorDescr);
                    break;
                case "ErrorDescr_desc":
                    ent = ent.OrderByDescending(s => s.ProcessErrorDescr);
                    break;
                default:
                    ent = ent.OrderByDescending(s => s.ProcessDatetime);
                    break;
            }
            entries = ent.ToList();
            ViewBag.CurrentSort = sortOrder;
            int pageNumber = (page ?? 1);

            RetrievedResult = entries;

            LoadCompleted = DateTime.Now;
            return PartialView("_AjaxUpdatePartial", entries.ToPagedList(pageNumber, pageSize));
        }
       

        private void CreateDropDownLists(IList<HHUEventLog> logEntries)
        {
            // Dropdown List for Institution ID
            var InstitutionList = new List<string>();
            var InstitutionQry = from l in logEntries
                                 orderby l.InstitutionID
                                 select l.InstitutionID;

            InstitutionList.AddRange(InstitutionQry.Distinct());
            ViewBag.institutionId = new SelectList(InstitutionList, _institutionId);

            // Dropdown List for Log Level
            var LevelList = new List<string>();
            var LevelQry = from l in logEntries
                           orderby l.Level
                           select l.Level;

            LevelList.AddRange(LevelQry.Distinct());
            ViewBag.Level = new SelectList(LevelList, _level);


            // Dropdown List for Program ID
            var ProgIdList = new List<string>();
            var ProgIdQry = from l in logEntries
                            orderby l.ProgramID
                            select l.ProgramID;

            ProgIdList.AddRange(ProgIdQry.Distinct());
            ViewBag.ProgramID = new SelectList(ProgIdList, _ProgramID);

            // Dropdown List for Category
            var CategoryList = new List<string>();
            var CategoryQry = from l in logEntries
                              orderby l.Category
                              select l.Category + "  (" + l.CategoryID + ")";

            CategoryList.AddRange(CategoryQry.Distinct());
            ViewBag.Category = new SelectList(CategoryList, _category);

            // Dropdown List for Event Name
            var EventList = new List<string>();
            var EventQry = from l in logEntries
                           orderby l.Event
                           select l.Event + "  (" + l.EventID + ")";

            EventList.AddRange(EventQry.Distinct());
            ViewBag.EventName = new SelectList(EventList, _eventName);

            // Dropdown List for Environments 
            var ServerList = new List<string>();
            var ServerQry = from l in logEntries
                            orderby l.Environment
                            select l.Environment;

            ServerList.AddRange(ServerQry.Distinct());
            ViewBag.Env = new SelectList(ServerList, _environment);


            // Dropdown List for Location
            var LocationList = new List<string>();
            var LocationQry = from l in logEntries
                            orderby l.Location
                            select l.Location;

            LocationList.AddRange(LocationQry.Distinct());
            ViewBag.Location = new SelectList(LocationList, _location);



            // Dropdown List for FareInstrument ID
            var FareInstrumentIdList = new List<string>();
            var FareInstrumentIdQry = from l in logEntries
                             orderby l.FareInstrumentID
                             select l.FareInstrumentID;

            FareInstrumentIdList.AddRange(FareInstrumentIdQry.Distinct());
            ViewBag.FareInstrumentID = new SelectList(FareInstrumentIdList, _fareInstrumentID);


            // Dropdown List for Error ID
            var ErrorIdList = new List<string>();
            var ErrorIdQry = from l in logEntries
                             orderby l.ProcessErrorID
                             select l.ProcessErrorID;

            ErrorIdList.AddRange(ErrorIdQry.Distinct());
            ViewBag.ProcessErrorID = new SelectList(ErrorIdList, _processErrorID);
        }

        private List<HHUEventLog> FilterByInstitutionId(IList<HHUEventLog> logEntries, string institutionId)
        {

            // Filtering
            var entries = from l in logEntries
                          select l;

            if (string.IsNullOrEmpty(institutionId))
            {
                return entries.ToList();
            }
            else
            {
                entries = entries.Where(s => s.InstitutionID == institutionId);
                CreateDropDownLists(entries.ToList());
                return entries.ToList();
            }
        }

        private List<HHUEventLog> FilterByLocation(IList<HHUEventLog> logEntries, string location)
        {
            // Filtering
            var entries = from l in logEntries
                          select l;

            if (string.IsNullOrEmpty(location))
            {
                return entries.ToList();
            }
            else
            {
                entries = entries.Where(s => s.Location == location);
                CreateDropDownLists(entries.ToList());
                ViewBag.location = location;
                return entries.ToList();

            }
        }

        private List<HHUEventLog> FilterByCardNo(IList<HHUEventLog> logEntries, string cardNo)
        {
            // Filtering
            var entries = from l in logEntries
                          select l;

            if (string.IsNullOrEmpty(cardNo))
            {
                return entries.ToList();
            }
            else
            {
                entries = entries.Where(s => s.CardSerialNumber == null ? false : s.CardSerialNumber.EndsWith(cardNo));
                CreateDropDownLists(entries.ToList());
                ViewBag.cardSerialNumber = cardNo;
                return entries.ToList();

            }
        }

        private List<HHUEventLog> FilterByTaskId(IList<HHUEventLog> logEntries, string taskID)
        {
            // Filtering
            var entries = from l in logEntries
                          select l;

            if (string.IsNullOrEmpty(taskID))
            {
                return entries.ToList();
            }
            else
            {
                entries = entries.Where(s => s.TaskID.EndsWith(taskID));
                CreateDropDownLists(entries.ToList());
                ViewBag.taskID = taskID;
                return entries.ToList();

            }
        }

        private List<HHUEventLog> FilterByFareInstrumentID(IList<HHUEventLog> logEntries, string fareInstrumentID)
        {
            // Filtering
            var entries = from l in logEntries
                          select l;

            if (string.IsNullOrEmpty(fareInstrumentID))
            {
                return entries.ToList();
            }
            else
            {
                entries = entries.Where(s => s.FareInstrumentID.EndsWith(fareInstrumentID));
                CreateDropDownLists(entries.ToList());
                ViewBag.fareInstrumentID = fareInstrumentID;
                return entries.ToList();
            }
        }

        private List<HHUEventLog> FilterByLogLevel(List<HHUEventLog> logEntries, string level)
        {
            // Filtering
            var entries = from l in logEntries
                          select l;

            if (string.IsNullOrEmpty(level))
            {
                return entries.ToList();
            }
            else
            {
                entries = entries.Where(s => s.Level == level);
                CreateDropDownLists(entries.ToList());
                return entries.ToList();
            }
        }

        private List<HHUEventLog> FilterByProgId(List<HHUEventLog> logEntries, string ProgramID)
        {
            // Filtering
            var entries = from l in logEntries
                          select l;

            if (string.IsNullOrEmpty(ProgramID))
            {
                return entries.ToList();
            }
            else
            {
                entries = entries.Where(s => s.ProgramID == ProgramID);
                CreateDropDownLists(entries.ToList());
                return entries.ToList();
            }
        }

        private List<HHUEventLog> FilterByCategory(List<HHUEventLog> logEntries, string category)
        {
            // Filtering
            var entries = from l in logEntries
                          select l;

            if (string.IsNullOrEmpty(category))
            {
                return entries.ToList();
            }
            else
            {
                entries = entries.Where(s => s.Category == category);
                CreateDropDownLists(entries.ToList());
                return entries.ToList();
            }
        }
        private List<HHUEventLog> FilterByEvent(IList<HHUEventLog> logEntries, string eventName)
        {
            // Filtering
            var entries = from l in logEntries
                          select l;

            if (string.IsNullOrEmpty(eventName))
            {
                return entries.ToList();
            }
            else
            {
                entries = entries.Where(s => (s.Event = s.Event.Replace("\r\n", string.Empty)) == eventName);
                CreateDropDownLists(entries.ToList());
                return entries.ToList();
            }
        }
        private List<HHUEventLog> FilterByDateRange(IList<HHUEventLog> logEntries, DateTime? startDate, DateTime? endDate)
        {
            // Filtering
            var entries = from l in logEntries
                          select l;
            if (startDate.HasValue && endDate.HasValue)
            {
                entries = entries.Where(s => Convert.ToDateTime(s.ProcessDatetime) >= startDate && Convert.ToDateTime(s.ProcessDatetime) <= endDate);
            }
            else if (startDate.HasValue && !endDate.HasValue)
            {
                entries = entries.Where(s => Convert.ToDateTime(s.ProcessDatetime) >= startDate);
            }
            else if (!startDate.HasValue && endDate.HasValue)
            {
                entries = entries.Where(s => Convert.ToDateTime(s.ProcessDatetime) <= endDate);
            }
            CreateDropDownLists(entries.ToList());
            return entries.ToList();
        }

       

        private List<HHUEventLog> FilterByEnvironment(IList<HHUEventLog> logEntries, string env)
        {
            // Filtering
            var entries = from l in logEntries
                          select l;

            entries = entries.Where(s => s.Environment == env);
            CreateDropDownLists(entries.ToList());
            return entries.ToList();
        }

        private List<HHUEventLog> FilterByErrorId(IList<HHUEventLog> logEntries, string errorId)
        {
            // Filtering
            var entries = from l in logEntries
                          select l;

            entries = entries.Where(s => s.ProcessErrorID == errorId);
            CreateDropDownLists(entries.ToList());
            return entries.ToList();
        }

        #region ExportExcel - Export to Excel


        public FileResult ExportExcel()
        {
            var workbook = new XSSFWorkbook();
            var sheet = workbook.CreateSheet("ConfiscationLog");

            var headerRow = sheet.CreateRow(0);
            headerRow.CreateCell(0).SetCellValue("Processtime");
            headerRow.CreateCell(1).SetCellValue("Category (id)");
            headerRow.CreateCell(2).SetCellValue("Event (id)");
            headerRow.CreateCell(3).SetCellValue("ProgramID");
            headerRow.CreateCell(4).SetCellValue("InstitutionID");
            headerRow.CreateCell(5).SetCellValue("TaskID");
            headerRow.CreateCell(6).SetCellValue("StateID");
            headerRow.CreateCell(7).SetCellValue("Location");
            headerRow.CreateCell(8).SetCellValue("FareInstrumentID");
            headerRow.CreateCell(9).SetCellValue("HHUReasonCode");
            headerRow.CreateCell(10).SetCellValue("HHUUserID");
            headerRow.CreateCell(11).SetCellValue("TSID");
            headerRow.CreateCell(12).SetCellValue("CardState");
            headerRow.CreateCell(13).SetCellValue("CardSerialNumber");
            headerRow.CreateCell(14).SetCellValue("ConfiscationDatetime");
            headerRow.CreateCell(15).SetCellValue("URI");
            headerRow.CreateCell(16).SetCellValue("URIType");
            headerRow.CreateCell(17).SetCellValue("ErrorID");
            headerRow.CreateCell(18).SetCellValue("Info/Error Description");
            headerRow.RowStyle = workbook.CreateCellStyle();
            headerRow.RowStyle.Alignment = NPOI.SS.UserModel.HorizontalAlignment.Center;
            

            sheet.CreateFreezePane(0, 1, 0, 1);

            int rowNumber = 1;
            var row = sheet.CreateRow(rowNumber++);
            foreach (var datarow in RetrievedResult)
            {
                row = sheet.CreateRow(rowNumber++);
                row.CreateCell(0).SetCellValue(datarow.ProcessDatetime.ToString("MM/dd/yyyy HH:mm:ss.fff", CultureInfo.InvariantCulture));
                row.CreateCell(1).SetCellValue(String.Format("{0} ({1})", datarow.Category, datarow.CategoryID));
                row.CreateCell(2).SetCellValue(String.Format("{0} ({1})", datarow.Event, datarow.EventID));
                row.CreateCell(3).SetCellValue(datarow.ProgramID);
                row.CreateCell(4).SetCellValue(datarow.InstitutionID);
                row.CreateCell(5).SetCellValue(datarow.TaskID);
                row.CreateCell(6).SetCellValue(datarow.StateID);
                row.CreateCell(7).SetCellValue(datarow.Location);
                row.CreateCell(8).SetCellValue(datarow.FareInstrumentID);
                row.CreateCell(9).SetCellValue(datarow.HHUReasonCode);
                row.CreateCell(10).SetCellValue(datarow.HHUUserID);
                row.CreateCell(11).SetCellValue(datarow.TSID);
                row.CreateCell(12).SetCellValue(datarow.CardState);
                row.CreateCell(13).SetCellValue(datarow.CardSerialNumber);
                row.CreateCell(14).SetCellValue((DateTime) datarow.ConfiscationDatetime);
                row.CreateCell(15).SetCellValue(datarow.URI);
                row.CreateCell(16).SetCellValue(datarow.URIType);
                row.CreateCell(17).SetCellValue(datarow.ProcessErrorID);
                row.CreateCell(18).SetCellValue(datarow.ProcessErrorDescr);
            }


            //XSSFColor foreColor = new XSSFColor(Color.Red);
            XSSFColor backColor = new XSSFColor(Color.Yellow);
            XSSFCellStyle style = (XSSFCellStyle)workbook.CreateCellStyle(); 
            style.SetFillForegroundColor(backColor);
            style.FillPattern = NPOI.SS.UserModel.FillPattern.SolidForeground;
            style.Alignment = NPOI.SS.UserModel.HorizontalAlignment.Center;
            XSSFFont font = (XSSFFont) workbook.CreateFont();
            font.FontHeightInPoints = 12;
            font.FontName = "Calibri";
            font.Boldweight = (short)NPOI.SS.UserModel.FontBoldWeight.Bold; 

            for (int i = 0; i <= 18; i++)
            {                              
                XSSFCell cell = (XSSFCell)headerRow.GetCell(i);                
                cell.CellStyle = style;
                cell.CellStyle.SetFont(font);
            }

            for (int i = 0; i <= 18; i++)
            {
                sheet.AutoSizeColumn(i);
            }

            MemoryStream output = new MemoryStream();
            workbook.Write(output);
            return File(output.ToArray(), "application/vnd.ms-excel", "UpassLog.xlsx");
        }

        #endregion

    }
}
