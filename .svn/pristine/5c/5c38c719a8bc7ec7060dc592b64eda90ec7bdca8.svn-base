CREATE view [dbo].[view_ESStatus]
as
select c.eventcomputer,
       lastupdate = dateadd(mi, datediff(mi, getutcdate(),getdate()),max(eventtime))
from ESEventlogMain m, ESEventlogComputer c with (NOLOCK)
where c.id = m.eventcomputer
group by c.eventcomputer