﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace FunctionalDashboard.Models
{
    public class Constants
    {
        public static string Key_GeneralEventLog = "GeneralEventLog";
        public static string Key_NcsInfo = "NcsInfo.";
        public static string Key_ErrorDesc = "ErrDesc.";
        public static string Key_SyncUtil = "SyncUtil.";
        public static string Key_HHU = "HHU.";


        public static int MaxInt = 65535;

        public static DateTime StartDate { get; set; }
        public static DateTime EndDate { get; set; }


    }

    public class SortColumnName
    {
        public const string ProcessDatetime = "ProcessDatetime";
        public const string Event = "Event";
        public const string Status = "Status";
        public const string Program = "Program";
        public const string Institution = "Institution";
        public const string Category = "Category";
    }

    public class ENVIRONMENT
    {
        public static string Production = "Production";
        public static string Development = "Development";
        public static string ExtQA = "ExtQA";
        public static string IntQA = "IntQA";
        public static string Staging = "Staging";

    }

    public class CATEGORY_ID_WEBSERVICES
    {
        // PPASS
        public const int NEW_CARD = 24;
        public const int TERMINATE_CARD = 28;
        public const int REPLACEMENT_CARD = 25;
        public const int SUSPEND_CARD = 27;
        public const int RESUME_CARD = 26;

        // UPASS
        public const int WAIVE_BENEFIT = 32;
        public const int ELECT_BENEFIT = 31;
        public const int LINK_CARD = 29;
        public const int UNLINK_CARD = 30;
        public const int WEB_SERVICES = 50;
        public const int REQUEST_FILE = 21;
        public const int RESPONSE_FILE = 22;
        public const int ELIGIBILITY_STATUS = 44;

    }

    public class EVENT_NAME_ID
    {
        public const int UpassEligibilityStatusEnded = 5410;
        public const int UpassABUpdateMemberElectBenefitPendingEnded = 5341;
        public const int UpassABAddAutoLoadPendingEnded = 5348;
        public const int UpassWSAssignCard = 5500;
        public const int UpassWSUnAssignCard = 5501;
        public const int UpassWSRegisterBenefit = 5502;
        public const int UpassLCLinkCardRequestedEnded = 5350;
        public const int UpassUCUnlinkCardRequestedEnded = 5380;
        public const int UpassABBenefitEnabledEnded = 5340;
        public const int UpassRBWaiveBenefitRequestedEnded = 5330;
        public const int UpassRBProcessAutoloadPendingEnded = 5333;

    }



    public class CATEGORY_ID_FILES
    {
        public const int FUF = 15;
        public const int ICF = 16;
        public const int FCF = 17;
        public const int IUF = 20;

    }


    public class PROGRAM_ID
    {
        public static readonly string UPASS = "UPASS";
        public static readonly string PPASS = "PPASS";
    }


    public enum STATUS
    {
        CLEARED,
        ERROR,
        ACK
    }


    public enum SLTTrackingStatus
    {
        COMPLETED,
        WARNING,
        BREACHING
    }

}