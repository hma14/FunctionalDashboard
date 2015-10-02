CREATE PROCEDURE [dbo].[usp_RetrieveHHUDetail] (@logId bigint)
AS
BEGIN
DECLARE 
	  @xmldata as xml;
      
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
	  ,@xmldata.value('(/rawData/TaskID/node())[1]','nvarchar(20)') as TaskID
	  ,@xmldata.value('(/rawData/StateID/node())[1]','nvarchar(20)') as StateID
	  ,@xmldata.value('(/rawData/Location/node())[1]','nvarchar(50)') as Location
	  ,@xmldata.value('(/rawData/FareInstrumentID/node())[1]','nvarchar(20)') as FareInstrumentID
	  ,@xmldata.value('(/rawData/HHUReasonCode/node())[1]','nvarchar(20)') as HHUReasonCode
	  ,@xmldata.value('(/rawData/HHUUserID/node())[1]','nvarchar(20)') as HHUUserID
	  ,@xmldata.value('(/rawData/CardSerialNumber/node())[1]','nvarchar(20)') as CardSerialNumber
	  ,@xmldata.value('(/rawData/ConfiscationDatetime/node())[1]','datetime') as ConfiscationDatetime
	  ,[ProcessDatetime]      
	  ,[ProcessErrorID]
	  ,xmldata.value('(/rawData/ProcessErrorDescr/node())[1]','varchar(4000)') as ProcessErrorDescr
	  ,xmldata.value('(/rawData/StackTrace/node())[1]','varchar(4000)') as StackTrace
  FROM [dbo].[TL_EventLog] el
  LEFT OUTER JOIN EventIDList e ON el.EventID = e.EventID
  LEFT OUTER JOIN CategoryIDList c ON el.Category = c.CategoryName 
  LEFT OUTER JOIN CPGEnvironments env ON el.Computer = env.ServerName
 WHERE el.id = @logId
   

END--PROC

GO