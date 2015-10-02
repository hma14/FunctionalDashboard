-- jtang 01_cleanup
/*
 select 'DROP PROCEDURE ['+ s.name +'].' + '['+ p.name +']' 
 from sys.procedures p 
 inner join sys.schemas s on p.schema_id = s.schema_id

SELECT 'DROP FUNCTION ['+ SCHEMA_NAME(schema_id)+'].[' + name + ']'
FROM sys.objects
WHERE type_desc LIKE '%FUNCTION%'

*/

DROP PROCEDURE [dbo].[InsertErrorList]
DROP PROCEDURE [dbo].[RetrieveErrorExceptions]
--DROP PROCEDURE [dbo].[RetrieveErrorStatus]
DROP PROCEDURE [dbo].[RetrieveEventLog]
DROP PROCEDURE [dbo].[RetrieveNCSInfo]
DROP PROCEDURE [dbo].[UpdateErrorList]
DROP PROCEDURE [dbo].[RetrieveErrorListRecords]
DROP PROCEDURE [dbo].[IsExistInErrorList]
DROP PROCEDURE [dbo].[RetrieveCPGFD_ErrorMsg]
DROP PROCEDURE [dbo].[InsertErrorMsg]
DROP PROCEDURE [dbo].[RetrieveEventSentryStatus]
DROP PROCEDURE [dbo].[TL_RetrieveEventLog]

go

DROP TABLE [dbo].[TL_AuditDuplicateDeleteScript]
                 
GO

