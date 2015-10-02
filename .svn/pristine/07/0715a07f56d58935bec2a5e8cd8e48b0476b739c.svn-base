CREATE PROCEDURE dbo.ExistInCPGFD_SLTTracking( @ruleID varchar(10))
AS
BEGIN
	SELECT COUNT(*) FROM [dbo].[CPGFD_SLTTracking] 
	WHERE SLTRuleID=@ruleID AND (Status=1 OR Status=2)
END

GO
