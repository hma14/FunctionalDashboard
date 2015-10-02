-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[RetrieveErrorStatus] (@eventID int, @categoryID int, @processDatetime Datetime = null)

AS
BEGIN
	declare @res int
	if (@processDatetime is null)
		begin		
			set @res = (select count(*) from CPGFD_ErrorList where EventID = @eventID and CategoryID = @categoryID )
			if (@res <> 0)
				begin
					select Status from CPGFD_ErrorList
					where EventID = @eventID and CategoryID = @categoryID 
				end
			else
				begin
					select -1
				end
		end
	else
		begin
			set @res = (select count(*) from CPGFD_ErrorList where EventID = @eventID and CategoryID = @categoryID and ProcessDatetime = @processDatetime )
			if (@res <> 0)
				begin
					select Status from CPGFD_ErrorList
					where EventID = @eventID and CategoryID = @categoryID and ProcessDatetime = @processDatetime
				end
			else
				begin
					select -1
				end
		end
END

GO