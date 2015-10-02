-- jtang 01_cleanup
/*
 select 'DROP PROCEDURE ['+ s.name +'].' + '['+ p.name +']' 
 from sys.procedures p 
 inner join sys.schemas s on p.schema_id = s.schema_id

SELECT 'DROP FUNCTION ['+ SCHEMA_NAME(schema_id)+'].[' + name + ']'
FROM sys.objects
WHERE type_desc LIKE '%FUNCTION%'

*/

DROP PROCEDURE [dbo].[InsertErrorMsg]
DROP PROCEDURE [dbo].[IsExistInErrorList]
DROP PROCEDURE [dbo].[RetrieveCPGFD_ErrorMsg]
DROP PROCEDURE [dbo].[RetrieveCPGFD_KB]
DROP PROCEDURE [dbo].[RetrieveErrorExceptions]
DROP PROCEDURE [dbo].[RetrieveErrorListRecords]
DROP PROCEDURE [dbo].[RetrieveErrorStatus]
DROP PROCEDURE [dbo].[RetrieveEventSentryStatus]
DROP PROCEDURE [dbo].[usp_RetrieveNCSInfo]
DROP PROCEDURE [dbo].[usp_RetrieveTLEventLog]
DROP PROCEDURE [dbo].[usp_RetrieveTLEventLogErrorDetail]
DROP PROCEDURE [dbo].[TL_RetrieveEventLog]
DROP PROCEDURE [dbo].[UpdateCPGFD_KB]
DROP PROCEDURE [dbo].[UpdateErrorList]
GO
IF OBJECT_ID ('TL_trg_INS_ESEventlogMain', 'TR') IS NOT NULL
   DROP TRIGGER [TL_trg_INS_ESEventlogMain];
GO
