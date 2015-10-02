-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[RetrieveErrorExceptions]
AS
BEGIN
	select EventID, CategoryID, Status from CPGFD_ErrorExceptions 
	
END

GO