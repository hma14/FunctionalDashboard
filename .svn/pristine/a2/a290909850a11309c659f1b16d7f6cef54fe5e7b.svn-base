--
-- jtang: update an existing or add a new event id
--
CREATE PROCEDURE [dbo].[usp_UpdateEventLogEventId] (@id as int, @eventName as varchar(255))
AS
BEGIN
	declare @eid as int;
	select @eid = EventID from [dbo].EventIDList where EventID = @id;

	if @id = @eid
		Update [dbo].EventIDList set EventName = @eventName
		 where EventID = @id;
	else
		insert into [dbo].EventIDList (EventID, EventName) values (@id, @eventName);
		
	return 0;
END--PROC

GO



