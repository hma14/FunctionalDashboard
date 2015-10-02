--
-- jtang: return all event log categories
--
CREATE PROCEDURE [dbo].[usp_RetrieveAllEventLogCategory] 
AS
BEGIN

	SELECT CategoryID, CategoryName
	  FROM [dbo].CategoryIDList
	 Order by CategoryID;

END--PROC

GO


