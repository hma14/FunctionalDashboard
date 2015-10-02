CREATE PROCEDURE dbo.ClearFromCPGFD_SLTTracking(@ID int)
AS
BEGIN
	UPDATE [dbo].[CPGFD_SLTTracking] 
	SET Status=4
	WHERE EventID=@ID 	  

END

GO
