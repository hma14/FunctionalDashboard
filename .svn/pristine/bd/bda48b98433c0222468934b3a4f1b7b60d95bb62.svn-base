CREATE PROCEDURE [dbo].RetrieveCPGFD_SLTTracking( @ruleID bigint)
AS
BEGIN

	SELECT ID
	,SLTRuleID
	,ProgramID
	,InstitutionID
	,CategoryID
	,EventID
	,SLTStartDatetime
	,SLTWarningDatetime
	,SLTBreachDatetime
	,SLTCompleteDatetime
	,Status
	
	FROM [dbo].[CPGFD_SLTTracking] 
	WHERE SLTRuleID=@ruleID AND (Status=1 OR Status=2)

END

GO
