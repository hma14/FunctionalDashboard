--
-- jtang: update rule status by rule id
--
CREATE PROCEDURE [dbo].[usp_UpdateSLTRuleStatusById]( @id bigint, @status tinyint, @user nvarchar(50))
AS
BEGIN
	UPDATE CPGFD_SLTRules SET [Status]=@status, [UpdatedDatetime]=GETDATE(), [UpdatedUser]=@user
	WHERE ID=@id 
END

GO
