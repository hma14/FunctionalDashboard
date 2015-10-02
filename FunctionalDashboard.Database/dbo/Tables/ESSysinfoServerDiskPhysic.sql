CREATE TABLE [dbo].[ESSysinfoServerDiskPhysic] (
    [computer]         INT           NULL,
    [id]               VARCHAR (32)  NULL,
    [controllerid]     INT           NULL,
    [logicaldiskid]    INT           NULL,
    [name]             VARCHAR (128) NULL,
    [status]           VARCHAR (32)  NULL,
    [state]            VARCHAR (32)  NULL,
    [busprotocol]      VARCHAR (32)  NULL,
    [manufactureDate]  VARCHAR (32)  NULL,
    [model]            VARCHAR (64)  NULL,
    [rotationalspeed]  VARCHAR (16)  NULL,
    [capacity]         VARCHAR (48)  NULL,
    [transfermode]     VARCHAR (32)  NULL,
    [transferspeed]    VARCHAR (32)  NULL,
    [revision]         VARCHAR (32)  NULL,
    [partnumber]       VARCHAR (64)  NULL,
    [serialnumber]     VARCHAR (64)  NULL,
    [failurepredicted] VARCHAR (16)  NULL,
    CONSTRAINT [FK_ESSysinfoServerDiskPhysic_ESEventlogComputer] FOREIGN KEY ([computer]) REFERENCES [dbo].[ESEventlogComputer] ([id])
);


GO
CREATE NONCLUSTERED INDEX [IDX_ESSysinfoServerDiskPhysic_Computer]
    ON [dbo].[ESSysinfoServerDiskPhysic]([computer] ASC) WITH (FILLFACTOR = 80);

