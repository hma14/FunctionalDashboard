using System;
using System.Collections.Generic;
using System.Data.Linq.Mapping;
using System.Linq;
using System.Web;
using FunctionalDashboard.Models;
using FunctionalDashboard.Dal.DataEntity;

namespace FunctionalDashboard.ViewModels
{
    public enum UPASS_CATEGORY
    {
        WAIVE_BENEFIT = 5330,
        ELECT_BENEFIT = 5340,
        LINK_CARD = 5350,
        UNLINK_CARD = 5380
    }

    public enum PPASS_WEB_SERVICE_CATEGORY
    {
        PpassNewCard = 4303,
        PpassTerminatedCard = 4306,
        PpassReplacementCard = 4309,
        PpassSuspendCard = 4316,
        PpassResumeCard = 4317
    }

    public enum UPASS_WEB_SERVICE_CATEGORY
    {
        UpassWaiveBenefitTask = 5330,
        UpassElectBenefitTask = 5340,
        UpassLinkCardTask = 5350,
        UpassUnLinkCardTask = 5380
    }


    public class DataLoadStatus
    {
        public DateTime StartDate { get; set; }
        public DateTime EndDate { get; set; }
        public bool forSLTAlert { get; set; }
    }

    public class LogErrors : EventLogBaseEntity
    {
        [Column(DbType = "int")]
        public int? TaskID { get; set; }

        [Column(DbType = "datetime")]
        public DateTime DateStart { get; set; }

        [Column(DbType = "nvarchar(50)")]
        public string Program { get; set; }

        [Column(DbType = "nvarchar(50)")]
        public string InstitutionID { get; set; }

        [Column(DbType = "nvarchar(100)")]
        public string Institution { get; set; }

        [Column(DbType = "nvarchar(100)")]
        public string FileName { get; set; }

        [Column(DbType = "nvarchar(100)")]
        public string URI { get; set; }

        [Column(DbType = "nvarchar(50)")]
        public string UriType { get; set; }

        [Column(DbType = "nvarchar(50)")]
        public string UniqueParticipantID { get; set; }

        [Column(DbType = "Uniquidentifier")]
        public string GUID { get; set; }

        public List<Event_ID> Events { get; set; }

        [Column(DbType = "int")]
        public int Requests { get; set; }

        [Column(DbType = "nvarchar(50)")]
        public string ProcessErrorID { get; set; }

        [Column(DbType = "nvarchar(4000)")]
        public string ProcessErrorDescr { get; set; }

        [Column(DbType = "int")]
        public int TotalErrors { get; set; }

        [Column(DbType = "int")]
        public int ClearedErrors { get; set; }

        [Column(DbType = "int")]
        public int Acknowledged { get; set; }

        [Column(DbType = "int")]
        public int ErrorID { get; set; }

        [Column(DbType = "text")]
        public string ErrorDesc { get; set; }

        //[Column(DbType = "int")]
        //public int CurrentClicked { get; set; }

    }
    public class OverviewErrors : EventLogBaseEntity
    {
        [Column(DbType = "datetime")]
        public DateTime DateStart { get; set; }

        [Column(DbType = "int")]
        public int NCSCustomerID { get; set; }

        [Column(DbType = "nvarchar(50)")]
        public string Program { get; set; }


        [Column(DbType = "nvarchar(50)")]
        public string InstitutionID { get; set; }

        [Column(DbType = "nvarchar(50)")]
        public string Institution { get; set; }

        [Column(DbType = "int")]
        public int FileErrors { get; set; }

        [Column(DbType = "int")]
        public int WebServiceErrors { get; set; }

        [Column(DbType = "int")]
        public int ApplicationErrors { get; set; }

        [Column(DbType = "bool")]
        public bool Active { get; set; }

        [Column(DbType = "int")]
        public int FilesClearedErrors { get; set; }

        [Column(DbType = "int")]
        public int FilesAcknowledged { get; set; }

        [Column(DbType = "int")]
        public int WSClearedErrors { get; set; }

        [Column(DbType = "int")]
        public int WSAcknowledged { get; set; }

        [Column(DbType = "int")]
        public int AppClearedErrors { get; set; }


    }

    public class ErrorsBase : EventLogBaseEntity
    {
        [Column(DbType = "datetime")]
        public DateTime DateStart { get; set; }

        [Column(DbType = "int")]
        public int NCSCustomerID { get; set; }

        [Column(DbType = "nvarchar(50)")]
        public string Program { get; set; }

        [Column(DbType = "nvarchar(50)")]
        public string InstitutionID { get; set; }

        [Column(DbType = "nvarchar(50)")]
        public string Institution { get; set; }

        [Column(DbType = "Datetime")]
        public DateTime ProcessTime { get; set; }

        [Column(DbType = "int")]
        public int TotalErrors { get; set; }

        [Column(DbType = "int")]
        public int ClearedErrors { get; set; }

        [Column(DbType = "int")]
        public int Acknowledged { get; set; }

        [Column(DbType = "int")]
        public int CurrentClicked { get; set; }
    }

    public class PpassFileErrors : ErrorsBase
    {
        [Column(DbType = "int")]
        public int IufRequests { get; set; }

        [Column(DbType = "int")]
        public int FufRequests { get; set; }

        [Column(DbType = "int")]
        public int FcfRequests { get; set; }

        [Column(DbType = "int")]
        public int IcfRequests { get; set; }
    }

    public class UpassFileErrors : ErrorsBase
    {
        [Column(DbType = "int")]
        public int Requests { get; set; }

        [Column(DbType = "nvarchar(50)")]
        public string Status { get; set; }

    }

    public class PpassProgramFile : PpassFileErrors
    {
        [Column(DbType = "nvarchar(100)")]
        public string URI { get; set; }

        [Column(DbType = "nvarchar(50)")]
        public string FileName { get; set; }

        [Column(DbType = "nvarchar(50)")]
        public string RequestTxID { get; set; }

        [Column(DbType = "nvarchar(50)")]
        public string UniqueParticipantID { get; set; }

        [Column(DbType = "nvarchar(50)")]
        public string CSN { get; set; }

        [Column(DbType = "nvarchar(50)")]
        public string Name { get; set; }

        [Column(DbType = "int")]
        public int OrganizationId { get; set; }

        [Column(DbType = "nvarchar(10)")]
        public string ShortName { get; set; }


        [Column(DbType = "int")]
        public int Requests { get; set; }


        [Column(DbType = "4000")]
        public string ErrorDescr { get; set; }

        [Column(DbType = "4000")]
        public string StackTrace { get; set; }

        [Column(DbType = "int")]
        public int Errors { get; set; }

        public List<File_Info> Files { get; set; }

    }

    public class ProgramWebService : ErrorsBase
    {
        [Column(DbType = "int")]
        public int TaskID { get; set; }

        [Column(DbType = "int")]
        public int? StateID { get; set; }

        [Column(DbType = "nvarchar(100)")]
        public string URI { get; set; }

        [Column(DbType = "nvarchar(100)")]
        public string URIType { get; set; }

        [Column(DbType = "nvarchar(50)")]
        public string UniqueParticipantID { get; set; }

        [Column(DbType = "Uniquidentifier")]
        public string GUID { get; set; }

        [Column(DbType = "nvarchar(50)")]
        public string CSN { get; set; }

        [Column(DbType = "nvarchar(50)")]
        public string Name { get; set; }

        [Column(DbType = "int")]
        public int OrganizationId { get; set; }

        [Column(DbType = "nvarchar(10)")]
        public string ShortName { get; set; }

        [Column(DbType = "nvarchar(10)")]
        public string ErrorID { get; set; }

        [Column(DbType = "4000")]
        public string ErrorDescr { get; set; }

        [Column(DbType = "4000")]
        public string StackTrace { get; set; }

        [Column(DbType = "int")]
        public int Errors { get; set; }

        [Column(DbType = "TimeSpan")]
        public TimeSpan? ElapsedTime { get; set; }

        //[Column(DbType = "Datetime")]
        //public DateTime? ProcessTime { get; set; }

        //[Column(DbType = "nvarchar(50)")]
        //public string ProcessTime2 { get; set; }

    }

    public class PpassProgramWebService : ErrorsBase
    {
        [Column(DbType = "int")]
        public int? TaskID { get; set; }

        [Column(DbType = "int")]
        public int? StateID { get; set; }

        [Column(DbType = "nvarchar(100)")]
        public string URI { get; set; }

        [Column(DbType = "nvarchar(100)")]
        public string URIType { get; set; }

        [Column(DbType = "Uniquidentifier")]
        public string GUID { get; set; }

        [Column(DbType = "nvarchar(50)")]
        public string CSN { get; set; }

        [Column(DbType = "nvarchar(50)")]
        public string Name { get; set; }

        [Column(DbType = "int")]
        public int OrganizationId { get; set; }

        [Column(DbType = "nvarchar(10)")]
        public string ShortName { get; set; }

        [Column(DbType = "nvarchar(10)")]
        public string ErrorID { get; set; }

        [Column(DbType = "4000")]
        public string ErrorDescr { get; set; }

        [Column(DbType = "4000")]
        public string StackTrace { get; set; }

        [Column(DbType = "int")]
        public int Errors { get; set; }

        [Column(DbType = "TimeSpan")]
        public TimeSpan? ElapsedTime { get; set; }

        [Column(DbType = "Datetime")]

        public List<Event_ID> Events { get; set; }

        public int NewCardRequests { get; set; }
        public int TerminatedCardRequests { get; set; }
        public int ReplacementCardRequests { get; set; }
        public int SuspendCardRequests { get; set; }
        public int ResumeCardRequests { get; set; }


    }

    public class UpassProgramFile : UpassFileErrors
    {
        [Column(DbType = "nvarchar(100)")]
        public string URI { get; set; }

        [Column(DbType = "nvarchar(50)")]
        public string FileName { get; set; }


        [Column(DbType = "Uniquidentifier")]
        public string UniqueParticipantID { get; set; }

        [Column(DbType = "nvarchar(50)")]
        public string CSN { get; set; }

        [Column(DbType = "nvarchar(50)")]
        public string Name { get; set; }

        [Column(DbType = "int")]
        public int OrganizationId { get; set; }

        [Column(DbType = "nvarchar(10)")]
        public string ShortName { get; set; }

        [Column(DbType = "4000")]
        public string ErrorDescr { get; set; }

        [Column(DbType = "4000")]
        public string StackTrace { get; set; }

        [Column(DbType = "int")]
        public int Errors { get; set; }

        public List<File_Info> Files { get; set; }
    }

    public class UpassProgramWebService : ErrorsBase
    {
        [Column(DbType = "int")]
        public int? TaskID { get; set; }

        [Column(DbType = "int")]
        public int? StateID { get; set; }

        [Column(DbType = "nvarchar(100)")]
        public string URI { get; set; }

        [Column(DbType = "nvarchar(100)")]
        public string URIType { get; set; }

        [Column(DbType = "Uniquidentifier")]
        public string GUID { get; set; }

        [Column(DbType = "nvarchar(50)")]
        public string CSN { get; set; }

        [Column(DbType = "nvarchar(50)")]
        public string Name { get; set; }

        [Column(DbType = "int")]
        public int OrganizationId { get; set; }

        [Column(DbType = "nvarchar(10)")]
        public string ShortName { get; set; }

        [Column(DbType = "nvarchar(10)")]
        public string ErrorID { get; set; }

        [Column(DbType = "4000")]
        public string ErrorDescr { get; set; }

        [Column(DbType = "4000")]
        public string StackTrace { get; set; }

        [Column(DbType = "int")]
        public int Errors { get; set; }

        [Column(DbType = "TimeSpan")]
        public TimeSpan? ElapsedTime { get; set; }

        [Column(DbType = "Datetime")]

        public List<Event_ID> Events { get; set; }

        public int ElectBenefitRequests { get; set; }
        public int WaiveBenefitRequests { get; set; }
        public int LinkCardRequests { get; set; }
        public int UnlinkCardRequests { get; set; }
        public int WebServiceRequests { get; set; }
        public int OtherRequests { get; set; }

    }


    public class PpassFileDetail : IcfEventLog
    {

        [Column(DbType = "int")]
        public int Errors { get; set; }

        [Column(DbType = "int")]
        public int ClearedErrors { get; set; }

        [Column(DbType = "int")]
        public int Acknowledged { get; set; }

    }

    public class UpassFileDetail : UpassEventLog
    {
        [Column(DbType = "nvarchar(100)")]
        public string Institution { get; set; }

        [Column(DbType = "nvarchar(50)")]
        public string UniqueParticipantId { get; set; }


        [Column(DbType = "int")]
        public int Errors { get; set; }

        [Column(DbType = "int")]
        public int ClearedErrors { get; set; }

        [Column(DbType = "int")]
        public int Acknowledged { get; set; }

    }

    public class PpassWebServiceErrors : ErrorsBase
    {
        [Column(DbType = "int")]
        public int NewCards { get; set; }

        [Column(DbType = "int")]
        public int TerminateCards { get; set; }

        [Column(DbType = "int")]
        public int ReplacementCards { get; set; }

        [Column(DbType = "int")]
        public int SuspendCards { get; set; }

        [Column(DbType = "int")]
        public int ResumeCards { get; set; }

    }

    public class UpassWebServiceErrors : ErrorsBase
    {
        [Column(DbType = "int")]
        public int WaiveBenefits { get; set; }

        [Column(DbType = "int")]
        public int ElectBenefits { get; set; }

        [Column(DbType = "int")]
        public int LinkCards { get; set; }

        [Column(DbType = "int")]
        public int UnlinkCards { get; set; }

        [Column(DbType = "int")]
        public int UpassWebServices { get; set; }

        [Column(DbType = "int")]
        public int Others { get; set; }
    }

    public class Event_ID
    {
        [Column(DbType = "bigint")]
        public long ID { get; set; }

        [Column(DbType = "nvarchar(100)")]
        public string Event { get; set; }

        [Column(DbType = "int")]
        public int EventID { get; set; }

        [Column(DbType = "Uniquidentifier")]
        public string GUID { get; set; }

        [Column(DbType = "nvarchar(500)")]
        public string URI { get; set; }

        [Column(DbType = "datetime")]
        public DateTime ProcessTime { get; set; }

        [Column(DbType = "int")]
        public int? TaskID { get; set; }

        [Column(DbType = "nvarchar(50)")]
        public string LogLevel { get; set; }


    }

    public class File_Info
    {
        [Column(DbType = "bigint")]
        public long ID { get; set; }

        [Column(DbType = "nvarchar(100)")]
        public string Event { get; set; }

        [Column(DbType = "int")]
        public int EventID { get; set; }

        [Column(DbType = "Uniquidentifier")]
        public string UniqueParticipantID { get; set; }

        [Column(DbType = "datetime")]
        public DateTime ProcessTime { get; set; }

        [Column(DbType = "nvarchar(50)")]
        public string RequestTxID { get; set; }

        [Column(DbType = "nvarchar(50)")]
        public string CSN { get; set; }

        [Column(DbType = "nvarchar(50)")]
        public string LogLevel { get; set; }
    }

    public class WebServiceOperationStatus : ErrorsBase
    {
        public int? TaskID { get; set; }
        public string Category { get; set; }
        public string Event { get; set; }

        public List<Event_ID> Events { get; set; }


        [Column(DbType = "Uniquidentifier")]
        public string GUID { get; set; }
        
        [Column(DbType = "nvarchar(50)")]
        public string CardSerialNumber { get; set; }

        

        [Column(DbType = "nvarchar(50)")]
        public string UniqueParticipantID { get; set; }

        [Column(DbType = "nvarchar(100)")]
        public string URI { get; set; }

        [Column(DbType = "int")]
        public int ClearedErrors { get; set; }

        [Column(DbType = "int")]
        public int Acknowledged { get; set; }

        [Column(DbType = "int")]
        public int ErrorID { get; set; }

        [Column(DbType = "text")]
        public string ErrorDesc { get; set; }

        public int CurrentClicked { get; set; }
    }


    public class XmlData : IcfEventLog
    {
        [Column(DbType = "Uniquidentifier")]
        public string GUID { get; set; }

        [Column(DbType = "int")]
        public int TaskID { get; set; }

        [Column(DbType = "int")]
        public int? StateID { get; set; }


        [Column(DbType = "nvarchar(50)")]
        public string ExistingCardSN { get; set; }

        [Column(DbType = "4000")]
        public string StackTrace { get; set; }



    }

    public class UserRequestHistory
    {
        public DateTime DatetimeProcessed { get; set; }

        public string RequestTxID { get; set; }

        public string Category { get; set; }

        public int CategoryID { get; set; }

        public string Action { get; set; }

        public string Reason { get; set; }

        public int Errors { get; set; }
        public int ClearedErrors { get; set; }
        public int Acknowledged { get; set; }
    }



    public class SetEligibilityRequest
    {
        public int EventID { get; set; }
        public int CategoryID { get; set; }

        public string EligDate { get; set; }
        public string Elig { get; set; }
        public DateTime DatetimeProcessed { get; set; }
        public string Status { get; set; }
    }

    public class SetCardRequest
    {
        
        public int CategoryID { get; set; }
        public string Category { get; set; }
        public int EventID { get; set; }
        public string Event { get; set; }
        public string CardSerialNumber { get; set; }
        public DateTime DatetimeProcessed { get; set; }
        public string Status { get; set; }
    }

    public class SetBenefitRequest
    {
        
        public int CategoryID { get; set; }
        public string Category { get; set; }
        public int EventID { get; set; }
        public string Event { get; set; }
        public int BenefitID { get; set; }
        public long BenefitProductID { get; set; }
        public int BenefitMonth { get; set; }
        public int BenefitYear { get; set; }
        public DateTime DatetimeProcessed { get; set; }
        public string Status { get; set; }
    }

    public class ErrorMessage
    {
        public string Message;
        public string UpdatedBy { get; set; }

        public DateTime UpdatedDate { get; set; }
    }

    public class ExportFileFormat
    {
        public string DateStart { get; set; }
        public string Requests { get; set; }
        public string FileName { get; set; }

        public IEnumerable<File_Info> Files { get; set; }
        public string Status { get; set; }        
    }

    public enum KnowledgeBaseStatus
    {
        Inactive,
        Active
    }

    public enum KnowledgeBaseSeverity
    {
        High = 1,
        Significant,
        Regular
    }

    public class KnowledgeBase
    {
        public int EventID { get; set; }
        public int CategoryID { get; set; }
        public int FileName { get; set; }
        public int Status { get; set; }
        public string Description { get; set; }
        public string PotentialErrors { get; set; }
        public string BusinessImpact { get; set; }
        public int Sev { get; set; }
        public string Resolutions { get; set; }
        public string CreatedBy { get; set; }
        public DateTime CreatedDatetime { get; set; }
        public string UpdatedBy { get; set; }
        public DateTime UpdatedDatetime { get; set; }
    }


}