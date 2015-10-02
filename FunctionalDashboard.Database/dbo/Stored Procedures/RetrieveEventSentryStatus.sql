-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[RetrieveEventSentryStatus] 
	
AS
BEGIN
	select c.eventcomputer Server,
       LastUpdateTime = dateadd(mi, datediff(mi, getutcdate(),getdate()),max(eventtime))
	from ESEventlogMain m, ESEventlogComputer c with (NOLOCK)
	where c.id = m.eventcomputer
	group by c.eventcomputer
END

GO