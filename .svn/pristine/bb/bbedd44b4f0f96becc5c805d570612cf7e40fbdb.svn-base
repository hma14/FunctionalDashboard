CREATE PROCEDURE [dbo].UpdateCPGFD_SLTRules_By_NextTriggerDatetime(@eventID int, @categoryID int, @programID varchar(10), @institutionID varchar(10), 
															 @nextTriggerDatetime Datetime, @user nvarchar(50))
AS
BEGIN

	UPDATE [dbo].[CPGFD_SLTRules] SET [NextTriggerDatetime]=@nextTriggerDatetime, [UpdatedDatetime]=GETDATE(), [UpdatedUser]=@user
		
	WHERE EventID=@eventID 
		  AND CategoryID= @categoryID
		  AND ProgramID=@programID 
		  AND InstitutionID=@institutionID
END

GO
