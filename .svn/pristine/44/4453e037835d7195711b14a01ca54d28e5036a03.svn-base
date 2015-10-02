--
-- jtang: return error description and stack trace of a specifying log 
--
CREATE PROCEDURE [dbo].[usp_RetrieveSyncUtilityDetail] (@logId bigint)
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
      ,isnull([BenefitID],0) as [BenefitID]
      ,isnull([BenefitProductID],0) as [BenefitProductID]
      ,[ProcessDatetime]
      ,[ProcessErrorID]
	  ,xmldata.value('(/rawData/SyncID/node())[1]','varchar(4000)') as SyncID
	  ,xmldata.value('(/rawData/BenefitName/node())[1]','varchar(100)') as BenefitName
	  ,xmldata.value('(/rawData/ProcessErrorDescr/node())[1]','varchar(4000)') as ProcessErrorDescr
	  ,xmldata.value('(/rawData/StackTrace/node())[1]','varchar(4000)') as StackTrace
  FROM [dbo].[TL_EventLog] el
  Left outer join EventIDList e ON el.EventID = e.EventID
  LEFT OUTER JOIN CategoryIDList c ON el.Category = c.CategoryName 
  LEFT OUTER JOIN CPGEnvironments env ON el.Computer = env.ServerName
 WHERE el.id = @logId
   

END--PROC

GO


