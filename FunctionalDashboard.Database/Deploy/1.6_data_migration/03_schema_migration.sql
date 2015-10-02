--Jun Tang: 03_schema_migration

drop table [dbo].[CategoryIDList];
go

-- jtang: store catelog ids used in all recorded event logs
CREATE TABLE [dbo].[CategoryIDList] (
    [CategoryID]   INT     NOT NULL,
	[CategoryName] VARCHAR(255) NULL, 
    CONSTRAINT [PK_CategoryIDList] PRIMARY KEY ([CategoryID])
);


GO

CREATE NONCLUSTERED INDEX [IDX_CategoryIDList_CategoryName] ON [dbo].[CategoryIDList]
(
	[CategoryName] ASC
)
GO


DROP TABLE [dbo].[EventIDList];
go

CREATE TABLE [dbo].[EventIDList] (
    [EventID]   INT            NOT NULL, 
	[EventName] VARCHAR (255) NULL,
    CONSTRAINT [PK_EventIDList] PRIMARY KEY ([EventID])
);

go

--
-- jtang: Store eventlog records extracted from ESEventLogMain for FD application use
--
CREATE TABLE [dbo].[TL_EventLog] (
    [ID] BIGINT        IDENTITY (1, 1) NOT NULL,
    [SourceLogID]            BIGINT        NOT NULL,
    [LogName]       VARCHAR (64)  NULL,
    [Level]         VARCHAR (32)  NULL,
    [Source]        VARCHAR (196) NULL,
    [Category]      VARCHAR (196) NULL,
    [EventID]       INT           NULL,
    [Computer]      VARCHAR (255) NOT NULL,
    [LoggedTime]    DATETIME      NOT NULL,
    [ProgramID]       VARCHAR(10)           NULL,
    [InstitutionID] VARCHAR(10) NULL, 
    [UploadFileName] VARCHAR(900) NULL, 
    [FileStatus] VARCHAR(10) NULL, 
    [RequestTxID] VARCHAR(40) NULL, 
    [GUID] VARCHAR(36) NULL, 
    [TaskID] INT NULL, 
    [StateID] INT NULL, 
    [UniqueParticipantId] VARCHAR(60) NULL, 
    [CardSerialNumber] VARCHAR(20) NULL, 
    [ExistingCardSN] VARCHAR(20) NULL, 
    [Action] VARCHAR(2) NULL, 
    [ReasonCode] VARCHAR(2) NULL, 
    [Benefit] VARCHAR(50) NULL, 
    [CardTypeCode] VARCHAR(10) NULL, 
    [SuccessFailureCode] VARCHAR(10) NULL, 
    [SuccessFailureDescr] VARCHAR(128) NULL, 
    [ActionExecuted] VARCHAR(20) NULL, 
    [TSID] VARCHAR(12) NULL, 
    [Elig] VARCHAR(10) NULL, 
    [EligDate] VARCHAR(20) NULL, 
    [Rval] VARCHAR(3) NULL, 
    [Rext] VARCHAR(5) NULL, 
    [BenefitID] INT NULL, 
    [BenefitProductID] BIGINT NULL, 
    [BenefitMonth] INT NULL, 
    [BenefitYear] INT NULL, 
    [URI] VARCHAR(1000) NULL, 
    [URIType] VARCHAR(50) NULL, 
    [ProcessDatetime] DATETIME NOT NULL, 
    [ProcessErrorID] VARCHAR(10) NULL, 
    XmlData xml
    CONSTRAINT [PK_TL_EventLog] PRIMARY KEY CLUSTERED ([ID] ASC)
);


GO

CREATE NONCLUSTERED INDEX [IDX_TL_EventLog_Loggedtime] ON [dbo].[TL_EventLog]
(
	[LoggedTime] ASC
)

GO

-- temp table for 1.6 release migration
create table dbo.tm_migration_16 (started datetime, ended datetime, records int, doneAt datetime);
GO

--
-- jtang: move data from ESEventlogMain to TL_EventLog
--
CREATE TRIGGER [dbo].[TL_Trg_ESEventlogMain_Ins] ON [dbo].[ESEventlogMain]
AFTER INSERT
AS
BEGIN
	DECLARE @xmldata as xml;
	DECLARE @procDatetime as datetime;

	select @xmldata = CAST ([eventmessage] AS XML) from inserted;
	set @procDatetime = @xmldata.value('(/rawData/ProcessDatetime/node())[1]','datetime');

	if (@procDatetime is not null)
	begin
	set @procDatetime = (Select DATEADD(MILLISECOND,DATEDIFF(MILLISECOND,getutcdate(),GETDATE()), @procDatetime));
	INSERT INTO TL_EventLog (SourceLogID, LogName, [Level], [Source], Category, EventId, Computer, LoggedTime
			,[ProgramID]
			,[InstitutionID]
			,[UploadFileName]
			,[FileStatus]
			,[RequestTxID]
			,[GUID]
			,[TaskID]
			,[StateID]
			,[UniqueParticipantId]
			,[CardSerialNumber]
			,[ExistingCardSN]
			,[Action]
			,[ReasonCode]
			,[Benefit]
			,[CardTypeCode]
			,[SuccessFailureCode]
			,[SuccessFailureDescr]
			,[ActionExecuted]
			,[TSID]
			,[Elig]
			,[EligDate]
			,[Rval]
			,[Rext]
			,[BenefitID]
			,[BenefitProductID]
			,[BenefitMonth]
			,[BenefitYear]
			,[URI]
			,[URIType]
			,[ProcessDatetime]
			,[ProcessErrorID]
			,[XmlData])
	SELECT [eventnumber] as SourceLogID
			,ll.[eventlog] as LogName
			,lt.[eventtype] as [Level]
			,ls.[eventsource] as [Source]
			,lc.[eventcategory] as Category
			,lm.[eventid] as EventID
			,lco.[eventcomputer] as Computer
			,[eventtime] as LoggedTime
			,@xmldata.value('(/rawData/ProgramID/node())[1]','nvarchar(10)') as ProgramID
			,@xmldata.value('(/rawData/InstitutionID/node())[1]','nvarchar(10)') as InstitutionID
			,@xmldata.value('(/rawData/UploadFileName/node())[1]','nvarchar(900)') as UploadFileName
			,@xmldata.value('(/rawData/FileStatus/node())[1]','nvarchar(10)') as FileStatus
			,@xmldata.value('(/rawData/RequestTxID/node())[1]','nvarchar(40)') as RequestTxID
			,@xmldata.value('(/rawData/GUID/node())[1]','nvarchar(36)') as [GUID]
			,@xmldata.value('(/rawData/TaskID/node())[1]','int') as TaskID
			,@xmldata.value('(/rawData/StateID/node())[1]','int') as StateID
			,@xmldata.value('(/rawData/UniqueParticipantId/node())[1]','nvarchar(60)') as UniqueParticipantId
			,@xmldata.value('(/rawData/CardSerialNumber/node())[1]','nvarchar(20)') as CardSerialNumber
			,@xmldata.value('(/rawData/ExistingCardSN/node())[1]','nvarchar(20)') as ExistingCardSN
			,@xmldata.value('(/rawData/Action/node())[1]','nvarchar(2)') as [Action]
			,@xmldata.value('(/rawData/ReasonCode/node())[1]','nvarchar(2)') as ReasonCode
			,@xmldata.value('(/rawData/Benefit/node())[1]','nvarchar(50)') as Benefit
			,@xmldata.value('(/rawData/CardTypeCode/node())[1]','nvarchar(10)') as CardTypeCode
			,@xmldata.value('(/rawData/SuccessFailureCode/node())[1]','nvarchar(10)') as SuccessFailureCode
			,@xmldata.value('(/rawData/SuccessFailureDescr/node())[1]','nvarchar(128)') as SuccessFailureDescr
			,@xmldata.value('(/rawData/ActionExecuted/node())[1]','nvarchar(20)') as ActionExecuted
			,@xmldata.value('(/rawData/TSID/node())[1]','nvarchar(12)') as TSID
			,@xmldata.value('(/rawData/Elig/node())[1]','nvarchar(10)') as Elig
			,@xmldata.value('(/rawData/EligDate/node())[1]','nvarchar(20)') as EligDate
			,@xmldata.value('(/rawData/Rval/node())[1]','nvarchar(3)') as Rval
			,@xmldata.value('(/rawData/Rext/node())[1]','nvarchar(5)') as Rext
			,@xmldata.value('(/rawData/BenefitID/node())[1]','int') as BenefitID
			,@xmldata.value('(/rawData/BenefitProductID/node())[1]','bigint') as BenefitProductID
			,@xmldata.value('(/rawData/BenefitMonth/node())[1]','int') as BenefitMonth
			,@xmldata.value('(/rawData/BenefitYear/node())[1]','int') as BenefitYear
			,@xmldata.value('(/rawData/URI/node())[1]','nvarchar(1000)') as URI
			,@xmldata.value('(/rawData/URIType/node())[1]','nvarchar(50)') as URIType
			,@procDatetime as ProcessDatetime
			,@xmldata.value('(/rawData/ProcessErrorID/node())[1]','nvarchar(50)') as ProcessErrorID
			,@xmldata

	FROM inserted LM, 
		 [dbo].[ESEventlogLog] LL, 
		 [dbo].[ESEventlogType] LT, 
		 [dbo].[ESEventlogSource] LS,
		 [dbo].[ESEventlogCategory] LC , 
		 [dbo].[ESEventlogUser] LU, 
		 [dbo].[ESEventlogComputer] LCO
		WITH (NOLOCK)
	where lm.eventlog = ll.id
	and lm.eventType = lt.id
	and lm.eventsource = ls.id
	and lm.eventcategory = lc.id
	and lm.eventuser = lU.id
	and lm.eventcomputer = lco.id
	-- greater than 30000 are heartbeat logging, hence ignored
	and lm.eventid < 30000
	-- below three event IDs are filtered out because their logging format are not match to the defined for Dashboard, hence ignored
	and lm.[eventid] <> 48
	and lm.[eventid] <> 2091  
	and lm.[eventid] <> 2092
	and lm.[eventid] <> 2200
	and lm.[eventid] <> 2122
	and lm.[eventid] <> 3048
	and lm.[eventid] <> 3016
	and lm.[eventid] <> 2101

	end
END--TRIGGER

GO
