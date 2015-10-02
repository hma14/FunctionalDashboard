--
-- jtang: return error description and stack trace of a specifying log 
--
CREATE PROCEDURE [dbo].[usp_RetrieveTLEventLogErrorDetail] (@logId bigint)
AS
BEGIN

	SELECT ID, xmldata.value('(/rawData/ProcessErrorDescr/node())[1]','varchar(4000)') as ProcessErrorDescr
		   ,xmldata.value('(/rawData/StackTrace/node())[1]','varchar(4000)') as StackTrace
	  FROM [dbo].[TL_EventLog]
	 WHERE ID = @logId

END--PROC

GO


