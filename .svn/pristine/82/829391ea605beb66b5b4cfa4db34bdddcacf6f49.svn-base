CREATE TABLE [dbo].[ESSysinfoServerDiskLogic] (
    [computer]     INT           NULL,
    [id]           INT           NULL,
    [controllerid] INT           NULL,
    [status]       VARCHAR (32)  NULL,
    [state]        VARCHAR (32)  NULL,
    [name]         VARCHAR (128) NULL,
    [disksize]     VARCHAR (64)  NULL,
    [devicename]   VARCHAR (64)  NULL,
    [stripesize]   VARCHAR (32)  NULL,
    [redundancy]   VARCHAR (64)  NULL,
    CONSTRAINT [FK_ESSysinfoServerDiskLogic_ESEventlogComputer] FOREIGN KEY ([computer]) REFERENCES [dbo].[ESEventlogComputer] ([id])
);


GO
CREATE NONCLUSTERED INDEX [IDX_ESSysinfoServerDiskLogic_Computer]
    ON [dbo].[ESSysinfoServerDiskLogic]([computer] ASC) WITH (FILLFACTOR = 80);

