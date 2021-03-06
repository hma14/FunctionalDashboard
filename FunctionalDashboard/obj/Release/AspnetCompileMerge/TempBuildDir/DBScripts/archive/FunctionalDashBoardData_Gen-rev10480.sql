USE [FunctionalDashBoardData]
GO
/****** Object:  User [BCTGTWDOM\achen]    Script Date: 10/15/2014 11:21:30 AM ******/
DROP USER [BCTGTWDOM\achen]
GO
CREATE USER [BCTGTWDOM\achen] FOR LOGIN [BCTGTWDOM\achen] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [BCTGTWDOM\Domain Users]    Script Date: 10/15/2014 11:21:30 AM ******/
DROP USER [BCTGTWDOM\Domain Users]
GO
CREATE USER [BCTGTWDOM\Domain Users] FOR LOGIN [BCTGTWDOM\Domain Users]
GO
/****** Object:  User [BCTGTWDOM\hema]    Script Date: 10/15/2014 11:21:30 AM ******/
DROP USER [BCTGTWDOM\hema]
GO
CREATE USER [BCTGTWDOM\hema] FOR LOGIN [BCTGTWDOM\hema] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [BCTGTWDOM\svcSCOrchestrator]    Script Date: 10/15/2014 11:21:30 AM ******/
DROP USER [BCTGTWDOM\svcSCOrchestrator]
GO
CREATE USER [BCTGTWDOM\svcSCOrchestrator] FOR LOGIN [BCTGTWDOM\svcSCOrchestrator] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [BCTGTWDOM\achen]
GO
ALTER ROLE [db_datareader] ADD MEMBER [BCTGTWDOM\Domain Users]
GO
ALTER ROLE [db_owner] ADD MEMBER [BCTGTWDOM\hema]
GO
ALTER ROLE [db_datawriter] ADD MEMBER [BCTGTWDOM\svcSCOrchestrator]
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================

/****** Object:  StoredProcedure [dbo].[RetrieveEventLog]    Script Date: 10/15/2014 11:21:30 AM ******/
IF OBJECT_ID('[dbo].[RetrieveEventLog]', 'P') IS NOT NULL
	DROP PROCEDURE [dbo].[RetrieveEventLog]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[RetrieveEventLog] (@startDate Datetime)
	
AS
BEGIN
	
	SET NOCOUNT ON;

    SELECT 
      el.ID,
      el.Source,
      --COALESCE(c.CategoryName, 'DUMMY') AS Category,
	  COALESCE('DUMMY', 'DUMMY') AS Category,
	  e.EventName AS Event,
	  el.EventID,
      el.Level,
	  el.Computer,
      el.LoggedTime,
      DATEPART(MM,el.LoggedTime) As Month,
      DATEPART(YYYY,el.LoggedTime) As Year,
      DATEPART(DD,el.LoggedTime) As Day,
	  el.XMLdata
     
FROM
      EventLogs el   WITH (NOLOCK)
	  LEFT OUTER JOIN EventIDList e ON el.EventID = e.EventID															     
      -- LEFT OUTER JOIN CategoryIDList c ON el.CategoryID = c.CategoryID -- will change to this line
WHERE
      el.EventID between 1000 and 11000
	  and el.LoggedTime >= @startDate
      and el.XMLdata.value('(/rawData/ProcessDatetime/node())[1]', 'nvarchar(4000)') is not null  
	  
ORDER BY 
      el.LoggedTime Desc

END





GO
/****** Object:  StoredProcedure [dbo].[RetrieveNCSInfo]    Script Date: 10/15/2014 11:21:30 AM ******/
IF OBJECT_ID('[dbo].[RetrieveNCSInfo]', 'P') IS NOT NULL
	DROP PROCEDURE [dbo].[RetrieveNCSInfo]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[RetrieveNCSInfo]
AS
BEGIN
	SELECT OrganizationId, InstitutionId, ProgramId, Active, Name, ShortName
	FROM NCSInfo
END

GO
/****** Object:  StoredProcedure [dbo].[SyncNCSInfo]    Script Date: 10/15/2014 11:21:30 AM ******/
IF OBJECT_ID('[dbo].[SyncNCSInfo]', 'P') IS NOT NULL
	DROP PROCEDURE [dbo].[SyncNCSInfo]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SyncNCSInfo]
AS
BEGIN
	IF OBJECT_ID('dbo.NCSInfo', 'U') IS NOT NULL
	DROP TABLE dbo.NCSInfo

	SELECT ir.OrganizationId, ip.InstitutionId, ip.ProgramId, ip.Active, ir.Name, ir.ShortName
	INTO dbo.NCSInfo
	FROM [NORTON].[UPASSPRD118].[dbo].[InstitutionProgram] ip
	INNER JOIN [NORTON].[UPASSPRD118].[dbo].[InstitutionRegistry] ir ON ip.InstitutionId = ir.id
END

GO


/****** Object:  Table [dbo].[EventLogs]    Script Date: 05/28/2014 9:02:33 AM ******/
IF OBJECT_ID('[dbo].[EventLogs]', 'U') IS NOT NULL
	DROP TABLE [dbo].[EventLogs]
GO

/****** Object:  Table [dbo].[EventLogs]    Script Date: 10/15/2014 11:24:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EventLogs](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[Source] [nvarchar](50) NULL,
	[LogName] [nvarchar](50) NULL,
	[EventID] [int] NULL,
	[Level] [nvarchar](50) NULL,
	[LoggedTime] [datetime2](7) NULL,
	[Computer] [nvarchar](50) NULL,
	[XMLdata] [xml] NULL,
 CONSTRAINT [PK_NC_EventLogs_ID] PRIMARY KEY NONCLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]


GO
/****** Object:  Table [dbo].[CategoryIDList]    Script Date: 10/15/2014 11:21:30 AM ******/
IF OBJECT_ID('[dbo].[CategoryIDList]', 'U') IS NOT NULL
	DROP TABLE [dbo].[CategoryIDList]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CategoryIDList](
	[CategoryName] [nvarchar](255) NULL,
	[CategoryID] [float] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[EventIDList]    Script Date: 10/15/2014 11:21:30 AM ******/
IF OBJECT_ID('[dbo].[EventIDList]', 'U') IS NOT NULL
	DROP TABLE [dbo].[EventIDList]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EventIDList](
	[EventName] [nvarchar](255) NULL,
	[EventID] [float] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[NCSInfo]    Script Date: 10/15/2014 11:21:30 AM ******/
IF OBJECT_ID('[dbo].[NCSInfo]', 'U') IS NOT NULL
	DROP TABLE [dbo].[NCSInfo]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[NCSInfo](
	[OrganizationId] [int] NULL,
	[InstitutionId] [varchar](10) NOT NULL,
	[ProgramId] [varchar](10) NOT NULL,
	[Active] [bit] NOT NULL,
	[Name] [varchar](100) NOT NULL,
	[ShortName] [varchar](24) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  View [dbo].[report_eventlog_status]    Script Date: 10/15/2014 11:21:30 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF OBJECT_ID('[dbo].[report_eventlog_status]', 'V') IS NOT NULL
	DROP VIEW [dbo].[report_eventlog_status]
GO
create view [dbo].[report_eventlog_status]
as
select Computer, MAX(loggedtime) as LatestDate from EventLogs with (NOLOCK) group by Computer
union all
select 'UTCTime' as Computer, SYSUTCDATETIME() as LatestDate


GO
/****** Object:  View [dbo].[report_fileprocessing_extqa]    Script Date: 10/15/2014 11:21:30 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF OBJECT_ID('[dbo].[report_fileprocessing_extqa]', 'V') IS NOT NULL
	DROP VIEW [dbo].[report_fileprocessing_extqa]
GO
create view [dbo].[report_fileprocessing_extqa]
as
SELECT 
	ID,
	Source,
	EventID,
	Level,
	LoggedTime,
	DATEPART(MM,LoggedTime) As LoggedMonth,
	DATEPART(YYYY,LoggedTime) As LoggedYear,
	DATEPART(DD,LoggedTime) As LoggedDay,
	[XMLdata].value('(/rawData//ProgramID/node())[1]', 'nvarchar(4000)') AS ProgramID,
	[XMLdata].value('(/rawData//InstitutionID/node())[1]', 'nvarchar(4000)') AS InstitutionID,
	[XMLdata].value('(/rawData//URI/node())[1]', 'nvarchar(4000)') AS URI,
	[XMLdata].value('(/rawData//URIType/node())[1]', 'nvarchar(4000)') AS URIType,
	[XMLdata].value('(/rawData//ProcessDatetime/node())[1]', 'nvarchar(4000)') AS ProcessDatetime,
	[XMLdata].value('(/rawData//ProcessErrorID/node())[1]', 'nvarchar(4000)') AS ProcessErrorID,
	[XMLdata].value('(/rawData//ProcessErrorDescr/node())[1]', 'nvarchar(4000)') AS ProcessErrorDescr
FROM
	EventLogs
WHERE
	Computer = 'upasapt02' 
	and EventID between 1000 and 1050
	and [XMLdata].value('(/rawData//ProcessDatetime/node())[1]', 'nvarchar(4000)') is NOT null 

GO
/****** Object:  View [dbo].[report_fileprocessing_intqa]    Script Date: 10/15/2014 11:21:30 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF OBJECT_ID('[dbo].[report_fileprocessing_intqa]', 'V') IS NOT NULL
	DROP VIEW [dbo].[report_fileprocessing_intqa]
GO
create view [dbo].[report_fileprocessing_intqa]
as
SELECT 
	ID,
	Source,
	EventID,
	Level,
	LoggedTime,
	DATEPART(MM,LoggedTime) As LoggedMonth,
	DATEPART(YYYY,LoggedTime) As LoggedYear,
	DATEPART(DD,LoggedTime) As LoggedDay,
	[XMLdata].value('(/rawData//ProgramID/node())[1]', 'nvarchar(4000)') AS ProgramID,
	[XMLdata].value('(/rawData//InstitutionID/node())[1]', 'nvarchar(4000)') AS InstitutionID,
	[XMLdata].value('(/rawData//URI/node())[1]', 'nvarchar(4000)') AS URI,
	[XMLdata].value('(/rawData//URIType/node())[1]', 'nvarchar(4000)') AS URIType,
	[XMLdata].value('(/rawData//ProcessDatetime/node())[1]', 'nvarchar(4000)') AS ProcessDatetime,
	[XMLdata].value('(/rawData//ProcessErrorID/node())[1]', 'nvarchar(4000)') AS ProcessErrorID,
	[XMLdata].value('(/rawData//ProcessErrorDescr/node())[1]', 'nvarchar(4000)') AS ProcessErrorDescr
FROM
	EventLogs
WHERE
	Computer = 'upasapt03' 
	and EventID between 1000 and 1050
	and [XMLdata].value('(/rawData//ProcessDatetime/node())[1]', 'nvarchar(4000)') is NOT null 

GO
/****** Object:  View [dbo].[report_fileprocessing_prod]    Script Date: 10/15/2014 11:21:30 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF OBJECT_ID('[dbo].[report_fileprocessing_prod]', 'V') IS NOT NULL
	DROP VIEW [dbo].[report_fileprocessing_prod]
GO
create view [dbo].[report_fileprocessing_prod]
as
SELECT 
	ID,
	Source,
	EventID,
	Level,
	LoggedTime,
	DATEPART(MM,LoggedTime) As LoggedMonth,
	DATEPART(YYYY,LoggedTime) As LoggedYear,
	DATEPART(DD,LoggedTime) As LoggedDay,
	[XMLdata].value('(/rawData//ProgramID/node())[1]', 'nvarchar(4000)') AS ProgramID,
	[XMLdata].value('(/rawData//InstitutionID/node())[1]', 'nvarchar(4000)') AS InstitutionID,
	[XMLdata].value('(/rawData//URI/node())[1]', 'nvarchar(4000)') AS URI,
	[XMLdata].value('(/rawData//URIType/node())[1]', 'nvarchar(4000)') AS URIType,
	[XMLdata].value('(/rawData//ProcessDatetime/node())[1]', 'nvarchar(4000)') AS ProcessDatetime,
	[XMLdata].value('(/rawData//ProcessErrorID/node())[1]', 'nvarchar(4000)') AS ProcessErrorID,
	[XMLdata].value('(/rawData//ProcessErrorDescr/node())[1]', 'nvarchar(4000)') AS ProcessErrorDescr
FROM
	EventLogs
WHERE
	Computer = 'upasapp01' 
	and EventID between 1000 and 1050
	and [XMLdata].value('(/rawData//ProcessDatetime/node())[1]', 'nvarchar(4000)') is NOT null 
GO
INSERT [dbo].[CategoryIDList] ([CategoryName], [CategoryID]) VALUES (N'InboundFileMonitorService', 1000)
INSERT [dbo].[CategoryIDList] ([CategoryName], [CategoryID]) VALUES (N'InboundFileMonitor', 1001)
INSERT [dbo].[CategoryIDList] ([CategoryName], [CategoryID]) VALUES (N'OutboundFileMonitorService', 1002)
INSERT [dbo].[CategoryIDList] ([CategoryName], [CategoryID]) VALUES (N'OutboundFileMonitor', 1003)
INSERT [dbo].[CategoryIDList] ([CategoryName], [CategoryID]) VALUES (N'FileProcessor', 1004)
INSERT [dbo].[CategoryIDList] ([CategoryName], [CategoryID]) VALUES (N'CubicProxy', 2000)
INSERT [dbo].[CategoryIDList] ([CategoryName], [CategoryID]) VALUES (N'MediaRequestFileProcessorService', 3000)
INSERT [dbo].[CategoryIDList] ([CategoryName], [CategoryID]) VALUES (N'CommonFileProcessor', 3001)
INSERT [dbo].[CategoryIDList] ([CategoryName], [CategoryID]) VALUES (N'MediaRequestFileProcessorService', 3002)
INSERT [dbo].[CategoryIDList] ([CategoryName], [CategoryID]) VALUES (N'MediaRequestCommon', 3003)
INSERT [dbo].[CategoryIDList] ([CategoryName], [CategoryID]) VALUES (N'MediaRequestValidation', 3004)
INSERT [dbo].[CategoryIDList] ([CategoryName], [CategoryID]) VALUES (N'MediaRequestCubic', 3005)
INSERT [dbo].[CategoryIDList] ([CategoryName], [CategoryID]) VALUES (N'MediaRequestEngine', 3006)
INSERT [dbo].[CategoryIDList] ([CategoryName], [CategoryID]) VALUES (N'MediaRequestGenerateFuf', 3007)
INSERT [dbo].[CategoryIDList] ([CategoryName], [CategoryID]) VALUES (N'MediaRequestGenerateIcf', 3008)
INSERT [dbo].[CategoryIDList] ([CategoryName], [CategoryID]) VALUES (N'MediaRequestReceiveFcf', 3009)
INSERT [dbo].[CategoryIDList] ([CategoryName], [CategoryID]) VALUES (N'MediaRequestSchedulerService', 3010)
INSERT [dbo].[CategoryIDList] ([CategoryName], [CategoryID]) VALUES (N'GdServiceProvider', 3011)
INSERT [dbo].[CategoryIDList] ([CategoryName], [CategoryID]) VALUES (N'MediaRequestReceiveIuf', 3012)
INSERT [dbo].[CategoryIDList] ([CategoryName], [CategoryID]) VALUES (N'UpassRequestFile', 3013)
INSERT [dbo].[CategoryIDList] ([CategoryName], [CategoryID]) VALUES (N'UpassResponseFile', 3014)
INSERT [dbo].[CategoryIDList] ([CategoryName], [CategoryID]) VALUES (N'UpassStateEngine', 3015)
INSERT [dbo].[CategoryIDList] ([CategoryName], [CategoryID]) VALUES (N'PpassNewCard', 4303)
INSERT [dbo].[CategoryIDList] ([CategoryName], [CategoryID]) VALUES (N'PpassTerminatedCard', 4306)
INSERT [dbo].[CategoryIDList] ([CategoryName], [CategoryID]) VALUES (N'PpassReplacementCard', 4309)
INSERT [dbo].[CategoryIDList] ([CategoryName], [CategoryID]) VALUES (N'PpassSuspendCard', 4316)
INSERT [dbo].[CategoryIDList] ([CategoryName], [CategoryID]) VALUES (N'PpassResumeCard', 4317)
INSERT [dbo].[CategoryIDList] ([CategoryName], [CategoryID]) VALUES (N'UpassWaiveBenefitTask', 5330)
INSERT [dbo].[CategoryIDList] ([CategoryName], [CategoryID]) VALUES (N'UpassElectBenefitTask', 5340)
INSERT [dbo].[CategoryIDList] ([CategoryName], [CategoryID]) VALUES (N'UpassLinkCardTask', 5350)
INSERT [dbo].[CategoryIDList] ([CategoryName], [CategoryID]) VALUES (N'UpassUnLinkCardTask', 5380)
INSERT [dbo].[CategoryIDList] ([CategoryName], [CategoryID]) VALUES (N'DatabasePurgeService', 6001)
INSERT [dbo].[CategoryIDList] ([CategoryName], [CategoryID]) VALUES (N'FilePurgeService', 6002)
INSERT [dbo].[CategoryIDList] ([CategoryName], [CategoryID]) VALUES (N'EmailRequestedTask', 7100)
INSERT [dbo].[CategoryIDList] ([CategoryName], [CategoryID]) VALUES (N'ConfiscationRequestedTask', 8500)
INSERT [dbo].[CategoryIDList] ([CategoryName], [CategoryID]) VALUES (N'ConfiscationHotlistPendingTask', 8501)
INSERT [dbo].[CategoryIDList] ([CategoryName], [CategoryID]) VALUES (N'ConfiscationCheckProgramPendingTask', 8502)
INSERT [dbo].[CategoryIDList] ([CategoryName], [CategoryID]) VALUES (N'ConfiscationGetStudentInfoPendingTask', 8503)
INSERT [dbo].[CategoryIDList] ([CategoryName], [CategoryID]) VALUES (N'ConfiscationUpdateStudentStatusPendingTask', 8504)
INSERT [dbo].[CategoryIDList] ([CategoryName], [CategoryID]) VALUES (N'ConfiscationCreateNotificationTaskPEndingTask', 8509)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'ProcessFilesStarted', 1000)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'ProcessFilesFailed', 1001)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'ProcessFilesEnded', 1002)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'ProcessEachFileStarted', 1003)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'ProcessEachFileFailed', 1004)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'ProcessEachFileEnded ', 1005)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'UnzipFilesStarted', 1006)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'UnzipFilesFailed', 1007)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'UnzipFilesEnded', 1008)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'DecryptFileStarted', 1009)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'DecryptFileFailed', 1010)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'DecryptFileEnded', 1011)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'ValidateFileStarted', 1012)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'ValidateFileEnded', 1013)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'DeserializeFileStarted', 1014)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'DeserializeFileEnded', 1015)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'InboundFileMonitorStarted', 1016)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'InboundFileMonitorEnded', 1017)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'StartMonitorStarted', 1018)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'StartMonitorEnded', 1019)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'GetInstitionsStarted', 1020)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'GetInstitionsEnded', 1021)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'CheckFolderStarted', 1022)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'CheckFolderFailed', 1023)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'CheckFolderEnded', 1024)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'ProcessFileStarted', 1025)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'ProcessFileEnded', 1026)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'SaveFileEnded', 1027)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'ProcessOutboundQueueStarted', 1029)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'ProcessOutboundQueueEnded', 1030)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'ProcessOutboundFileStarted', 1031)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'ProcessOutboundFileEnded', 1032)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'ProcessOutboundFileFailed', 1033)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'MoveOutboundFileStarted', 1034)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'MoveOutboundFileAttempted', 1035)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'MoveOutboundFileEnded', 1036)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'GenerateFileStarted', 1037)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'GenerateFileAttempted', 1038)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'GenerateFileEnded', 1039)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'CompressFileStarted', 1040)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'CompressFileAttempted', 1041)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'CompressFileEnded', 1042)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'EncryptFileStarted', 1043)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'EncryptFileAttempted', 1044)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'EncryptFileEnded', 1045)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'OutboundFileMonitorStarted', 1050)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'OutboundFileMonitorEnded', 1051)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'RemoveFromHotlistStarted', 2000)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'RemoveFromHotlistFailed', 2001)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'RemoveFromHotlistEnded', 2002)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'HotlistCardStarted', 2010)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'HotlistCardFailed', 2011)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'HotlistCardEnded', 2012)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'LinkCSCToCustomerStarted', 2020)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'LinkCSCToCustomerFailed', 2021)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'LinkCSCToCustomerEnded', 2022)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'UnlinkCSCFromCustomerStarted', 2030)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'UnlinkCSCFromCustomerFailed', 2031)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'UnlinkCSCFromCustomerEnded', 2032)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'GetCustomerMembersSummaryInfoStarted', 2040)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'GetCustomerMembersSummaryInfoFailed', 2041)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'GetCustomerMembersSummaryInfoEnded', 2042)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'AddNewMemberStarted', 2050)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'AddNewMemberFailed', 2051)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'AddNewMemberEnded', 2052)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'UpdateMemberStarted', 2060)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'UpdateMemberFailed', 2061)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'UpdateMemberEnded', 2062)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'AddDirectedAutoloadStarted', 2070)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'AddDirectedAutoloadFailed', 2071)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'AddDirectedAutoloadEnded', 2072)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'InitAndIssueCscStarted', 2080)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'InitAndIssueCscFailed', 2081)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'InitAndIssueCscEnded', 2082)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'GetCustomerBenefitsStarted', 2090)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'GetCustomerBenefitsFailed', 2091)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'GetCustomerBenefitsEnded', 2092)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'GetCardStateStarted', 2100)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'GetCardStateFailed', 2101)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'GetCardStateEnded', 2102)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'GetCardProductStateStarted', 2110)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'GetCardProductStateFailed', 2121)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'GetCardProductStateEnded', 2122)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'WriteCubicLogToDbFailed', 2200)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'GetAutoloadsStarted', 2500)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'GetAutoloadsFailed', 2501)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'GetAutoloadsEnded', 2502)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'MediaRequestFileProcessorServiceStarted', 3001)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'MediaRequestFileProcessorServiceFailed', 3002)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'MediaRequestFileProcessorServiceEnded', 3003)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'ProcessRequestAndGenerateResponseFileStarted', 3004)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'ProcessRequestAndGenerateResponseFileEnded', 3005)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'ProcessRequestStarted', 3006)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'ProcessRequestEnded', 3007)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'ValidateAndProcessRequestStarted', 3008)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'ValidateAndProcessRequestFailed', 3009)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'ValidateAndProcessRequestEnded', 3010)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'MediaRequestCommonProcessRequestStarted', 3011)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'MediaRequestCommonProcessRequestEnded', 3012)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'ValidateInstitutionalUploadDataStarted', 3013)
GO
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'ValidateInstitutionalUploadDataEnded', 3014)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'MediaRequestSchedulerStarted', 3015)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'MediaRequestSchedulerFailed', 3016)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'MediaRequestSchedulerEnded', 3017)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'InitializeCardStarted', 3018)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'InitializeCardFailed', 3019)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'InitializeCardEnded', 3020)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'CheckCardStateStarted', 3021)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'CheckCardStateFailed', 3022)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'CheckCardStateEnded', 3023)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'LinkCardStarted', 3024)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'LinkCardFailed', 3025)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'LinkCardEnded', 3026)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'RegisterBenefitStarted', 3027)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'RegisterBenefitFailed', 3028)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'RegisterBenefitEnded', 3029)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'TerminateCardStarted', 3030)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'TerminateCardFailed', 3031)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'TerminateCardEnded', 3032)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'ProcessAllCubicRequestStarted', 3033)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'ProcessAllCubicRequestEnded', 3034)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'ProcessThisCubicRequestStarted', 3035)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'ProcessThisCubicRequestEnded', 3036)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'ProcessAddBenefitStarted', 3037)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'ProcessAddBenefitFailed', 3038)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'ProcessAddBenefitEnded', 3039)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'ProcessTerminateCardStarted', 3040)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'ProcessTerminateCardEnded', 3041)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'SaveMediaRequestStarted', 3042)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'SaveMediaRequestFailed', 3043)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'SaveMediaRequestEnded', 3044)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'RemoveSavedRequestStarted', 3045)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'RemoveSavedRequestEnded', 3046)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'ReceiveFcfStarted', 3047)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'ReceiveFcfFailed', 3048)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'ReceiveFcfEnded', 3049)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'ReceiveFcfEachInsitutionStarted', 3050)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'ReceiveFcfEachInsitutionFailed', 3051)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'ReceiveFcfEachInsitutionEnded', 3052)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'MoveFcfFilesStarted', 3053)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'MoveFcfFilesFailed', 3054)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'MoveFcfFilesEnded', 3055)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'PostGdRequestFileStarted', 3056)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'PostGdRequestFileFailed', 3057)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'PostGdRequestFileEnded', 3058)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'ReceiveGdFileStarted', 3059)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'ReceiveGdFileFailed', 3060)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'ReceiveGdFileEnded', 3061)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'ProcessAllFcfStarted', 3062)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'ProcessAllFcfFailed', 3063)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'ProcessAllFcfEnded', 3064)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'ProcessEachFcfStarted', 3065)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'ProcessEachFcfFailed', 3066)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'ProcessEachFcfEnded', 3067)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'DecryptFcfStarted', 3068)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'DecryptFcfFailed ', 3069)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'DecryptFcfEnded ', 3070)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'ValidateFcfXsdStarted', 3071)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'ValidateFcfXsdFailed', 3072)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'ValidateFcfXsdEnded', 3073)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'ProcessPlainFcfStarted', 3074)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'ProcessPlainFcfFailed', 3075)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'ProcessPlainFcfEnded', 3076)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'ProcessFcfFileExceptionFailed', 3077)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'ProcessFcfCubicStarted', 3078)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'ProcessFcfCubicFailed', 3079)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'ProcessFcfCubicEnded', 3080)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'GenerateFufStarted', 3081)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'GenerateFufFailed', 3082)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'GenerateFufEnded', 3083)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'GenerateFufForEachInstitutionStarted', 3084)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'GenerateFufForEachInstitutionFailed', 3085)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'GenerateFufForEachInstitutionEnded', 3086)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'PrepareFufInfoStarted', 3087)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'PrepareFufInfoFailed', 3088)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'PrepareFufInfoEnded', 3089)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'ValidateFufStarted', 3090)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'ValidateFufFailed', 3091)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'ValidateFufEnded', 3092)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'CompressFufStarted', 3093)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'CompressFufFailed', 3094)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'CompressFufEnded', 3095)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'EncryptFufStarted', 3096)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'EncryptFufFailed', 3097)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'EncryptFufEnded', 3098)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'SubmitFufStarted', 3099)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'SubmitFufFailed', 3100)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'SubmitFufEnded', 3101)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'GenerateIcfStarted', 3102)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'GenerateIcfFailed', 3103)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'GenerateIcfEnded', 3104)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'GenerateIcfForEachInstitutionStarted', 3105)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'GenerateIcfForEachInstitutionFailed', 3106)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'GenerateIcfForEachInstitutionEnded', 3107)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'PrepareIcfInfoStarted', 3108)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'PrepareIcfInfoFailed', 3109)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'PrepareIcfInfoEnded', 3110)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'ValidateIcfStarted', 3111)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'ValidateIcfFailed', 3112)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'ValidateIcfEnded', 3113)
GO
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'EncryptIcfStarted', 3114)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'EncryptIcfFailed', 3115)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'EncryptIcfEnded', 3116)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'SubmitIcfStarted', 3117)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'SubmitIcfFailed ', 3118)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'SubmitIcfEnded', 3119)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'CubicHandleTaskStarted', 3200)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'CubicTaskHandler', 3201)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'CubicHandleTaskFailed', 3202)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'CubicHandleTaskEnded', 3203)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'UpassLCLinkCardRequestedStarted', 4350)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'UpassLCLinkCardRequestedEnded', 5350)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'UpassLCLinkCardPendingStarted', 4351)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'UpassLCLinkCardPendingEnded', 5351)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'UpassLCCheckStudentExistencePendingStarted', 4352)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'UpassLCCheckStudentExistencePendingEnded', 5352)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'UpassLCAddMemberPendingStarted', 4353)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'UpassLCAddMemberPendingEnded', 5353)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'UpassLCUpdateMemberPendingStarted', 4354)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'UpassLCUpdateMemberPendingEnded', 5354)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'UpassLCRestoreCMBBenefitPendingStarted', 4355)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'UpassLCRestoreCMBBenefitPendingEnded', 5355)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'UpassLCAddCMBAutoloadPendingStarted', 4356)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'UpassLCAddCMBAutoloadPendingEnded', 5356)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'UpassLCCheckCardCVNPendingStarted', 4357)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'UpassLCCheckCardCVNPendingEnded', 5357)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'UpassLCCheckCardValidityPendingStarted', 4358)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'UpassLCCheckCardValidityPendingEnded', 5358)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'UpassLCCCheckCMBEnablementConditionsPendingStarted', 4359)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'UpassLCCCheckCMBEnablementConditionsPendingEnded', 5359)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'UpassLCCheckNMBEnablementConditionsPendingStarted', 4360)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'UpassLCCheckNMBEnablementConditionsPendingEnded', 5360)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'UpassLCRestoreElectedNMBPendingStarted', 4361)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'UpassLCRestoreElectedNMBPendingEnded', 5361)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'UpassLCRestoreOnholdNMBPendingStarted', 4362)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'UpassLCRestoreOnholdNMBPendingEnded', 5362)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'UpassLCAddNMBAutoloadPendingStarted', 4363)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'UpassLCAddNMBAutoloadPendingEnded', 5363)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'UpassLCCreateInvalidCardNotificationStarted', 4364)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'UpassLCCreateInvalidCardNotificationEnded', 5364)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'UpassLCCheckCMBEnabledPendingStarted', 4367)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'UpassLCCheckCMBEnabledPendingEnded', 5367)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'UpassLCCreateElectCMBTaskPendingStarted', 4368)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'UpassLCCreateElectCMBTaskPendingEnded', 5368)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'UpassLCCheckCardLinkedToOthersEnded', 5371)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'UpassLCCreateCardLinkedToOthersNotificationTaskPEndingEnded', 5372)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'UpassUCUnlinkCardRequestedStarted', 4380)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'UpassUCUnlinkCardRequestedEnded', 5380)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'UpassUCCheckCMBPendingEnded', 5381)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'UpassUCWaiveCMBPendingEnded', 5382)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'UpassUCAssociateToUnknownStudentCardPendingEnded', 5383)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'UpassUCCheckNMBEnabledPendingEnded', 5385)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'UpassUCWaiveNMBPendingEnded', 5386)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'UpassUCCheckCardStatePendingEnded', 5387)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'UpassUCProcessAutoLoadsPendingEnded', 5388)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'UpassUCUnlinkPendingEnded', 5389)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'UpassUCCreateCardUnlinkedNotificationTaskPendingEnded', 5390)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'UpassABBenefitEnabledStarted', 4340)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'UpassABBenefitEnabledEnded', 5340)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'UpassABUpdateMemberElectBenefitPendingEnded', 5341)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'UpassABCreateBenefitAddedNotificationPendingEnded', 5342)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'UpassABCheckCubicDatePendingEnded', 5343)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'UpassABCreateInvalidCardNotificationPendingEnded', 5344)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'UpassABFourConditionNotMetNotificationPendingEnded', 5345)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'UpassABCheckBenefitElectionHistoryPendingEnded', 5346)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'UpassABUpdateMemberRestoreOnHoldBenefitPendingEnded', 5347)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'UpassABAddAutoLoadPendingEnded', 5348)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'UpassRBWaiveBenefitRequestedStarted', 4330)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'UpassRBWaiveBenefitRequestedEnded', 5330)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'UpassRBUpdateMemberWaiveBenefitPendingEnded', 5331)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'UpassRBCheckCardValidityPendingEnded', 5332)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'UpassRBProcessAutoloadPendingEnded', 5333)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'UpassRBCreateNMBDisabledNotificationPendingEnded', 5334)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'UpassRBCreateInvalidCardNotificationPendingEnded', 5335)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'ProcessDatabasePurgeStarted', 6101)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'ProcessDatabasePurgeProcessing', 6102)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'ProcessDatabasePurgeEnded', 6103)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'EmailRequestedStarted', 7101)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'EmailRequestedEnded', 7102)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'UPassUCCheckTaskProgramForNotificationPendingStarted', 8001)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'UPassUCCheckTaskProgramForNotificationPendingEnded', 8002)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'UPassUCCheckTaskProgramForCompletionPendingStarted', 8003)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'UPassUCCheckTaskProgramForCompletionPendingEnded', 8004)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'NewCardRequestFulfilledStarted', 9303)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'NewCardRequestFulfilledEnded', 10303)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'NewCardInitializedStarted', 9304)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'NewCardInitializedEnded', 10304)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'NewCardLinkedStarted', 9305)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'NewCardLinkedEnded', 10305)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'NewCardAddBenefitPendingStarted', 9310)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'NewCardAddBenefitPendingEnded', 10310)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'NewCardAddAutoloadPendingStarted', 9311)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'NewCardAddAutoloadPendingEnded', 10311)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'NewCardUpdateMemberPendingStarted', 9313)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'NewCardUpdateMemberPendingEnded', 10313)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'NewCardBenefitAssessmentPendingStarted', 9314)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'NewCardBenefitAssessmentPendingEnded', 10314)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'NewCardAddMemberPendingStarted', 9315)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'NewCardAddMemberPendingEnded', 10315)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'TerminateCardPendingStarted', 9306)
GO
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'TerminateCardPendingEnded', 10306)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'AddBenefitPendingStarted', 9307)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'AddBenefitPendingEnded', 10307)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'ReplacementCardCheckInfoPendingStarted', 9308)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'ReplacementCardCheckInfoPendingEnded', 10308)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'ReplacementCardTerminatePendingStarted', 9309)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'ReplacementCardTerminatePendingEnded', 10309)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'SuspendCardPendingStarted', 9316)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'SuspendCardPendingEnded', 10316)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'ResumeCardPendingStarted', 9317)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'ResumeCardPendingEnd', 10317)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'ConfiscationRequestedTaskStarted', 85001)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'ConfiscationRequestedTaskEnded', 85002)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'ConfiscationHotlistPendingTaskStarted', 85011)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'ConfiscationHotlistPendingTaskEnded', 85012)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'ConfiscationCheckProgramPendingTaskStarted', 85021)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'ConfiscationCheckProgramPendingTaskEnded', 85022)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'ConfiscationGetStudentInfoPendingTaskStarted', 85031)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'ConfiscationGetStudentInfoPendingTaskEnded', 85032)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'ConfiscationUpdateStudentStatusPendingTaskStarted', 85041)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'ConfiscationUpdateStudentStatusPendingTaskEnded', 85042)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'ConfiscationCreateNotificationTaskPendingTaskStarted', 85091)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'ConfiscationCreateNotificationTaskPendingTaskEnded', 85092)
INSERT [dbo].[NCSInfo] ([OrganizationId], [InstitutionId], [ProgramId], [Active], [Name], [ShortName]) VALUES (50, N'BCIT', N'UPASS', 1, N'British Columbia Institution of Technology', N'BCIT')
INSERT [dbo].[NCSInfo] ([OrganizationId], [InstitutionId], [ProgramId], [Active], [Name], [ShortName]) VALUES (42, N'CNIB1', N'PPASS', 1, N'CNIB', N'CNIB1')
INSERT [dbo].[NCSInfo] ([OrganizationId], [InstitutionId], [ProgramId], [Active], [Name], [ShortName]) VALUES (49, N'CU', N'UPASS', 1, N'Capilano University', N'Capilano University')
INSERT [dbo].[NCSInfo] ([OrganizationId], [InstitutionId], [ProgramId], [Active], [Name], [ShortName]) VALUES (51, N'DC', N'UPASS', 1, N'Douglas College', N'Douglas College')
INSERT [dbo].[NCSInfo] ([OrganizationId], [InstitutionId], [ProgramId], [Active], [Name], [ShortName]) VALUES (52, N'ECUAD', N'UPASS', 1, N'Emily Carr University of Art + Design', N'Emily Carr University')
INSERT [dbo].[NCSInfo] ([OrganizationId], [InstitutionId], [ProgramId], [Active], [Name], [ShortName]) VALUES (53, N'KPU', N'UPASS', 1, N'Kwantlen Polytechnic University', N'Kwantlen Polytechnic')
INSERT [dbo].[NCSInfo] ([OrganizationId], [InstitutionId], [ProgramId], [Active], [Name], [ShortName]) VALUES (40, N'LC', N'UPASS', 1, N'Langara College', N'Langara College')
INSERT [dbo].[NCSInfo] ([OrganizationId], [InstitutionId], [ProgramId], [Active], [Name], [ShortName]) VALUES (43, N'MSD1', N'PPASS', 1, N'Ministry of Social Housing', N'MSD1')
INSERT [dbo].[NCSInfo] ([OrganizationId], [InstitutionId], [ProgramId], [Active], [Name], [ShortName]) VALUES (54, N'NVIT', N'UPASS', 1, N'Nicola Valley Institution of Technoloty', N'NVIT')
INSERT [dbo].[NCSInfo] ([OrganizationId], [InstitutionId], [ProgramId], [Active], [Name], [ShortName]) VALUES (75, N'SCL3', N'UPASS', 1, N'TransLink Prod Test SCL 3', N'SCL3')
INSERT [dbo].[NCSInfo] ([OrganizationId], [InstitutionId], [ProgramId], [Active], [Name], [ShortName]) VALUES (76, N'SCL4', N'UPASS', 1, N'TransLink Prod Test SCL 4', N'SCL4')
INSERT [dbo].[NCSInfo] ([OrganizationId], [InstitutionId], [ProgramId], [Active], [Name], [ShortName]) VALUES (39, N'SFU', N'UPASS', 1, N'Simon Fraser University', N'Simon Fraser University')
INSERT [dbo].[NCSInfo] ([OrganizationId], [InstitutionId], [ProgramId], [Active], [Name], [ShortName]) VALUES (74, N'TLAT1', N'PPASS', 1, N'TransLink Access Transit', N'TLAT1')
INSERT [dbo].[NCSInfo] ([OrganizationId], [InstitutionId], [ProgramId], [Active], [Name], [ShortName]) VALUES (4, N'TLC', N'PPASS', 1, N'TransLink Contractor', N'TLC')
INSERT [dbo].[NCSInfo] ([OrganizationId], [InstitutionId], [ProgramId], [Active], [Name], [ShortName]) VALUES (41, N'TLE1', N'PPASS', 1, N'TransLink Employee', N'TLE1')
INSERT [dbo].[NCSInfo] ([OrganizationId], [InstitutionId], [ProgramId], [Active], [Name], [ShortName]) VALUES (46, N'TLPR1', N'UPASS', 1, N'TransLink Prod Test PSI 1', N'TLPR1')
INSERT [dbo].[NCSInfo] ([OrganizationId], [InstitutionId], [ProgramId], [Active], [Name], [ShortName]) VALUES (38, N'UBC', N'UPASS', 1, N'University of British Columbia', N'University of BC')
INSERT [dbo].[NCSInfo] ([OrganizationId], [InstitutionId], [ProgramId], [Active], [Name], [ShortName]) VALUES (55, N'VCC', N'UPASS', 1, N'Vancouver Community College', N'Vancouver Comm. College')
