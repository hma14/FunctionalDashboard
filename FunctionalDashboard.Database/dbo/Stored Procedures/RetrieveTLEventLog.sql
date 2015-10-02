CREATE PROCEDURE [dbo].[usp_RetrieveTLEventLog] (@startDate Datetime, @endDate Datetime)
AS
BEGIN
      
      SELECT [ID]
      ,[SourceLogID]
      ,[LogName]
      ,[Level]
      ,[Source]
      ,el.[Category]
	  ,isnull(c.CategoryID, 0) as CategoryID
      ,el.[EventID]
	  ,e.EventName as [Event]
      ,[Computer]
      ,[LoggedTime]
      ,env.Environment
      ,[ProgramID]
      ,upper([InstitutionID]) as [InstitutionID]
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
      ,isnull([BenefitID],0) as [BenefitID]
      ,isnull([BenefitProductID],0) as [BenefitProductID]
      ,isnull([BenefitMonth],0) as [BenefitMonth]
      ,isnull([BenefitYear],0) as [BenefitYear]
      ,[URI]
      ,[URIType]
      ,[ProcessDatetime]
      ,[ProcessErrorID]
	  ,Year([ProcessDatetime]) as [Year]
	  ,Month([ProcessDatetime]) as [Month]
	  ,Day([ProcessDatetime]) as [Day]
  FROM [dbo].[TL_EventLog] el
  Left outer join EventIDList e ON el.EventID = e.EventID
  LEFT OUTER JOIN CategoryIDList c ON el.Category = c.CategoryName 
  LEFT OUTER JOIN CPGEnvironments env ON el.Computer = env.ServerName
 WHERE el.LoggedTime >= @startDate 
   and el.LoggedTime <= @endDate
 order by el.LoggedTime desc

END--PROC

GO


