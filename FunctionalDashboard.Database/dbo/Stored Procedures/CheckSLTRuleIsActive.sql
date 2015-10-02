-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE dbo.CheckSLTRuleIsActive(@eventID int, @categoryID int, @programID int, @institutionID int)
AS
BEGIN
	select count(*) from CPGFD_SLTRules 
	where EventID=@eventID and CategoryID=@categoryID and ProgramID=@programID and InstitutionID=@institutionID and Status=1

END

GO
