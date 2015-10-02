CREATE TABLE [dbo].[ESSysinfoPhysicalDrive] (
    [computer]         INT           NULL,
    [model]            VARCHAR (128) NULL,
    [deviceId]         VARCHAR (64)  NULL,
    [firmwareRevision] VARCHAR (32)  NULL,
    [serialNumber]     VARCHAR (128) NULL,
    [driveSize]        INT           NULL,
    [status]           VARCHAR (16)  NULL,
    [interface]        VARCHAR (16)  NULL,
    [partitions]       INT           NULL,
    CONSTRAINT [FK_ESSysinfoPhysicalDrive_ESEventlogComputer] FOREIGN KEY ([computer]) REFERENCES [dbo].[ESEventlogComputer] ([id])
);


GO
CREATE CLUSTERED INDEX [IDX_ES_SysinfoPhysicalDrive]
    ON [dbo].[ESSysinfoPhysicalDrive]([computer] ASC) WITH (FILLFACTOR = 80);

