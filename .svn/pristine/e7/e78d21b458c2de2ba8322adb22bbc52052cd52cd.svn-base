--
-- jtang: update an existing or add a new event id
--
CREATE PROCEDURE [dbo].[usp_UpdateEventLogEventCategory] (@id as int, @categoryName as varchar(255))
AS
BEGIN
	declare @eid as int;
	select @eid = CategoryID from [dbo].CategoryIDList where CategoryID = @id;

	if @id = @eid
		Update [dbo].CategoryIDList set CategoryName = @categoryName
		 where CategoryID = @id;
	else
		insert into [dbo].CategoryIDList (CategoryID, CategoryName) values (@id, @categoryName);
		
	return 0;
END--PROC

GO


