
create PROCEDURE [dbo].[IsExistInErrorList] (@cate int, @evt int,  @processDatetime bigint, @programID varchar(10) = null, @institutionID varchar(10) = null )
AS
BEGIN
	
	SET NOCOUNT ON;
	if (@programID is null)
		begin
			select COUNT(*)
			from CPGFD_ErrorList l
			where l.CategoryID = @cate and l.EventID = @evt 
			and l.ProcessDatetime >= @processDatetime
		end
	else
		begin
			select COUNT(*)
			from CPGFD_ErrorList l
			where l.CategoryID = @cate and l.EventID = @evt and 
			l.ProcessDatetime >= @processDatetime and 
			l.ProgramID = @programID and l.InstitutionID = @institutionID
		end
END


GO
