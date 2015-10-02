-- =============================================
-- Author:		jun tang
-- Create date: <Create Date,,>
-- Description:	return all NCSINFO
-- =============================================
CREATE PROCEDURE [dbo].[usp_RetrieveNCSInfo]
AS
BEGIN
	SELECT OrganizationId, upper(InstitutionId) as InstitutionId, ProgramId, Active, Name, ShortName
	FROM NCSInfo
END

GO