CREATE PROCEDURE dbo.InsertCPGFD_SLTTracking( @eventID int,@categoryID int,  @programID varchar(10), @institutionID varchar(10),  @ruleID int, @ruleDescription text,
										 @startDatetime Datetime, @warningDatetime Datetime, @breachDatetime Datetime, @completeDatetime Datetime=null, 
										 @status tinyint, @user nvarchar(50))
AS
BEGIN

	INSERT INTO CPGFD_SLTTracking VALUES( @eventID, @categoryID, @programID, @institutionID, @ruleID, @ruleDescription, 
										 @startDatetime, @warningDatetime, @breachDatetime,
										 @completeDatetime, @status, GETDATE(), @user)
	
END

GO
