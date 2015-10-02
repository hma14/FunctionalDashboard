CREATE TABLE [dbo].[ESEventlogMain] (
    [eventnumber]   BIGINT         NULL,
    [eventlog]      INT            NULL,
    [eventtype]     INT            NULL,
    [eventsource]   INT            NULL,
    [eventcategory] INT            NULL,
    [eventid]       INT            NULL,
    [eventuser]     INT            NULL,
    [eventcomputer] INT            NULL,
    [eventtime]     DATETIME       NULL,
    [eventmessage]  VARCHAR (7400) NULL,
    [eventdata]     INT            NULL,
    [groupname]     INT            NULL,
    [filtername]    INT            NULL,
    [acknowledged]  INT            NULL,
    [ack_required]  INT            NULL
);


GO
CREATE CLUSTERED INDEX [IDX_ES_ESEventlogMain_EventTime]
    ON [dbo].[ESEventlogMain]([eventtime] ASC) WITH (FILLFACTOR = 80);


GO
CREATE NONCLUSTERED INDEX [IDX_ESEventlogMain_eventcategory]
    ON [dbo].[ESEventlogMain]([eventcategory] ASC);


GO
CREATE NONCLUSTERED INDEX [IDX_ESEventlogMain_eventcomputer]
    ON [dbo].[ESEventlogMain]([eventcomputer] ASC);


GO
CREATE NONCLUSTERED INDEX [IDX_ESEventlogMain_eventid]
    ON [dbo].[ESEventlogMain]([eventid] ASC);


GO
CREATE NONCLUSTERED INDEX [IDX_ESEventlogMain_eventlog]
    ON [dbo].[ESEventlogMain]([eventlog] ASC);


GO
CREATE NONCLUSTERED INDEX [IDX_ESEventlogMain_eventsource]
    ON [dbo].[ESEventlogMain]([eventsource] ASC);


GO
CREATE NONCLUSTERED INDEX [IDX_ESEventlogMain_eventtime_desc]
    ON [dbo].[ESEventlogMain]([eventtime] DESC);


GO
CREATE NONCLUSTERED INDEX [IDX_ESEventlogMain_eventtype]
    ON [dbo].[ESEventlogMain]([eventtype] ASC);


GO
CREATE NONCLUSTERED INDEX [IDX_ESEventlogMain_eventuser]
    ON [dbo].[ESEventlogMain]([eventuser] ASC);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IDX_ESEventlogMain_RecordDetail]
    ON [dbo].[ESEventlogMain]([eventnumber] ASC, [eventid] ASC, [eventlog] ASC, [eventsource] ASC, [eventcomputer] ASC) WITH (IGNORE_DUP_KEY = ON);


GO


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