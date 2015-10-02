CREATE PROCEDURE InsertSLTTrackingHistory(@SLTTrackingID INT, @message TEXT, @updatedBy VARCHAR (50))

AS
BEGIN

	INSERT INTO [dbo].[SLTTrackingHistory] VALUES(@SLTTrackingID, @message,  @updatedBy, GETDATE())

END
