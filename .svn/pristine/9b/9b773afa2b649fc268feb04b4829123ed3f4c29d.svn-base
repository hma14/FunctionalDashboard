create PROCEDURE [dbo].RetrieveCPGFD_SLTRules
AS
BEGIN
	select ID
		,[EventID]
		,[CategoryID]
		,[ProgramID]
		,[InstitutionID]
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
END

GO
