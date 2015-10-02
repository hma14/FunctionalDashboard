-- jtang: your data initialization scripts

insert into [dbo].[NCSInfo] values (74, 'TLAT2','PPASS',1, 'TransLink Access Transit','TLAT2');
GO

insert into [dbo].[EventIDList] values (2518, 'ActivateSmartCardStarted ');
insert into [dbo].[EventIDList] values (2519, 'ActivateSmartCardFailed ');
insert into [dbo].[EventIDList] values (2520, 'ActivateSmartCardEnded ');

go
