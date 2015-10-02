-- jtang: return all active SLT rules
create PROCEDURE [dbo].[usp_RetrieveAllActiveSLTRules]
AS
BEGIN
	select ID
		,[InstitutionID]
		,[ProgramID]
		,[CategoryID]
		,[EventID]
		,[RuleDescription]
		,[RuleType]
		,[DayOfWeek]
		,[RuleDay]
		,[RuleTime]
		,[WarningThreshold]		
		,[Status]
		,[NextTriggerDatetime]
		,[UpdatedDatetime]
		,[UpdatedUser]
	from [dbo].[CPGFD_SLTRules]
	where Status=1
	order by ID;

END

GO
