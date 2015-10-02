CREATE TABLE [dbo].[ESDiskspaceStatus] (
    [computername]  INT           NULL,
    [logicaldrive]  VARCHAR (255) NULL,
    [spacefree]     INT           NULL,
    [spacetotal]    INT           NULL,
    [recorddate]    DATETIME      NULL,
    [fileSystem]    VARCHAR (16)  NULL,
    [volumeName]    VARCHAR (64)  NULL,
    [groupname]     INT           NULL,
    [daysUntilFull] INT           NULL,
    CONSTRAINT [FK_ESDiskspaceStatus_ESEventlogComputer] FOREIGN KEY ([computername]) REFERENCES [dbo].[ESEventlogComputer] ([id]),
    CONSTRAINT [FK_ESDiskspaceStatus_ESEventlogGroup] FOREIGN KEY ([groupname]) REFERENCES [dbo].[ESEventlogGroup] ([id])
);


GO
CREATE NONCLUSTERED INDEX [IDX_ES_DiskspaceStatus_LogicalDrives]
    ON [dbo].[ESDiskspaceStatus]([computername] ASC, [logicaldrive] ASC) WITH (FILLFACTOR = 50);

