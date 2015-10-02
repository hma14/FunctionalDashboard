
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[RetrieveCPGFD_KB](@eventID int, @categoryID int)
AS
BEGIN
	select EventID, CategoryID, Status, Description, PotentialErrors, BusinessImpact, 
		   Sev, Resolutions, CreatedBy,  CreatedDatetime, UpdatedBy, UpdatedDatetime
	from [dbo].[CPGFD_KB]
	where EventID=@eventID and CategoryID=@categoryID
END

GO