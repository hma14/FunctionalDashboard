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
using NPOI.XSSF.UserModel;
using System.IO;
using System.Globalization;
using System.Drawing;


namespace FunctionalDashboard.Controllers
{
    public class UpassSetEligController : BaseController
    {
        // local variables to store consistant values passed from View
        private static string _level = String.Empty;
        private static string _category = String.Empty;
        private static string _eventName = String.Empty;
        private static string _environment = String.Empty;
        private static string _ProgramID = String.Empty;
        private static string _institutionId = String.Empty;
        private static string _uniqueParticipantID = String.Empty;
        private static string _taskId = String.Empty;
        private static string _processErrorID = String.Empty;
        private static IList<GeneralEventLog> RetrievedResult { get; set; }
        private const int pageSize = 10;


        public ActionResult Index(
                                    int? page,
                                    DateTime? startDate,
                                    DateTime? endDate
                                  )
        {
            InitializeLogs();

            var entries = Logs.GeneralLog.Where(e => e.ProcessDatetime.Ticks >= StartDate.Ticks && 
                                                     e.ProcessDatetime.Ticks <= EndDate.Ticks &&
                                                     e.ProgramID == PROGRAM_ID.UPASS &&
                                                     (e.CategoryID == CATEGORY_ID_WEBSERVICES.ELECT_BENEFIT ||
                                                     e.CategoryID == CATEGORY_ID_WEBSERVICES.REQUEST_FILE ||
                                                     e.CategoryID == CATEGORY_ID_WEBSERVICES.RESPONSE_FILE ||
                                                     e.CategoryID == CATEGORY_ID_WEBSERVICES.ELIGIBILITY_STATUS)).ToList();
            RetrievedResult = entries;
            CreateDropDownLists(entries);

            var ent = from e in entries
                      orderby e.ProcessDatetime descending
                      select e;

            ViewBag.CurrentSort = "processTime_desc";
            ViewBag.LogName = "UpassSetElig Log";
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
                                            string uniqueParticipantID,
                                            string taskId,
                                            string processErrorID,
                                            string sortOrder,
                                            string currentFilter,
                                            int? page,
                                            DateTime? startDate,
                                            DateTime? endDate
                                            )
        {
            UpdateDateRange(startDate, endDate);
            
            IList<GeneralEventLog> entries = Logs.GeneralLog.Where(e => e.ProcessDatetime >= StartDate && 
                                                                        e.ProcessDatetime <= EndDate &&
                                                                        e.ProgramID == PROGRAM_ID.UPASS &&
                                                                        (e.CategoryID == CATEGORY_ID_WEBSERVICES.ELECT_BENEFIT ||
                                                                        e.CategoryID == CATEGORY_ID_WEBSERVICES.REQUEST_FILE || 
                                                                        e.CategoryID == CATEGORY_ID_WEBSERVICES.RESPONSE_FILE ||
                                                                        e.CategoryID == CATEGORY_ID_WEBSERVICES.ELIGIBILITY_STATUS)).ToList();
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

            // UniqueParticipantID - Textbox
            if (!String.IsNullOrEmpty(uniqueParticipantID))
            {
                _uniqueParticipantID = uniqueParticipantID;
            }
            else if (uniqueParticipantID == String.Empty)
            {
                _uniqueParticipantID = String.Empty;
            }
            if (!String.IsNullOrEmpty(_uniqueParticipantID))
            {
                entries = FilterByUniquParticipantID(entries, _uniqueParticipantID);
            }

            // TaskId
            if (!String.IsNullOrEmpty(taskId))
            {
                _taskId = taskId;
            }
            else if (taskId == String.Empty)
            {
                _taskId = String.Empty;
            }
            if (!String.IsNullOrEmpty(_taskId))
            {
                entries = FilterByTaskId(entries, _taskId);
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
            if (page == null && startDate == null && endDate == null)
            {
                //ViewBag.ProcessTimeSortParm = String.IsNullOrEmpty(sortOrder) ? "processTime_desc" : "";
                ViewBag.ProcessTimeSortParm = sortOrder == "processTime" ? "processTime_desc" : "processTime";
                ViewBag.CategorySortParm = sortOrder == "Category" ? "Category_desc" : "Category";
                ViewBag.EventSortParm = sortOrder == "Event" ? "Event_desc" : "Event";
                ViewBag.ProgramIDSortParm = sortOrder == "ProgramID" ? "ProgramID_desc" : "ProgramID";
                ViewBag.InstitutionIdSortParm = sortOrder == "InstitutionID" ? "InstitutionID_desc" : "InstitutionID";
                ViewBag.FileStatusSortParm = sortOrder == "FileStatus" ? "FileStatus_desc" : "FileStatus";
                ViewBag.UniqueParticipantIDSortParm = sortOrder == "UniqueParticipantID" ? "UniqueParticipantID_desc" : "UniqueParticipantID";
                ViewBag.TSIDSortParm = sortOrder == "TSID" ? "TSID_desc" : "TSID";
                ViewBag.EligSortParm = sortOrder == "Elig" ? "Elig_desc" : "Elig";
                ViewBag.EligDateSortParm = sortOrder == "EligDate" ? "EligDate_desc" : "EligDate";
                ViewBag.RvalSortParm = sortOrder == "Rval" ? "Rval_desc" : "Rval";
                ViewBag.RextSortParm = sortOrder == "Rext" ? "Rext_desc" : "Rext";
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
                case "InstitutionID_desc":
                    ent = ent.OrderByDescending(s => s.InstitutionID);
                    break;
                case "InstitutionID":
                    ent = ent.OrderBy(s => s.InstitutionID);
                    break;
                case "FileStatus_desc":
                    ent = ent.OrderByDescending(s => s.FileStatus);
                    break;
                case "FileStatus":
                    ent = ent.OrderBy(s => s.FileStatus);
                    break;
                case "UniqueParticipantID_desc":
                    ent = ent.OrderByDescending(s => s.UniqueParticipantId);
                    break;
                case "UniqueParticipantID":
                    ent = ent.OrderBy(s => s.UniqueParticipantId);
                    break;
                case "TSID_desc":
                    ent = ent.OrderByDescending(s => s.TSID);
                    break;
                case "TSID":
                    ent = ent.OrderBy(s => s.TSID);
                    break;
                case "Elig_desc":
                    ent = ent.OrderByDescending(s => s.Elig);
                    break;
                case "Elig":
                    ent = ent.OrderBy(s => s.Elig);
                    break;
                case "EligDate_desc":
                    ent = ent.OrderByDescending(s => s.EligDate);
                    break;
                case "EligDate":
                    ent = ent.OrderBy(s => s.EligDate);
                    break;
                case "Rval":
                    ent = ent.OrderBy(s => s.Rval);
                    break;
                case "Rval_desc":
                    ent = ent.OrderByDescending(s => s.Rval);
                    break;
                case "Rext":
                    ent = ent.OrderBy(s => s.Rext);
                    break;
                case "Rext_desc":
                    ent = ent.OrderByDescending(s => s.Rext);
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
       

        private void CreateDropDownLists(IList<GeneralEventLog> logEntries)
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


            // Dropdown List for Error ID
            var ErrorIdList = new List<string>();
            var ErrorIdQry = from l in logEntries
                             orderby l.ProcessErrorID
                             select l.ProcessErrorID;

            ErrorIdList.AddRange(ErrorIdQry.Distinct());
            ViewBag.ProcessErrorID = new SelectList(ErrorIdList, _processErrorID);
        }

        private IList<GeneralEventLog> FilterByInstitutionId(IList<GeneralEventLog> logEntries, string institutionId)
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

        private IList<GeneralEventLog> FilterByUniquParticipantID(IList<GeneralEventLog> logEntries, string uniqueParticipantID)
        {
            // Filtering
            var entries = from l in logEntries
                          select l;

            if (string.IsNullOrEmpty(uniqueParticipantID))
            {
                return entries.ToList();
            }
            else
            {
                entries = entries.Where(s => s.UniqueParticipantId == null ? false : s.UniqueParticipantId.EndsWith(uniqueParticipantID));
                CreateDropDownLists(entries.ToList());
                ViewBag.uniqueParticipantID = uniqueParticipantID;
                return entries.ToList();

            }
        }

        private IList<GeneralEventLog> FilterByTaskId(IList<GeneralEventLog> logEntries, string taskId)
        {
            // Filtering
            var entries = from l in logEntries
                          select l;

            if (string.IsNullOrEmpty(taskId))
            {
                return entries.ToList();
            }
            else
            {
                entries = entries.Where(s => s.TaskID == null ? false : s.TaskID.ToString().EndsWith(taskId));
                CreateDropDownLists(entries.ToList());
                ViewBag.taskId = taskId;
                return entries.ToList();
            }
        }

        private IList<GeneralEventLog> FilterByLogLevel(IList<GeneralEventLog> logEntries, string level)
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

        private IList<GeneralEventLog> FilterByProgId(IList<GeneralEventLog> logEntries, string ProgramID)
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

        private IList<GeneralEventLog> FilterByCategory(IList<GeneralEventLog> logEntries, string category)
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
        private IList<GeneralEventLog> FilterByEvent(IList<GeneralEventLog> logEntries, string eventName)
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
        private IList<GeneralEventLog> FilterByDateRange(IList<GeneralEventLog> logEntries, DateTime? startDate, DateTime? endDate)
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

        private IList<GeneralEventLog> FilterByMonth(IList<GeneralEventLog> logEntries, string month)
        {
            // Filtering
            var entries = from l in logEntries
                          select l;

            entries = entries.Where(s => s.Month == int.Parse(month));
            CreateDropDownLists(entries.ToList());
            return entries.ToList();

        }

        private IList<GeneralEventLog> FilterByEnvironment(IList<GeneralEventLog> logEntries, string env)
        {
            // Filtering
            var entries = from l in logEntries
                          select l;

            entries = entries.Where(s => s.Environment == env);
            CreateDropDownLists(entries.ToList());
            return entries.ToList();
        }

        private IList<GeneralEventLog> FilterByErrorId(IList<GeneralEventLog> logEntries, string errorId)
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
            var sheet = workbook.CreateSheet("UpassSetEligLog");

            var headerRow = sheet.CreateRow(0);
            headerRow.CreateCell(0).SetCellValue("Processtime");
            headerRow.CreateCell(1).SetCellValue("Category (id)");
            headerRow.CreateCell(2).SetCellValue("Event (id)");
            headerRow.CreateCell(3).SetCellValue("ProgramID");
            headerRow.CreateCell(4).SetCellValue("InstitutionID");
            headerRow.CreateCell(5).SetCellValue("FileStatus");
            headerRow.CreateCell(6).SetCellValue("UniqueParticipantID");
            headerRow.CreateCell(7).SetCellValue("TSID");
            headerRow.CreateCell(8).SetCellValue("Elig");
            headerRow.CreateCell(9).SetCellValue("EligDate");
            headerRow.CreateCell(10).SetCellValue("Rval");
            headerRow.CreateCell(11).SetCellValue("Rext");
            headerRow.CreateCell(12).SetCellValue("URI");
            headerRow.CreateCell(13).SetCellValue("URIType");
            headerRow.CreateCell(14).SetCellValue("ErrorID");
            headerRow.CreateCell(15).SetCellValue("Info/Error Description");
            headerRow.RowStyle = workbook.CreateCellStyle();
            headerRow.RowStyle.Alignment = NPOI.SS.UserModel.HorizontalAlignment.Center;

            sheet.CreateFreezePane(0, 1, 1, 1);

            int rowNumber = 1;
            var row = sheet.CreateRow(rowNumber++);
            int h = sheet.DefaultRowHeight;
            foreach (var datarow in RetrievedResult)
            {
                row = sheet.CreateRow(rowNumber++);
                row.CreateCell(0).SetCellValue(datarow.ProcessDatetime.ToString("MM/dd/yyyy HH:mm:ss.fff", CultureInfo.InvariantCulture));
                row.CreateCell(1).SetCellValue(String.Format("{0} ({1})", datarow.Category, datarow.CategoryID));
                row.CreateCell(2).SetCellValue(String.Format("{0} ({1})", datarow.Event, datarow.EventID));
                row.CreateCell(3).SetCellValue(datarow.ProgramID);
                row.CreateCell(4).SetCellValue(datarow.InstitutionID);
                row.CreateCell(5).SetCellValue(datarow.FileStatus);
                row.CreateCell(6).SetCellValue(datarow.UniqueParticipantId);
                row.CreateCell(7).SetCellValue(datarow.TSID);
                row.CreateCell(8).SetCellValue(datarow.Elig);
                row.CreateCell(9).SetCellValue(datarow.EligDate);
                row.CreateCell(10).SetCellValue(datarow.Rval);
                row.CreateCell(11).SetCellValue(datarow.Rext);
                row.CreateCell(12).SetCellValue(datarow.URI);
                row.CreateCell(13).SetCellValue(datarow.URIType);
                row.CreateCell(14).SetCellValue(datarow.ProcessErrorID);
                row.CreateCell(15).SetCellValue(datarow.ProcessErrorDescr);
            }

            XSSFColor backColor = new XSSFColor(Color.Yellow);
            XSSFCellStyle style = (XSSFCellStyle)workbook.CreateCellStyle();
            style.SetFillForegroundColor(backColor);
            style.FillPattern = NPOI.SS.UserModel.FillPattern.SolidForeground;
            style.Alignment = NPOI.SS.UserModel.HorizontalAlignment.Center;
            XSSFFont font = (XSSFFont)workbook.CreateFont();
            font.FontHeightInPoints = 12;
            font.FontName = "Calibri";
            font.Boldweight = (short)NPOI.SS.UserModel.FontBoldWeight.Bold;

            for (int i = 0; i <= 15; i++)
            {
                XSSFCell cell = (XSSFCell)headerRow.GetCell(i);
                cell.CellStyle = style;
                cell.CellStyle.SetFont(font);
            }

            for (int i = 0; i <= 15; i++ )
            {
                sheet.AutoSizeColumn(i);               
            }
                
            MemoryStream output = new MemoryStream();
            workbook.Write(output);
           
            return File(output.ToArray(), "application/vnd.ms-excel", "UpassSetEligLog.xlsx");
        }

        #endregion
    }
}
