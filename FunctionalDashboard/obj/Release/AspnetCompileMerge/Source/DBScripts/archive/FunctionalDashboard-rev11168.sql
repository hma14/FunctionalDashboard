USE [UPASSDASHSTG]
GO
/****** Object:  StoredProcedure [dbo].[RetrieveEventLog]    Script Date: 2/4/2015 11:04:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[RetrieveEventLog] (@startDate Datetime, @endDate Datetime)
	
AS
BEGIN
	
	SET NOCOUNT ON;

    SELECT 
      el.ID,
      el.Source,
	  el.Category,
	  c.CategoryID,
	  e.EventName AS Event,
	  el.EventID,
      el.Level,
	  el.Computer,
      el.LoggedTime,
	  env.Environment,
      DATEPART(MM,el.LoggedTime) As Month,
      DATEPART(YYYY,el.LoggedTime) As Year,
      DATEPART(DD,el.LoggedTime) As Day,
	  el.XMLdata
     
FROM
      view_ESEventLogs el WITH (NOLOCK)
	  LEFT OUTER JOIN EventIDList e ON el.EventID = e.EventID
	  LEFT OUTER JOIN CategoryIDList c ON el.Category = c.CategoryName		
	  LEFT OUTER JOIN CPGEnvironments env ON el.Computer = env.ServerName											     
      
WHERE
      el.EventID between 1000 and 11000
	  and el.LoggedTime >= @startDate 
	  and el.LoggedTime <= @endDate
      and el.XMLData.value('(/rawData/ProcessDatetime/node())[1]', 'varchar(7400)') is not null  
	  
ORDER BY 
      el.LoggedTime Desc

END





GO
/****** Object:  StoredProcedure [dbo].[RetrieveNCSInfo]    Script Date: 2/4/2015 11:04:47 AM ******/
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
/****** Object:  StoredProcedure [dbo].[SyncNCSInfo]    Script Date: 2/4/2015 11:04:47 AM ******/
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
	--IF OBJECT_ID('dbo.NCSInfo', 'U') IS NOT NULL
	IF OBJECT_ID('dbo.temp', 'U') IS NOT NULL
	--DROP TABLE dbo.NCSInfo
	DROP TABLE dbo.temp

	SELECT ir.OrganizationId, ip.InstitutionId, ip.ProgramId, ip.Active, ir.Name, ir.ShortName
	--INTO dbo.NCSInfo
	INTO dbo.temp
	FROM [NORTON].[UPASSPRD121].[dbo].[InstitutionProgram] ip

	INNER JOIN [NORTON].[UPASSPRD121].[dbo].[InstitutionRegistry] ir ON ip.InstitutionId = ir.id
END

GO
/****** Object:  Table [dbo].[CategoryIDList]    Script Date: 2/4/2015 11:04:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CategoryIDList](
	[CategoryName] [nvarchar](255) NULL,
	[CategoryID] [float] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CPGEnvironments]    Script Date: 2/4/2015 11:04:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CPGEnvironments](
	[ServerName] [nvarchar](255) NULL,
	[Environment] [nvarchar](255) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[EventIDList]    Script Date: 2/4/2015 11:04:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EventIDList](
	[EventName] [nvarchar](255) NULL,
	[EventID] [int] NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[NCSInfo]    Script Date: 2/4/2015 11:04:47 AM ******/
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
/****** Object:  View [dbo].[view_ESEventLogs]    Script Date: 2/4/2015 11:04:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




















CREATE view [dbo].[view_ESEventLogs]
as

SELECT [eventnumber] as ID
      ,ll.[eventlog] as LogName
      ,lt.[eventtype] as Level
      ,ls.[eventsource] as Source
      ,lc.[eventcategory] as Category
      ,lm.[eventid] as EventID
      ,lco.[eventcomputer] as Computer
      ,[eventtime] as LoggedTime
	  ,CASE  
		----WHEN LEN(eventmessage) >= 7300 
		----THEN CAST(SUBSTRING(eventmessage, 1, len(eventmessage) - 40) + ' ... </ExceptionInfo></rawData>' AS XML) 
		----THEN CAST(SUBSTRING(eventmessage, 1, len(eventmessage) - 40) + ' ... </StackTrace></rawData>' AS XML)
		WHEN eventmessage not like '%</rawData>%'
		THEN CAST(SUBSTRING(eventmessage, 1, len(eventmessage)) + ' ... </ProcessErrorDescr></rawData>' AS XML)
		ELSE CAST([eventmessage] AS XML)
		END  AS XMLData
	  --,Cast([eventmessage] as XML) as XMLData
  FROM [FunctionalDashBoardData].[dbo].[ESEventlogMain] LM, [FunctionalDashBoardData].[dbo].[ESEventlogLog] LL, 
       [FunctionalDashBoardData].[dbo].[ESEventlogType] LT, [FunctionalDashBoardData].[dbo].[ESEventlogSource] LS,
       [FunctionalDashBoardData].[dbo].[ESEventlogCategory] LC , 
       [FunctionalDashBoardData].[dbo].[ESEventlogUser] LU, [FunctionalDashBoardData].[dbo].[ESEventlogComputer] LCO
	   WITH (NOLOCK)
  where lm.eventlog = ll.id
  and lm.eventType = lt.id
  and lm.eventsource = ls.id
  and lm.eventcategory = lc.id
  and lm.eventuser = lU.id
  and lm.eventcomputer = lco.id


  -- greater than 30000 are heartbeat logging, hence ignored
  and lm.eventid < 30000
  and lm.eventid >= 1000

  -- below three event IDs are filtered out because their logging format are not match to the defined for Dashboard, hence ignored
  and lm.[eventid] <> 2092
  and lm.[eventid] <> 2121
  and lm.[eventid] <> 2200
  and lm.[eventid] <> 2122
  and lm.[eventid] <> 3048
  and lm.[eventid] <> 3016











GO
INSERT [dbo].[CategoryIDList] ([CategoryName], [CategoryID]) VALUES (N'InboundFileMonitorService', 1)
INSERT [dbo].[CategoryIDList] ([CategoryName], [CategoryID]) VALUES (N'InboundFileMonitor', 2)
INSERT [dbo].[CategoryIDList] ([CategoryName], [CategoryID]) VALUES (N'OutboundFileMonitorService', 3)
INSERT [dbo].[CategoryIDList] ([CategoryName], [CategoryID]) VALUES (N'OutboundFileMonitor', 4)
INSERT [dbo].[CategoryIDList] ([CategoryName], [CategoryID]) VALUES (N'FileProcessor', 5)
INSERT [dbo].[CategoryIDList] ([CategoryName], [CategoryID]) VALUES (N'AsyncProcessorCore', 6)
INSERT [dbo].[CategoryIDList] ([CategoryName], [CategoryID]) VALUES (N'CubicProxy', 7)
INSERT [dbo].[CategoryIDList] ([CategoryName], [CategoryID]) VALUES (N'MediaRequestFileProcessorService', 8)
INSERT [dbo].[CategoryIDList] ([CategoryName], [CategoryID]) VALUES (N'CommonFileProcessor', 9)
INSERT [dbo].[CategoryIDList] ([CategoryName], [CategoryID]) VALUES (N'MediaRequestFileProcessorService', 10)
INSERT [dbo].[CategoryIDList] ([CategoryName], [CategoryID]) VALUES (N'MediaRequestCommon', 11)
INSERT [dbo].[CategoryIDList] ([CategoryName], [CategoryID]) VALUES (N'MediaRequestValidation', 12)
INSERT [dbo].[CategoryIDList] ([CategoryName], [CategoryID]) VALUES (N'MediaRequestCubic', 13)
INSERT [dbo].[CategoryIDList] ([CategoryName], [CategoryID]) VALUES (N'MediaRequestEngine', 14)
INSERT [dbo].[CategoryIDList] ([CategoryName], [CategoryID]) VALUES (N'MediaRequestGenerateFuf', 15)
INSERT [dbo].[CategoryIDList] ([CategoryName], [CategoryID]) VALUES (N'MediaRequestGenerateIcf', 16)
INSERT [dbo].[CategoryIDList] ([CategoryName], [CategoryID]) VALUES (N'MediaRequestReceiveFcf', 17)
INSERT [dbo].[CategoryIDList] ([CategoryName], [CategoryID]) VALUES (N'MediaRequestSchedulerService', 18)
INSERT [dbo].[CategoryIDList] ([CategoryName], [CategoryID]) VALUES (N'GdServiceProvider', 19)
INSERT [dbo].[CategoryIDList] ([CategoryName], [CategoryID]) VALUES (N'MediaRequestReceiveIuf', 20)
INSERT [dbo].[CategoryIDList] ([CategoryName], [CategoryID]) VALUES (N'UpassRequestFile', 21)
INSERT [dbo].[CategoryIDList] ([CategoryName], [CategoryID]) VALUES (N'UpassResponseFile', 22)
INSERT [dbo].[CategoryIDList] ([CategoryName], [CategoryID]) VALUES (N'UpassStateEngine', 23)
INSERT [dbo].[CategoryIDList] ([CategoryName], [CategoryID]) VALUES (N'PpassNewCard', 24)
INSERT [dbo].[CategoryIDList] ([CategoryName], [CategoryID]) VALUES (N'PpassReplacementCard', 25)
INSERT [dbo].[CategoryIDList] ([CategoryName], [CategoryID]) VALUES (N'PpassResumeCard', 26)
INSERT [dbo].[CategoryIDList] ([CategoryName], [CategoryID]) VALUES (N'PpassSuspendCard', 27)
INSERT [dbo].[CategoryIDList] ([CategoryName], [CategoryID]) VALUES (N'PpassTerminatedCard', 28)
INSERT [dbo].[CategoryIDList] ([CategoryName], [CategoryID]) VALUES (N'UpassLinkCardTask', 29)
INSERT [dbo].[CategoryIDList] ([CategoryName], [CategoryID]) VALUES (N'UpassUnLinkCardTask', 30)
INSERT [dbo].[CategoryIDList] ([CategoryName], [CategoryID]) VALUES (N'UpassElectBenefitTask', 31)
INSERT [dbo].[CategoryIDList] ([CategoryName], [CategoryID]) VALUES (N'UpassWaiveBenefitTask', 32)
INSERT [dbo].[CategoryIDList] ([CategoryName], [CategoryID]) VALUES (N'DatabasePurgeService', 33)
INSERT [dbo].[CategoryIDList] ([CategoryName], [CategoryID]) VALUES (N'FilePurgeService', 34)
INSERT [dbo].[CategoryIDList] ([CategoryName], [CategoryID]) VALUES (N'StoredProcExecutor', 35)
INSERT [dbo].[CategoryIDList] ([CategoryName], [CategoryID]) VALUES (N'EmailRequestedTask', 36)
INSERT [dbo].[CategoryIDList] ([CategoryName], [CategoryID]) VALUES (N'ConfiscationRequestedTask', 37)
INSERT [dbo].[CategoryIDList] ([CategoryName], [CategoryID]) VALUES (N'ConfiscationHotlistPendingTask', 38)
INSERT [dbo].[CategoryIDList] ([CategoryName], [CategoryID]) VALUES (N'ConfiscationCheckProgramPendingTask', 39)
INSERT [dbo].[CategoryIDList] ([CategoryName], [CategoryID]) VALUES (N'ConfiscationGetStudentInfoPendingTask', 40)
INSERT [dbo].[CategoryIDList] ([CategoryName], [CategoryID]) VALUES (N'ConfiscationUpdateStudentStatusPendingTask', 41)
INSERT [dbo].[CategoryIDList] ([CategoryName], [CategoryID]) VALUES (N'ConfiscationCreateNotificationTaskPendingTask', 42)
INSERT [dbo].[CategoryIDList] ([CategoryName], [CategoryID]) VALUES (N'UpassStudentCardStatus', 43)
INSERT [dbo].[CategoryIDList] ([CategoryName], [CategoryID]) VALUES (N'UpassEligibilityStatus', 44)
INSERT [dbo].[CategoryIDList] ([CategoryName], [CategoryID]) VALUES (N'UpassBenefitRequestStatus', 45)
INSERT [dbo].[CategoryIDList] ([CategoryName], [CategoryID]) VALUES (N'UpassStudentStatus', 46)
INSERT [dbo].[CategoryIDList] ([CategoryName], [CategoryID]) VALUES (N'UpassMonthlyBenefitStatus', 47)
INSERT [dbo].[CategoryIDList] ([CategoryName], [CategoryID]) VALUES (N'UserWebTask', 48)
INSERT [dbo].[CategoryIDList] ([CategoryName], [CategoryID]) VALUES (N'SyncUtility', 49)
INSERT [dbo].[CategoryIDList] ([CategoryName], [CategoryID]) VALUES (N'UpassWebServices', 50)
INSERT [dbo].[CPGEnvironments] ([ServerName], [Environment]) VALUES (N'COMPCONFS01', N'Staging')
INSERT [dbo].[CPGEnvironments] ([ServerName], [Environment]) VALUES (N'COMPCONFT01', N'IntQA')
INSERT [dbo].[CPGEnvironments] ([ServerName], [Environment]) VALUES (N'UPASAPP01', N'Production')
INSERT [dbo].[CPGEnvironments] ([ServerName], [Environment]) VALUES (N'UPASAPP02', N'Production')
INSERT [dbo].[CPGEnvironments] ([ServerName], [Environment]) VALUES (N'UPASAPP03', N'Production')
INSERT [dbo].[CPGEnvironments] ([ServerName], [Environment]) VALUES (N'UPASAPP04', N'Production')
INSERT [dbo].[CPGEnvironments] ([ServerName], [Environment]) VALUES (N'UPASAPP05', N'Production')
INSERT [dbo].[CPGEnvironments] ([ServerName], [Environment]) VALUES (N'UPASAPS01', N'Staging')
INSERT [dbo].[CPGEnvironments] ([ServerName], [Environment]) VALUES (N'UPASAPS02', N'Staging')
INSERT [dbo].[CPGEnvironments] ([ServerName], [Environment]) VALUES (N'UPASAPS03', N'Staging')
INSERT [dbo].[CPGEnvironments] ([ServerName], [Environment]) VALUES (N'UPASAPS04', N'Staging')
INSERT [dbo].[CPGEnvironments] ([ServerName], [Environment]) VALUES (N'UPASAPS05', N'Staging')
INSERT [dbo].[CPGEnvironments] ([ServerName], [Environment]) VALUES (N'UPASAPT01', N'Development')
INSERT [dbo].[CPGEnvironments] ([ServerName], [Environment]) VALUES (N'UPASAPT02', N'ExtQA')
INSERT [dbo].[CPGEnvironments] ([ServerName], [Environment]) VALUES (N'UPASAPT03', N'IntQA')
INSERT [dbo].[CPGEnvironments] ([ServerName], [Environment]) VALUES (N'UPASAPT04', N'IntQA')
INSERT [dbo].[CPGEnvironments] ([ServerName], [Environment]) VALUES (N'UPASAPT05', N'ExtQA')
INSERT [dbo].[CPGEnvironments] ([ServerName], [Environment]) VALUES (N'UPASAPT06', N'ExtQA')
INSERT [dbo].[CPGEnvironments] ([ServerName], [Environment]) VALUES (N'UPASAPT07', N'Development')
INSERT [dbo].[CPGEnvironments] ([ServerName], [Environment]) VALUES (N'UPASAPT08', N'Development')
INSERT [dbo].[CPGEnvironments] ([ServerName], [Environment]) VALUES (N'UPASSBCSTG1', N'Staging')
INSERT [dbo].[CPGEnvironments] ([ServerName], [Environment]) VALUES (N'UPASSBCSTG2', N'Staging')
INSERT [dbo].[CPGEnvironments] ([ServerName], [Environment]) VALUES (N'UPASWEB03', N'Production')
INSERT [dbo].[CPGEnvironments] ([ServerName], [Environment]) VALUES (N'UPASWEB04', N'Production')
INSERT [dbo].[CPGEnvironments] ([ServerName], [Environment]) VALUES (N'UPASWEBP01', N'Production')
INSERT [dbo].[CPGEnvironments] ([ServerName], [Environment]) VALUES (N'UPASWEBP02', N'Production')
INSERT [dbo].[CPGEnvironments] ([ServerName], [Environment]) VALUES (N'UPASWEBS01', N'Staging')
INSERT [dbo].[CPGEnvironments] ([ServerName], [Environment]) VALUES (N'UPASWEBS02', N'Staging')
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
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'UpassRBWaiveBenefitRequestedStarted', 4330)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'UpassABBenefitEnabledStarted', 4340)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'UpassLCLinkCardRequestedStarted', 4350)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'UpassLCLinkCardPendingStarted', 4351)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'UpassLCCheckStudentExistencePendingStarted', 4352)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'UpassLCAddMemberPendingStarted', 4353)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'UpassLCUpdateMemberPendingStarted', 4354)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'UpassLCRestoreCMBBenefitPendingStarted', 4355)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'UpassLCAddCMBAutoloadPendingStarted', 4356)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'UpassLCCheckCardCVNPendingStarted', 4357)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'UpassLCCheckCardValidityPendingStarted', 4358)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'UpassLCCCheckCMBEnablementConditionsPendingStarted', 4359)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'UpassLCCheckNMBEnablementConditionsPendingStarted', 4360)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'UpassLCRestoreElectedNMBPendingStarted', 4361)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'UpassLCRestoreOnholdNMBPendingStarted', 4362)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'UpassLCAddNMBAutoloadPendingStarted', 4363)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'UpassLCCreateInvalidCardNotificationStarted', 4364)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'UpassLCCheckCMBEnabledPendingStarted', 4367)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'UpassLCCreateElectCMBTaskPendingStarted', 4368)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'UpassUCUnlinkCardRequestedStarted', 4380)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'UpassStudentCardStatusStarted', 4400)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'UpassEligibilityStatusStarted', 4410)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'UpassBenefitRequestStatusStarted', 4420)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'UpassStudentStatusStarted', 4430)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'UpassMonthlyBenefitStatusStarted', 4450)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'UpassRBWaiveBenefitRequestedEnded', 5330)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'UpassRBUpdateMemberWaiveBenefitPendingEnded', 5331)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'UpassRBCheckCardValidityPendingEnded', 5332)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'UpassRBProcessAutoloadPendingEnded', 5333)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'UpassRBCreateNMBDisabledNotificationPendingEnded', 5334)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'UpassRBCreateInvalidCardNotificationPendingEnded', 5335)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'UpassABBenefitEnabledEnded', 5340)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'UpassABUpdateMemberElectBenefitPendingEnded', 5341)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'UpassABCreateBenefitAddedNotificationPendingEnded', 5342)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'UpassABCheckCubicDatePendingEnded', 5343)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'UpassABCreateInvalidCardNotificationPendingEnded', 5344)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'UpassABFourConditionNotMetNotificationPendingEnded', 5345)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'UpassABCheckBenefitElectionHistoryPendingEnded', 5346)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'UpassABUpdateMemberRestoreOnHoldBenefitPendingEnded', 5347)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'UpassABAddAutoLoadPendingEnded', 5348)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'UpassLCLinkCardRequestedEnded', 5350)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'UpassLCLinkCardPendingEnded', 5351)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'UpassLCCheckStudentExistencePendingEnded', 5352)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'UpassLCAddMemberPendingEnded', 5353)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'UpassLCUpdateMemberPendingEnded', 5354)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'UpassLCRestoreCMBBenefitPendingEnded', 5355)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'UpassLCAddCMBAutoloadPendingEnded', 5356)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'UpassLCCheckCardCVNPendingEnded', 5357)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'UpassLCCheckCardValidityPendingEnded', 5358)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'UpassLCCCheckCMBEnablementConditionsPendingEnded', 5359)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'UpassLCCheckNMBEnablementConditionsPendingEnded', 5360)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'UpassLCRestoreElectedNMBPendingEnded', 5361)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'UpassLCRestoreOnholdNMBPendingEnded', 5362)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'UpassLCAddNMBAutoloadPendingEnded', 5363)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'UpassLCCreateInvalidCardNotificationEnded', 5364)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'UpassLCCheckCMBEnabledPendingEnded', 5367)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'UpassLCCreateElectCMBTaskPendingEnded', 5368)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'UpassLCCheckCardLinkedToOthersEnded', 5371)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'UpassLCCreateCardLinkedToOthersNotificationTaskPEndingEnded', 5372)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'UPassLCUpdateUPassTaskStatePendingEnded', 5373)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'UPassLCCreateCMBElectedNotificationTaskPendingEnded', 5374)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'UPassLCCreateNMBElectedNotificationTaskPendingEnded', 5375)
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
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'UpassUCUnlinkCardRequestedStartedSwitchFromLinkCard', 5391)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'UpassUCUnlinkCardRequestedEndedSwitchToLinkCard', 5392)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'UpassStudentCardStatusEnded', 5400)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'UpassSCSLinkPendingEnded', 5402)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'UpassSCSLinkedEnded', 5403)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'UpassSCSUnlinkPendingEnded', 5404)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'UpassEligibilityStatusEnded', 5410)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'UpassESEligibleEnded', 5412)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'UpassBenefitRequestStatusEnded', 5420)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'UpassBRSRequestedEnded', 5422)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'UpassStudentStatusEnded', 5430)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'UpassMonthlyBenefitStatusEnded', 5450)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'UpassMBSCubicElectBenefitPendingEnded', 5451)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'UpassMBSElectedEnded', 5452)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'UpassMBSCubicWaiveBenefitPendingEnded', 5453)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'UPassWSAssignCard', 5500)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'UPassWSDeassignCard', 5501)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'UPassWSRegisterBenefit', 5502)
GO
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'UPassWSUnregisterBenefit', 5503)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'UPassWSActiveCard', 5504)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'UPassWSDeactivateCard', 5505)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'UPassWSGetEligibilityStatus', 5506)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'UPassWSGetBenefitStatus', 5507)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'UPassWSGetStudentSummaryInfo', 5508)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'UPassWSGetStudentSimpleInfo', 5509)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'UPassWSGetReminderSummaryInfo', 5510)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'UPassWSSearch', 5511)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'UPassWSSearchOtherPsiCardLinked', 5512)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'UPassWSSetEligiblity', 5513)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'UPassWSUpdateTsid', 5514)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'UPassWSSetEmail', 5515)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'UPassWSSetPhoneNumber', 5516)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'UPassWSConfirmEmail', 5517)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'UPassWSConfirmPhoneNumber', 5518)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'UPassWSSetReminder', 5519)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'UPassWSGetCurrentDate', 5520)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'UPassWSGetRegistrationDay', 5521)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'UPassWSGetProductStatus', 5522)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'UPassWSGetWhiteListMode', 5523)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'UPassWSGetStudentNotificationSetting', 5524)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'UPassWSSaveStudentNotificationSetting', 5525)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'UPassWSResendConfirmationEmail', 5526)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'UPassWSValidateCcsnWithCvn', 5527)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'UPassWSAdminValidateCcsnWithCvn', 5528)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'UPassWSGetStudentStatusHistory', 5529)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'UPassWSReinstateStudentAccount', 5530)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'UPassWSGetLinkCardOption', 5531)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'UPassWSGetPassPrograms', 5532)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'UPassWSGetStudentCardStatus', 5533)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'UPassWSGetStudentAccountStatus', 5534)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'UPassWSGetStudentStatusType', 5535)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'UPassWSGetCompassCardStatus', 5536)
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
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'NewCardInitializedStarted', 9304)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'NewCardLinkedStarted', 9305)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'TerminateCardPendingStarted', 9306)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'AddBenefitPendingStarted', 9307)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'ReplacementCardCheckInfoPendingStarted', 9308)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'ReplacementCardTerminatePendingStarted', 9309)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'NewCardAddBenefitPendingStarted', 9310)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'NewCardAddAutoloadPendingStarted', 9311)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'NewCardUpdateMemberPendingStarted', 9313)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'NewCardBenefitAssessmentPendingStarted', 9314)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'NewCardAddMemberPendingStarted', 9315)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'SuspendCardPendingStarted', 9316)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'ResumeCardPendingStarted', 9317)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'NewCardRequestFulfilledEnded', 10303)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'NewCardInitializedEnded', 10304)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'NewCardLinkedEnded', 10305)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'TerminateCardPendingEnded', 10306)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'AddBenefitPendingEnded', 10307)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'ReplacementCardCheckInfoPendingEnded', 10308)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'ReplacementCardTerminatePendingEnded', 10309)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'NewCardAddBenefitPendingEnded', 10310)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'NewCardAddAutoloadPendingEnded', 10311)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'NewCardUpdateMemberPendingEnded', 10313)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'NewCardBenefitAssessmentPendingEnded', 10314)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'NewCardAddMemberPendingEnded', 10315)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'SuspendCardPendingEnded', 10316)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'ResumeCardPendingEnd', 10317)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'UserLogIn', 11000)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'UserLogOut', 11001)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'ExemptionCheckRequested', 11010)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'SyncUtilityStart', 12001)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'SyncUtilityEnded', 12002)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'SyncUtilityAddBenefitEnded', 12010)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'SyncUtilityChangeBenefitNameEnded', 12020)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'SyncUtilityChangeBenefitProductEnded', 12030)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'SyncUtilityDeactivateBenefitEnded', 12040)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'SyncUtilityReactivateBenefitEnded', 12050)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'SyncUtilityDeleteBenefitEnded', 12060)
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
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'UPassUCUpdateUPassTaskStatePendingStarted', 5393)
INSERT [dbo].[EventIDList] ([EventName], [EventID]) VALUES (N'UPassUCUpdateUPassTaskStatePendingEnded', 5394)
INSERT [dbo].[NCSInfo] ([OrganizationId], [InstitutionId], [ProgramId], [Active], [Name], [ShortName]) VALUES (50, N'BCIT', N'UPASS', 1, N'British Columbia Institution of Technology', N'BCIT')
INSERT [dbo].[NCSInfo] ([OrganizationId], [InstitutionId], [ProgramId], [Active], [Name], [ShortName]) VALUES (42, N'CNIB1', N'PPASS', 1, N'CNIB', N'CNIB1')
INSERT [dbo].[NCSInfo] ([OrganizationId], [InstitutionId], [ProgramId], [Active], [Name], [ShortName]) VALUES (49, N'CU', N'UPASS', 1, N'Capilano University', N'Capilano University')
INSERT [dbo].[NCSInfo] ([OrganizationId], [InstitutionId], [ProgramId], [Active], [Name], [ShortName]) VALUES (51, N'DC', N'UPASS', 1, N'Douglas College', N'Douglas College')
INSERT [dbo].[NCSInfo] ([OrganizationId], [InstitutionId], [ProgramId], [Active], [Name], [ShortName]) VALUES (52, N'ECUAD', N'UPASS', 1, N'Emily Carr University of Art + Design', N'Emily Carr University')
INSERT [dbo].[NCSInfo] ([OrganizationId], [InstitutionId], [ProgramId], [Active], [Name], [ShortName]) VALUES (53, N'KPU', N'UPASS', 1, N'Kwantlen Polytechnic University', N'Kwantlen Polytechnic')
INSERT [dbo].[NCSInfo] ([OrganizationId], [InstitutionId], [ProgramId], [Active], [Name], [ShortName]) VALUES (40, N'LC', N'UPASS', 1, N'Langara College', N'Langara College')
INSERT [dbo].[NCSInfo] ([OrganizationId], [InstitutionId], [ProgramId], [Active], [Name], [ShortName]) VALUES (43, N'MSD1', N'PPASS', 1, N'Ministry of Social Housing', N'MSD1')
INSERT [dbo].[NCSInfo] ([OrganizationId], [InstitutionId], [ProgramId], [Active], [Name], [ShortName]) VALUES (54, N'NVIT', N'UPASS', 1, N'Nicola Valley Institution of Technology', N'NVIT')
INSERT [dbo].[NCSInfo] ([OrganizationId], [InstitutionId], [ProgramId], [Active], [Name], [ShortName]) VALUES (75, N'SCL3', N'UPASS', 1, N'TransLink Prod Test SCL 3', N'SCL3')
INSERT [dbo].[NCSInfo] ([OrganizationId], [InstitutionId], [ProgramId], [Active], [Name], [ShortName]) VALUES (76, N'SCL4', N'UPASS', 1, N'TransLink Prod Test SCL 4', N'SCL4')
INSERT [dbo].[NCSInfo] ([OrganizationId], [InstitutionId], [ProgramId], [Active], [Name], [ShortName]) VALUES (39, N'SFU', N'UPASS', 1, N'Simon Fraser University', N'Simon Fraser University')
INSERT [dbo].[NCSInfo] ([OrganizationId], [InstitutionId], [ProgramId], [Active], [Name], [ShortName]) VALUES (74, N'TLAT1', N'PPASS', 1, N'TransLink Access Transit', N'TLAT1')
INSERT [dbo].[NCSInfo] ([OrganizationId], [InstitutionId], [ProgramId], [Active], [Name], [ShortName]) VALUES (4, N'TLC', N'PPASS', 1, N'TransLink Contractor', N'TLC')
INSERT [dbo].[NCSInfo] ([OrganizationId], [InstitutionId], [ProgramId], [Active], [Name], [ShortName]) VALUES (41, N'TLE1', N'PPASS', 1, N'TransLink Employee', N'TLE1')
INSERT [dbo].[NCSInfo] ([OrganizationId], [InstitutionId], [ProgramId], [Active], [Name], [ShortName]) VALUES (46, N'TLPR1', N'UPASS', 1, N'TransLink Prod Test PSI 1', N'TLPR1')
INSERT [dbo].[NCSInfo] ([OrganizationId], [InstitutionId], [ProgramId], [Active], [Name], [ShortName]) VALUES (38, N'UBC', N'UPASS', 1, N'University of British Columbia', N'University of BC')
INSERT [dbo].[NCSInfo] ([OrganizationId], [InstitutionId], [ProgramId], [Active], [Name], [ShortName]) VALUES (55, N'VCC', N'UPASS', 1, N'Vancouver Community College', N'Vancouver Comm. College')
INSERT [dbo].[NCSInfo] ([OrganizationId], [InstitutionId], [ProgramId], [Active], [Name], [ShortName]) VALUES (16, N'TLDV1', N'PPASS', 1, N'Translink DV1', N'TLDV1')
INSERT [dbo].[NCSInfo] ([OrganizationId], [InstitutionId], [ProgramId], [Active], [Name], [ShortName]) VALUES (17, N'TLDV2', N'PPASS', 1, N'Translink DV2', N'TLDV2')
INSERT [dbo].[NCSInfo] ([OrganizationId], [InstitutionId], [ProgramId], [Active], [Name], [ShortName]) VALUES (185, N'HHQA1', N'UPASS', 1, N'HHQA1', N'HHQA1')
INSERT [dbo].[NCSInfo] ([OrganizationId], [InstitutionId], [ProgramId], [Active], [Name], [ShortName]) VALUES (186, N'HHQA2', N'UPASS', 1, N'HHQA2', N'HHQA2')
INSERT [dbo].[NCSInfo] ([OrganizationId], [InstitutionId], [ProgramId], [Active], [Name], [ShortName]) VALUES (66, N'TLE2', N'PPASS', 0, N'TransLink Employee', N'TLE2')
INSERT [dbo].[NCSInfo] ([OrganizationId], [InstitutionId], [ProgramId], [Active], [Name], [ShortName]) VALUES (49, N'TLQA1', N'UPASS', 1, N'TLQA1', N'TLQA1')
INSERT [dbo].[NCSInfo] ([OrganizationId], [InstitutionId], [ProgramId], [Active], [Name], [ShortName]) VALUES (50, N'TLQA2', N'UPASS', 1, N'TLQA2', N'TLQA2')
INSERT [dbo].[NCSInfo] ([OrganizationId], [InstitutionId], [ProgramId], [Active], [Name], [ShortName]) VALUES (66, N'TLQA3', N'PPASS', 0, N'TLQA3', N'TLQA3')
INSERT [dbo].[NCSInfo] ([OrganizationId], [InstitutionId], [ProgramId], [Active], [Name], [ShortName]) VALUES (66, N'TLQA3', N'UPASS', 1, N'TLQA3', N'TLQA3')
INSERT [dbo].[NCSInfo] ([OrganizationId], [InstitutionId], [ProgramId], [Active], [Name], [ShortName]) VALUES (49, N'TLQA4', N'PPASS', 0, N'TLQA4', N'TLQA4')
INSERT [dbo].[NCSInfo] ([OrganizationId], [InstitutionId], [ProgramId], [Active], [Name], [ShortName]) VALUES (49, N'TLQA4', N'UPASS', 0, N'TLQA4', N'TLQA4')
INSERT [dbo].[NCSInfo] ([OrganizationId], [InstitutionId], [ProgramId], [Active], [Name], [ShortName]) VALUES (54, N'TLQA5', N'PPASS', 0, N'TLQA5', N'TLQA5')
INSERT [dbo].[NCSInfo] ([OrganizationId], [InstitutionId], [ProgramId], [Active], [Name], [ShortName]) VALUES (55, N'TLQA6', N'PPASS', 0, N'TLQA6', N'TLQA6')
INSERT [dbo].[NCSInfo] ([OrganizationId], [InstitutionId], [ProgramId], [Active], [Name], [ShortName]) VALUES (99, N'TLST1', N'PPASS', 0, N'TLST1', N'TLST1')
INSERT [dbo].[NCSInfo] ([OrganizationId], [InstitutionId], [ProgramId], [Active], [Name], [ShortName]) VALUES (100, N'TLST1', N'UPASS', 0, N'TLST1', N'TLST1')
INSERT [dbo].[NCSInfo] ([OrganizationId], [InstitutionId], [ProgramId], [Active], [Name], [ShortName]) VALUES (101, N'TLST2', N'PPASS', 0, N'TLST2', N'TLST2')
INSERT [dbo].[NCSInfo] ([OrganizationId], [InstitutionId], [ProgramId], [Active], [Name], [ShortName]) VALUES (107, N'SCL1', N'UPASS', 1, N'TransLink Prod Test SCL 1', N'SCL1')
INSERT [dbo].[NCSInfo] ([OrganizationId], [InstitutionId], [ProgramId], [Active], [Name], [ShortName]) VALUES (4, N'TLC1', N'PPASS', 0, N'TransLink Contractor', N'TLC1')
INSERT [dbo].[NCSInfo] ([OrganizationId], [InstitutionId], [ProgramId], [Active], [Name], [ShortName]) VALUES (99, N'POC', N'UPASS', 0, N'POC for Luca', N'POC')
INSERT [dbo].[NCSInfo] ([OrganizationId], [InstitutionId], [ProgramId], [Active], [Name], [ShortName]) VALUES (4, N'TLC1', N'PPASS', 0, N'TransLink Contractor', N'TLC1')
INSERT [dbo].[NCSInfo] ([OrganizationId], [InstitutionId], [ProgramId], [Active], [Name], [ShortName]) VALUES (108, N'SCL2', N'UPASS', 1, N'TransLink Prod Test SCL 2', N'SCL2')
