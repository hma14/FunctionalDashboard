CREATE PROCEDURE [dbo].RetrieveAllCPGFD_SLTTracking
AS
BEGIN

 
	SELECT t.ID as ID
	,t.SLTRuleID as SLTRuleID
	,t.ProgramID as ProgramID
	,t.InstitutionID as InstitutionID
	,nf.Name as Institution
	,c.CategoryName as Category
	,t.CategoryID as CategoryID
	,e.EventName  as Event	 
	,t.EventID as EventID
	,r.RuleDescription as RuleDescription
	,t.SLTStartDatetime as SLTStartDatetime
	,t.SLTWarningDatetime as SLTWarningDatetime
	,t.SLTBreachDatetime as SLTBreachDatetime
	,t.SLTCompleteDatetime as SLTCompleteDatetime
	,t.Status	as Status
	FROM [dbo].[CPGFD_SLTTracking]  t
	INNER JOIN [dbo].[CPGFD_SLTRules] r ON t.SLTRuleID=r.ID
	INNER JOIN [dbo].[EventIDList] e ON t.EventID=e.EventID
	INNER JOIN [dbo].[CategoryIDList]  c on t.CategoryID=c.CategoryID
	INNER JOIN [dbo].[NCSInfo] nf on t.InstitutionID=nf.InstitutionId
	WHERE  t.Status in (1, 2, 3)
	

END

GO
