-- jtang 01_cleanup
/*
 select 'DROP PROCEDURE ['+ s.name +'].' + '['+ p.name +']' 
 from sys.procedures p 
 inner join sys.schemas s on p.schema_id = s.schema_id

SELECT 'DROP FUNCTION ['+ SCHEMA_NAME(schema_id)+'].[' + name + ']'
FROM sys.objects
WHERE type_desc LIKE '%FUNCTION%'

*/
DROP TABLE [dbo].[TL_StgESEventLogs]
GO

DROP PROCEDURE [dbo].[CheckSLTRuleIsActive]
DROP PROCEDURE [dbo].[ClearFromCPGFD_SLTTracking]
DROP PROCEDURE [dbo].[ExistInCPGFD_SLTTracking]
DROP PROCEDURE [dbo].[InsertCPGFD_SLTTracking]
DROP PROCEDURE [dbo].[InsertErrorMsg]
DROP PROCEDURE [dbo].[IsExistInErrorList]
DROP PROCEDURE [dbo].[RetrieveAllCPGFD_SLTTracking]
DROP PROCEDURE [dbo].[RetrieveCPGFD_ErrorMsg]
DROP PROCEDURE [dbo].[RetrieveCPGFD_KB]
DROP PROCEDURE [dbo].[RetrieveCPGFD_SLTRules]
DROP PROCEDURE [dbo].[RetrieveCPGFD_SLTTracking]
DROP PROCEDURE [dbo].[RetrieveErrorExceptions]
DROP PROCEDURE [dbo].[RetrieveErrorListRecords]
DROP PROCEDURE [dbo].[RetrieveErrorStatus]
DROP PROCEDURE [dbo].[RetrieveEventSentryStatus]
DROP PROCEDURE [dbo].[usp_RetrieveNCSInfo]
DROP PROCEDURE [dbo].[usp_RetrieveSyncUtilityDetail]
DROP PROCEDURE [dbo].[usp_RetrieveTLEventLog]
DROP PROCEDURE [dbo].[usp_RetrieveTLEventLogErrorDetail]
DROP PROCEDURE [dbo].[RetrieveTrackingEntryFromTL_EventLog]
DROP PROCEDURE [dbo].[RetrieveUserRole]
DROP PROCEDURE [dbo].[UpdateCPGFD_KB]
DROP PROCEDURE [dbo].[UpdateCPGFD_SLTRules_By_NextTriggerDatetime]
DROP PROCEDURE [dbo].[UpdateCPGFD_SLTTracking]
DROP PROCEDURE [dbo].[UpdateErrorList]
DROP PROCEDURE [dbo].[usp_UpdateSLTRuleStatusById]
DROP PROCEDURE [dbo].[usp_UpdateEventLogEventCategory]
DROP PROCEDURE [dbo].[usp_UpdateEventLogEventId]
DROP PROCEDURE [dbo].[usp_RetrieveAllActiveSLTRules]
DROP PROCEDURE [dbo].[usp_RetrieveAllEventLogCategory]
DROP PROCEDURE [dbo].[usp_RetrieveAllEventLogEventId]
DROP PROCEDURE [dbo].[usp_RetrieveAllEventLogSource]
DROP PROCEDURE [dbo].[usp_RetrieveAllHHUDetails]
DROP PROCEDURE [dbo].[usp_RetrieveHHUDetail]

go
