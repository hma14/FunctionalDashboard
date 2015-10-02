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
using NPOI.XSSF.UserModel;
using System.Globalization;
using System.IO;
using System.Drawing;


namespace FunctionalDashboard.Controllers
{
    public class IcfController : BaseController
    {
        // local variables to store consistant values passed from View
        private static string _level = String.Empty;
        private static string _category = String.Empty;
        private static string _eventName = String.Empty;
        private static string _environment = String.Empty;
        private static string _progId = String.Empty;
        private static string _institutionId = String.Empty;
        private static string _CardSerialNumber = String.Empty;
        private static string _RequestTxID = String.Empty;
        private static string _act = String.Empty;
        private static string _FileStatus = String.Empty;
        private static string _ReasonCode = String.Empty;
        private static string _Benefit = String.Empty;
        private static string _CardTypeCode = String.Empty;
        private static string _processErrorID = String.Empty;
        private static IList<GeneralEventLog> RetrievedResult { get; set; }
        private const int pageSize = 5;

        public ActionResult Index(
                                    int? page,
                                    DateTime? startDate,
                                    DateTime? endDate
                                  )
        {
            InitializeLogs();

            IList<GeneralEventLog> entries = Logs.GeneralLog.Where(e => e.ProcessDatetime >= StartDate && 
                                                                        e.ProcessDatetime <= EndDate && 
                                                                        e.ProgramID == PROGRAM_ID.PPASS &&
                                                                        e.CategoryID == CATEGORY_ID_FILES.ICF).ToList();
            RetrievedResult = entries;
            CreateDropDownLists(entries);

            

            var ent = from e in entries
                      orderby e.ProcessDatetime descending
                      select e;

            ViewBag.CurrentSort = "processTime_desc";
            ViewBag.LogName = "ICF Log";
            int pageNumber = (page ?? 1);

            // Get total memory used so far and set and display
            SetCurrentProcessMemorySize();

            return View(ent.ToPagedList(pageNumber, pageSize));
        }

        public ActionResult AjaxUpdate(string level,
                                        string category,
                                        string eventName,
                                        string env,
                                        string progId,
                                        string institutionId,
                                        string FileStatus,
                                        string CardSerialNumber,
                                        string RequestTxID,
                                        string act,
                                        string ReasonCode,
                                        string Benefit,
                                        string CardTypeCode,
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
                                                                        e.ProgramID != PROGRAM_ID.UPASS &&
                                                                        e.CategoryID == CATEGORY_ID_FILES.ICF).ToList();
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

            // progId
            if (!String.IsNullOrEmpty(progId))
            {
                _progId = progId;
            }
            else if (progId == String.Empty)
            {
                _progId = String.Empty;
            }
            if (!String.IsNullOrEmpty(_progId))
            {
                entries = FilterByProgId(entries, _progId);
            }

            // D
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

            // CardSerialNumber 
            if (!String.IsNullOrEmpty(CardSerialNumber))
            {
                _CardSerialNumber = CardSerialNumber;
            }
            else if (CardSerialNumber == String.Empty)
            {
                _CardSerialNumber = String.Empty;
            }
            if (!String.IsNullOrEmpty(_CardSerialNumber))
            {
                entries = FilterByCardNo(entries, _CardSerialNumber);
            }

            // RequestTxID
            if (!String.IsNullOrEmpty(RequestTxID))
            {
                _RequestTxID = RequestTxID;
            }
            else if (RequestTxID == String.Empty)
            {
                _RequestTxID = String.Empty;
            }
            if (!String.IsNullOrEmpty(_RequestTxID))
            {
                entries = FilterByRequestTxID(entries, _RequestTxID);
            }

            // Action
            if (!String.IsNullOrEmpty(act))
            {
                _act = act;
            }
            else if (act == String.Empty)
            {
                _act = String.Empty;
            }
            if (!String.IsNullOrEmpty(_act))
            {
                entries = FilterByAction(entries, _act);
            }


            // FileStatus
            if (!String.IsNullOrEmpty(FileStatus))
            {
                _FileStatus = FileStatus;
            }
            else if (FileStatus == String.Empty)
            {
                _FileStatus = String.Empty;
            }
            if (!String.IsNullOrEmpty(_FileStatus))
            {
                entries = FilterByFileStatus(entries, _FileStatus);
            }

            // ReasonCode
            if (!String.IsNullOrEmpty(ReasonCode))
            {
                _ReasonCode = ReasonCode;
            }
            else if (ReasonCode == String.Empty)
            {
                _ReasonCode = String.Empty;
            }
            if (!String.IsNullOrEmpty(_ReasonCode))
            {
                entries = FilterByReasonCode(entries, _ReasonCode);
            }

            // Benefit
            if (!String.IsNullOrEmpty(Benefit))
            {
                _Benefit = Benefit;
            }
            else if (Benefit == String.Empty)
            {
                _Benefit = String.Empty;
            }
            if (!String.IsNullOrEmpty(_Benefit))
            {
                entries = FilterByReasonCode(entries, _Benefit);
            }


            // CardTypeCode
            if (!String.IsNullOrEmpty(CardTypeCode))
            {
                _CardTypeCode = CardTypeCode;
            }
            else if (CardTypeCode == String.Empty)
            {
                _CardTypeCode = String.Empty;
            }
            if (!String.IsNullOrEmpty(_CardTypeCode))
            {
                entries = FilterByCardTypeCode(entries, _CardTypeCode);
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

                ViewBag.ProcessTimeSortParm = sortOrder == "processTime" ? "processTime_desc" : "processTime";
                ViewBag.CategorySortParm = sortOrder == "Category" ? "Category_desc" : "Category";
                ViewBag.EventSortParm = sortOrder == "Event" ? "Event_desc" : "Event";
                ViewBag.TaskIDSortParm = sortOrder == "RequestTxID" ? "RequestTxID_desc" : "RequestTxID";
                ViewBag.UniqueParticipantIdSortParm = sortOrder == "UniqueParticipantId" ? "UniqueParticipantId_desc" : "UniqueParticipantId";
                ViewBag.ProgramIDSortParm = sortOrder == "ProgramID" ? "ProgramID_desc" : "ProgramID";
                ViewBag.InstitutionIdSortParm = sortOrder == "D" ? "InstitutionId_desc" : "D";
                ViewBag.RequestTxIDSortParm = sortOrder == "RequestTxID" ? "RequestTxID_desc" : "RequestTxID";
                ViewBag.ActionSortParm = sortOrder == "Action" ? "Action_desc" : "Action";
                ViewBag.CardSerialNumberSortParm = sortOrder == "CardSerialNumber" ? "CardSerialNumber_desc" : "CardSerialNumber";
                ViewBag.ReasonCodeSortParm = sortOrder == "ReasonCode" ? "ReasonCode_desc" : "ReasonCode";
                ViewBag.BenefitSortParm = sortOrder == "Benefit" ? "Benefit_desc" : "Benefit";
                ViewBag.URISortParm = sortOrder == "URI" ? "URI_desc" : "URI";
                ViewBag.URITypeSortParm = sortOrder == "URIType" ? "URIType_desc" : "URIType";
                ViewBag.ErrorIDSortParm = sortOrder == "ErrorID" ? "ErrorID_desc" : "ErrorID";
                ViewBag.ErrorDescrSortParm = sortOrder == "ErrorDescr" ? "ErrorDescr_desc" : "ErrorDescr";
                ViewBag.UploadFileNameSortParm = sortOrder == "UploadFileName" ? "UploadFileName_desc" : "UploadFileName";
                ViewBag.SFCodeSortParm = sortOrder == "SFCode" ? "SFCode_desc" : "SFCode";
                ViewBag.SFDescrSortParm = sortOrder == "SFDescr" ? "SFDescr_desc" : "SFDescr";
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
                case "D":
                    ent = ent.OrderBy(s => s.InstitutionID);
                    break;
                case "UniqueParticipantId_desc":
                    ent = ent.OrderByDescending(s => s.UniqueParticipantId);
                    break;
                case "UniqueParticipantId":
                    ent = ent.OrderBy(s => s.UniqueParticipantId);
                    break;
                case "RequestTxID_desc":
                    ent = ent.OrderByDescending(s => s.RequestTxID);
                    break;
                case "RequestTxID":
                    ent = ent.OrderBy(s => s.RequestTxID);
                    break;
                case "Action_desc":
                    ent = ent.OrderByDescending(s => s.Action);
                    break;
                case "Action":
                    ent = ent.OrderBy(s => s.Action);
                    break;
                case "CardSerialNumber_desc":
                    ent = ent.OrderByDescending(s => s.CardSerialNumber);
                    break;
                case "CardSerialNumber":
                    ent = ent.OrderBy(s => s.CardSerialNumber);
                    break;
                case "ReasonCode_desc":
                    ent = ent.OrderByDescending(s => s.ReasonCode);
                    break;
                case "ReasonCode":
                    ent = ent.OrderBy(s => s.ReasonCode);
                    break;
                case "Benefit_desc":
                    ent = ent.OrderByDescending(s => s.Benefit);
                    break;
                case "Benefit":
                    ent = ent.OrderBy(s => s.Benefit);
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
            ViewBag.ProgramID = new SelectList(ProgIdList, _progId);

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

            // Dropdown List for FileStatus
            var FileStatusList = new List<string>();
            var FileStatusQry = from l in logEntries
                                orderby l.FileStatus
                                select l.FileStatus;

            FileStatusList.AddRange(FileStatusQry.Distinct());
            ViewBag.FileStatus = new SelectList(FileStatusList, _FileStatus);


            // Dropdown List for Environments 
            var ServerList = new List<string>();
            var ServerQry = from l in logEntries
                            orderby l.Environment
                            select l.Environment;

            ServerList.AddRange(ServerQry.Distinct());
            ViewBag.Env = new SelectList(ServerList, _environment);

            // Dropdown List for Action
            var ActionList = new List<string>();
            var ActionQry = from l in logEntries
                            orderby l.Action
                            select l.Action;

            ActionList.AddRange(ActionQry.Distinct());
            ViewBag.act = new SelectList(ActionList, _act);

            // Dropdown List for ReasonCode
            var ReasonCodeList = new List<string>();
            var ReasonCodeQry = from l in logEntries
                                orderby l.ReasonCode
                                select l.ReasonCode;

            ReasonCodeList.AddRange(ReasonCodeQry.Distinct());
            ViewBag.ReasonCode = new SelectList(ReasonCodeList, _ReasonCode);

            // Dropdown List for Benefit
            var BenefitList = new List<string>();
            var BenefitQry = from l in logEntries
                             orderby l.Benefit
                             select l.Benefit;

            BenefitList.AddRange(BenefitQry.Distinct());
            ViewBag.Benefit = new SelectList(BenefitList, _Benefit);

            // Dropdown List for CardTypeCode
            var CardTypeCodeList = new List<string>();
            var CardTypeCodeQry = from l in logEntries
                                  orderby l.CardTypeCode
                                  select l.CardTypeCode;

            CardTypeCodeList.AddRange(CardTypeCodeQry.Distinct());
            ViewBag.CardTypeCode = new SelectList(CardTypeCodeList, _CardTypeCode);

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

        private IList<GeneralEventLog> FilterByCardNo(IList<GeneralEventLog> logEntries, string cardNo)
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
                ViewBag.CardSerialNumber = cardNo;
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


        private IList<GeneralEventLog> FilterByProgId(IList<GeneralEventLog> logEntries, string progId)
        {
            // Filtering
            var entries = from l in logEntries
                          select l;

            if (string.IsNullOrEmpty(progId))
            {
                return entries.ToList();
            }
            else
            {
                entries = entries.Where(s => s.ProgramID == progId);
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
                entries = entries.Where(s => s.Event == eventName);
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



        private IList<GeneralEventLog> FilterByFileStatus(IList<GeneralEventLog> logEntries, string status)
        {
            // Filtering
            var entries = from l in logEntries
                          select l;

            entries = entries.Where(s => s.FileStatus == status);
            CreateDropDownLists(entries.ToList());
            return entries.ToList();

        }

        private IList<GeneralEventLog> FilterByRequestTxID(IList<GeneralEventLog> logEntries, string requestTxID)
        {
            // Filtering
            var entries = from l in logEntries
                          select l;

            if (string.IsNullOrEmpty(requestTxID))
            {
                return entries.ToList();
            }
            else
            {
                entries = entries.Where(s => s.RequestTxID == null ? false : s.RequestTxID.ToUpper().EndsWith(requestTxID.ToUpper()));
                CreateDropDownLists(entries.ToList());
                ViewBag.RequestTxID = requestTxID;
                return entries.ToList();
            }
        }

        private IList<GeneralEventLog> FilterByAction(IList<GeneralEventLog> logEntries, string act)
        {
            // Filtering
            var entries = from l in logEntries
                          select l;

            entries = entries.Where(s => s.Action == act);
            CreateDropDownLists(entries.ToList());
            return entries.ToList();

        }
        private IList<GeneralEventLog> FilterByReasonCode(IList<GeneralEventLog> logEntries, string reasonCode)
        {
            // Filtering
            var entries = from l in logEntries
                          select l;

            entries = entries.Where(s => s.ReasonCode == reasonCode);
            CreateDropDownLists(entries.ToList());
            return entries.ToList();

        }
        private IList<GeneralEventLog> FilterByBenefit(IList<GeneralEventLog> logEntries, string benefit)
        {
            // Filtering
            var entries = from l in logEntries
                          select l;

            entries = entries.Where(s => s.Benefit == benefit);
            CreateDropDownLists(entries.ToList());
            return entries.ToList();

        }
        private IList<GeneralEventLog> FilterByCardTypeCode(IList<GeneralEventLog> logEntries, string cardTypeCode)
        {
            // Filtering
            var entries = from l in logEntries
                          select l;

            entries = entries.Where(s => s.CardTypeCode == cardTypeCode);
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
            var sheet = workbook.CreateSheet("IcfLog");

            var headerRow = sheet.CreateRow(0);
            headerRow.CreateCell(0).SetCellValue("Processtime");
            headerRow.CreateCell(1).SetCellValue("Category (id)");
            headerRow.CreateCell(2).SetCellValue("Event (id)");
            headerRow.CreateCell(3).SetCellValue("UploadFileName");
            headerRow.CreateCell(4).SetCellValue("ProgramID");
            headerRow.CreateCell(5).SetCellValue("InstitutionID");
            headerRow.CreateCell(6).SetCellValue("FileStatus");
            headerRow.CreateCell(7).SetCellValue("RequestTxID");
            headerRow.CreateCell(8).SetCellValue("UniqueParticipantId");
            headerRow.CreateCell(9).SetCellValue("CardSerialNumber");
            headerRow.CreateCell(10).SetCellValue("Action");
            headerRow.CreateCell(11).SetCellValue("ReasonCode");
            headerRow.CreateCell(12).SetCellValue("Benefit");
            headerRow.CreateCell(13).SetCellValue("CardTypeCode");
            headerRow.CreateCell(14).SetCellValue("SFCode");
            headerRow.CreateCell(15).SetCellValue("SFDescr");
            headerRow.CreateCell(16).SetCellValue("URI");
            headerRow.CreateCell(17).SetCellValue("URIType");
            headerRow.CreateCell(18).SetCellValue("ErrorID");
            headerRow.CreateCell(19).SetCellValue("Info/Error Description");
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
                row.CreateCell(3).SetCellValue(datarow.UploadFileName);
                row.CreateCell(4).SetCellValue(datarow.ProgramID);
                row.CreateCell(5).SetCellValue(datarow.InstitutionID);
                row.CreateCell(6).SetCellValue(datarow.FileStatus);
                row.CreateCell(7).SetCellValue(String.Format("{0}", datarow.RequestTxID));
                row.CreateCell(8).SetCellValue(String.Format("{0}", datarow.UniqueParticipantId));
                row.CreateCell(9).SetCellValue(datarow.CardSerialNumber);
                row.CreateCell(10).SetCellValue(datarow.Action);
                row.CreateCell(11).SetCellValue(datarow.ReasonCode);
                row.CreateCell(12).SetCellValue(datarow.Benefit);
                row.CreateCell(13).SetCellValue(datarow.CardTypeCode);
                row.CreateCell(14).SetCellValue(datarow.SuccessFailureCode);
                row.CreateCell(15).SetCellValue(datarow.SuccessFailureDescr);
                row.CreateCell(16).SetCellValue(datarow.URI);
                row.CreateCell(17).SetCellValue(datarow.URIType);
                row.CreateCell(18).SetCellValue(datarow.ProcessErrorID);
                row.CreateCell(19).SetCellValue(datarow.ProcessErrorDescr);
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

            for (int i = 0; i <= 19; i++)
            {
                XSSFCell cell = (XSSFCell)headerRow.GetCell(i);
                cell.CellStyle = style;
                cell.CellStyle.SetFont(font);
            }

            for (int i = 0; i <= 19; i++)
            {
                sheet.AutoSizeColumn(i);
            }

            MemoryStream output = new MemoryStream();
            workbook.Write(output);
            return File(output.ToArray(), "application/vnd.ms-excel", "IcfLog.xlsx");
        }

        #endregion

    }
}
