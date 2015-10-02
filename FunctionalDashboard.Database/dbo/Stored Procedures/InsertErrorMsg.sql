-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[InsertErrorMsg](@cate int,  @evt int, @message text, @processDatetime bigint, @status tinyint, @updatedBy nvarchar(50), 
									   @programID varchar(10) = null, @institutionID varchar(10) = null )
	AS

	DECLARE @errorListID INT;
	IF (@programID is null OR @institutionID is null)
		BEGIN			
			set @errorListID = (select TOP 1 ID from CPGFD_ErrorList  where ProcessDatetime >= @processDatetime and 
																	  EventID = @evt and 
																	  CategoryID = @cate);
		END
	ELSE
		BEGIN
			set @errorListID = (select TOP 1 ID from CPGFD_ErrorList  where ProcessDatetime >= @processDatetime and 
																	  ProgramID = @programID and 
																	  InstitutionID = @institutionID and 
																	  EventID = @evt and 
																	  CategoryID = @cate);
			
		END
	
	INSERT INTO CPGFD_ErrorMsg VALUES(@errorListID, @message, @status, @updatedBy, GETDATE())

GO
