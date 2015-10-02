CREATE TABLE [dbo].[ESSysinfoMemory] (
    [computer]      INT          NULL,
    [capacity]      INT          NULL,
    [speed]         INT          NULL,
    [formfactor]    VARCHAR (16) NULL,
    [memorytype]    VARCHAR (32) NULL,
    [devicelocator] VARCHAR (64) NULL
);


GO
CREATE CLUSTERED INDEX [IDX_ES_SysinfoMemory]
    ON [dbo].[ESSysinfoMemory]([computer] ASC) WITH (FILLFACTOR = 80);

