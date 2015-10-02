CREATE PROCEDURE RetrieveSLTTrackingHistory(@cate int, @evt int, @programID varchar(10), @institutionID varchar(10))
AS
BEGIN
	SELECT th.[Message]
	,th.[UpdatedBy]
	,th.[UpdatedDatetime]
	FROM [dbo].[SLTTrackingHistory] AS th
	INNER JOIN [dbo].[CPGFD_SLTTracking] tr ON th.SLTTrackingID = tr.ID
	WHERE tr.[EventID] = @evt AND tr.[CategoryID] = @cate 
	AND tr.[ProgramID] = @programID AND tr.[InstitutionID] = @institutionID

END
