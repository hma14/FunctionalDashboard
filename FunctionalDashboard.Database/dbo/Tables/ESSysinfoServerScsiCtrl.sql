CREATE TABLE [dbo].[ESSysinfoServerScsiCtrl] (
    [computer]     INT           NULL,
    [controllerid] INT           NULL,
    [connectors]   INT           NULL,
    [name]         VARCHAR (128) NULL,
    [status]       VARCHAR (16)  NULL,
    [firmware]     VARCHAR (64)  NULL,
    [cachesize]    VARCHAR (16)  NULL,
    CONSTRAINT [FK_ESSysinfoServerScsiCtrl_ESEventlogComputer] FOREIGN KEY ([computer]) REFERENCES [dbo].[ESEventlogComputer] ([id])
);


GO
CREATE NONCLUSTERED INDEX [IDX_ESSysinfoServerScsiCtrl_Computer]
    ON [dbo].[ESSysinfoServerScsiCtrl]([computer] ASC) WITH (FILLFACTOR = 80);

