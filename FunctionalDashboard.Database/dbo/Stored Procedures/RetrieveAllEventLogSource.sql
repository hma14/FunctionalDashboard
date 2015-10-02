--
-- jtang: return all event log source
--
CREATE PROCEDURE [dbo].[usp_RetrieveAllEventLogSource] 
AS
BEGIN

	SELECT ID, SourceName
	  FROM [dbo].[LogSource]
	 Order by ID;

END--PROC

GO


