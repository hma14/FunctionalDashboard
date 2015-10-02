
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[RetrieveErrorListRecords]
AS
BEGIN
	
	SET NOCOUNT ON;

	select ProgramID, InstitutionID, EventID, CategoryID, ProcessDatetime, Status, UpdatedBy, UpdatedDatetime 
	from CPGFD_ErrorList
END


GO