-- jtang 01_cleanup
/*
 select 'DROP PROCEDURE ['+ s.name +'].' + '['+ p.name +']' 
 from sys.procedures p 
 inner join sys.schemas s on p.schema_id = s.schema_id

SELECT 'DROP FUNCTION ['+ SCHEMA_NAME(schema_id)+'].[' + name + ']'
FROM sys.objects
WHERE type_desc LIKE '%FUNCTION%'

*/

-- remove permanently
DROP PROCEDURE [dbo].[RetrieveEventLog]
DROP VIEW [dbo].[view_ESEventLogs]
go

-- to be rebuilt later
DROP PROCEDURE [dbo].[InsertErrorMsg]
DROP PROCEDURE [dbo].[IsExistInErrorList]
DROP PROCEDURE [dbo].[RetrieveCPGFD_ErrorMsg]
DROP PROCEDURE [dbo].[RetrieveCPGFD_KB]
DROP PROCEDURE [dbo].[RetrieveErrorExceptions]
DROP PROCEDURE [dbo].[RetrieveErrorListRecords]
DROP PROCEDURE [dbo].[RetrieveErrorStatus]
DROP PROCEDURE [dbo].[RetrieveEventSentryStatus]
DROP PROCEDURE [dbo].[RetrieveNCSInfo]
--DROP PROCEDURE [dbo].[RetrieveUserRole]
DROP PROCEDURE [dbo].[TL_RetrieveEventLog]
DROP PROCEDURE [dbo].[UpdateCPGFD_KB]
DROP PROCEDURE [dbo].[UpdateErrorList]
--DROP PROCEDURE [dbo].[usp_RetrieveNCSInfo]
--DROP PROCEDURE [dbo].[usp_RetrieveTLEventLog]
--DROP PROCEDURE [dbo].[usp_RetrieveTLEventLogErrorDetail]
go

disable trigger [dbo].[TL_trg_INS_ESEventlogMain] ON [dbo].[ESEventlogMain]

go
