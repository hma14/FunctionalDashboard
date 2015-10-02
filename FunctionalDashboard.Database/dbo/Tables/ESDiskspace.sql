CREATE TABLE [dbo].[ESDiskspace] (
    [computername]     INT           NULL,
    [logicaldrive]     VARCHAR (255) NULL,
    [spacefree]        INT           NULL,
    [spacetotal]       INT           NULL,
    [recorddate]       DATETIME      NULL,
    [logicaldrivename] INT           NULL,
    [groupname]        INT           NULL,
    CONSTRAINT [FK_ESDiskspace_ESEventlogComputer] FOREIGN KEY ([computername]) REFERENCES [dbo].[ESEventlogComputer] ([id]),
    CONSTRAINT [FK_ESDiskspace_ESEventlogGroup] FOREIGN KEY ([groupname]) REFERENCES [dbo].[ESEventlogGroup] ([id]),
    CONSTRAINT [FK_ESDiskspace_ESStrings] FOREIGN KEY ([logicaldrivename]) REFERENCES [dbo].[ESStrings] ([id])
);


GO
CREATE CLUSTERED INDEX [IDX_ES_Diskspace]
    ON [dbo].[ESDiskspace]([recorddate] ASC) WITH (FILLFACTOR = 80);


GO
CREATE NONCLUSTERED INDEX [IDX_ES_Diskspace_LogicalDrives]
    ON [dbo].[ESDiskspace]([computername] ASC, [logicaldrive] ASC) WITH (FILLFACTOR = 50);

