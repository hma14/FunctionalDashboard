CREATE PROCEDURE [dbo].RetrieveTrackingEntryFromTL_EventLog(@eventID int, @categoryID int, @programID varchar(10), @institutionID varchar(10), 
													 @startDatetime Datetime, @breachDatetime Datetime)
AS
BEGIN
	declare @category varchar(255);
	set @category = (select CategoryName from CategoryIDList where CategoryID=@categoryID);
	
      SELECT [ID]
      ,[SourceLogID]
      ,[LogName]
      ,[Level]
      ,[Source]
      ,[Category]
	  ,[EventID]
      ,[Computer]
      ,[LoggedTime]
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
	 
	from [dbo].[TL_EventLog] 
	where EventID=@eventID 
		  and Category= @category
		  and ProgramID=@programID 
		  and InstitutionID=@institutionID
		  and ProcessDatetime > @startDatetime
		  and ProcessDatetime < @breachDatetime

END

GO
