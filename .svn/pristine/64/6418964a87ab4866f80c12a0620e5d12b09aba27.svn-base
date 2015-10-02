CREATE PROCEDURE [dbo].UpdateCPGFD_SLTTracking( @id bigint, @completeDatetime Datetime=NULL, @status tinyint, @user nvarchar(50))
AS
BEGIN
	IF (@status=4)
		BEGIN
			UPDATE CPGFD_SLTTracking SET [SLTCompleteDatetime]=@completeDatetime, [Status]=@status, [UpdatedDatetime]=GETDATE(), [UpdatedUser]=@user
			WHERE ID=@id AND Status = 3
		END
	ELSE
		BEGIN
			UPDATE CPGFD_SLTTracking SET [SLTCompleteDatetime]=@completeDatetime, [Status]=@status, [UpdatedDatetime]=GETDATE(), [UpdatedUser]=@user
			WHERE ID=@id AND Status < 3
		END
END

GO
