-- jtang: 07_data_migration

declare @maxdt datetime, @mindt datetime, @nxtdt datetime;
declare @txName varchar(2), @DateInterval int = -6;

select @maxdt = max(LoggedTime), @mindt = min(LoggedTime) from TL_StgESEventLogs;
set @maxdt = dateadd(mi, 1, @maxdt);

select @txName = 'tx_log_migration';
while @mindt <= @maxdt
begin
	set @nxtdt = dateadd(hh, @DateInterval, @maxdt);
	begin transaction @txName
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
	SELECT  ID
			,LogName
			,[Level]
			,[Source]
			,Category
			,EventID
			,Computer
			,LoggedTime
			,xmldata.value('(/rawData/ProgramID/node())[1]','nvarchar(10)') as ProgramID
			,xmldata.value('(/rawData/InstitutionID/node())[1]','nvarchar(10)') as InstitutionID
			,xmldata.value('(/rawData/UploadFileName/node())[1]','nvarchar(900)') as UploadFileName
			,xmldata.value('(/rawData/FileStatus/node())[1]','nvarchar(10)') as FileStatus
			,xmldata.value('(/rawData/RequestTxID/node())[1]','nvarchar(40)') as RequestTxID
			,xmldata.value('(/rawData/GUID/node())[1]','nvarchar(36)') as [GUID]
			,xmldata.value('(/rawData/TaskID/node())[1]','int') as TaskID
			,xmldata.value('(/rawData/StateID/node())[1]','int') as StateID
			,xmldata.value('(/rawData/UniqueParticipantId/node())[1]','nvarchar(60)') as UniqueParticipantId
			,xmldata.value('(/rawData/CardSerialNumber/node())[1]','nvarchar(20)') as CardSerialNumber
			,xmldata.value('(/rawData/ExistingCardSN/node())[1]','nvarchar(20)') as ExistingCardSN
			,xmldata.value('(/rawData/Action/node())[1]','nvarchar(2)') as [Action]
			,xmldata.value('(/rawData/ReasonCode/node())[1]','nvarchar(2)') as ReasonCode
			,xmldata.value('(/rawData/Benefit/node())[1]','nvarchar(50)') as Benefit
			,xmldata.value('(/rawData/CardTypeCode/node())[1]','nvarchar(10)') as CardTypeCode
			,xmldata.value('(/rawData/SuccessFailureCode/node())[1]','nvarchar(10)') as SuccessFailureCode
			,xmldata.value('(/rawData/SuccessFailureDescr/node())[1]','nvarchar(128)') as SuccessFailureDescr
			,xmldata.value('(/rawData/ActionExecuted/node())[1]','nvarchar(20)') as ActionExecuted
			,xmldata.value('(/rawData/TSID/node())[1]','nvarchar(12)') as TSID
			,xmldata.value('(/rawData/Elig/node())[1]','nvarchar(10)') as Elig
			,xmldata.value('(/rawData/EligDate/node())[1]','nvarchar(20)') as EligDate
			,xmldata.value('(/rawData/Rval/node())[1]','nvarchar(3)') as Rval
			,xmldata.value('(/rawData/Rext/node())[1]','nvarchar(5)') as Rext
			,xmldata.value('(/rawData/BenefitID/node())[1]','int') as BenefitID
			,xmldata.value('(/rawData/BenefitProductID/node())[1]','bigint') as BenefitProductID
			,xmldata.value('(/rawData/BenefitMonth/node())[1]','int') as BenefitMonth
			,xmldata.value('(/rawData/BenefitYear/node())[1]','int') as BenefitYear
			,xmldata.value('(/rawData/URI/node())[1]','nvarchar(1000)') as URI
			,xmldata.value('(/rawData/URIType/node())[1]','nvarchar(50)') as URIType
			,DATEADD(MILLISECOND,DATEDIFF(MILLISECOND,getutcdate(),GETDATE()), xmldata.value('(/rawData/ProcessDatetime/node())[1]','datetime')) 
			,xmldata.value('(/rawData/ProcessErrorID/node())[1]','nvarchar(50)') as ProcessErrorID
			,xmldata
		from TL_StgESEventLogs
	    where loggedtime > @nxtdt and loggedtime <= @maxdt
		  and xmldata.value('(/rawData/ProcessDatetime/node())[1]','datetime') is not null;
	
	insert into dbo.tm_migration_16 values (@maxdt, @nxtdt, @@ROWCOUNT, getdate());
	set @maxdt = @nxtdt;
	set @nxtdt = dateadd(hh, @DateInterval, @maxdt);
	
	commit transaction @txName;
	
end 
go
