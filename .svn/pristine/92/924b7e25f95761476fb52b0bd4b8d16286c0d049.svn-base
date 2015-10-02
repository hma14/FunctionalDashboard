-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
create PROCEDURE [dbo].[RetrieveCPGFD_ErrorMsg](@cate int, @evt int, @processDatetime bigint,
									            @programID varchar(10) = null, @institutionID varchar(10) = null) 
	
AS
BEGIN
	if (@programID is null)
		BEGIN
			select m.Message, m.UpdatedBy, m.UpdatedDatetime
			from [dbo].[CPGFD_ErrorMsg] m
			inner join [dbo].[CPGFD_ErrorList] l on m.ErrorListID = l.ID
			where l.ProcessDatetime >= @processDatetime and l.CategoryID = @cate and l.EventID = @evt 
		END
		
	else
		BEGIN
			select m.Message, m.UpdatedBy, m.UpdatedDatetime
			from [dbo].[CPGFD_ErrorMsg] m
			inner join [dbo].[CPGFD_ErrorList] l on m.ErrorListID = l.ID
			where l.ProcessDatetime >= @processDatetime and l.CategoryID = @cate and l.EventID = @evt and 
				  l.ProgramID = @programID and l.InstitutionID = @institutionID
		END
END

GO
