CREATE TABLE [dbo].[ESUptimeHistory] (
    [recorddate]    DATETIME      NULL,
    [groupname]     INT           NULL,
    [computername]  INT           NULL,
    [uptime]        INT           NULL,
    [calleruser]    INT           NULL,
    [callerprocess] INT           NULL,
    [reasontitle]   INT           NULL,
    [shutdowntype]  INT           NULL,
    [reasonmajor]   INT           NULL,
    [reasonminor]   INT           NULL,
    [comment]       VARCHAR (255) NULL,
    [isplanned]     INT           NULL,
    CONSTRAINT [FK_ESUptimeHistory_ESEventlogComputer] FOREIGN KEY ([computername]) REFERENCES [dbo].[ESEventlogComputer] ([id]),
    CONSTRAINT [FK_ESUptimeHistory_ESEventlogGroup] FOREIGN KEY ([groupname]) REFERENCES [dbo].[ESEventlogGroup] ([id]),
    CONSTRAINT [FK_ESUptimeHistory_ESEventlogUser] FOREIGN KEY ([calleruser]) REFERENCES [dbo].[ESEventlogUser] ([id]),
    CONSTRAINT [FK_ESUptimeHistory_ESFile] FOREIGN KEY ([callerprocess]) REFERENCES [dbo].[ESFile] ([id]),
    CONSTRAINT [FK_ESUptimeHistory_ESStringsMajor] FOREIGN KEY ([reasonmajor]) REFERENCES [dbo].[ESStrings] ([id]),
    CONSTRAINT [FK_ESUptimeHistory_ESStringsMinor] FOREIGN KEY ([reasonminor]) REFERENCES [dbo].[ESStrings] ([id]),
    CONSTRAINT [FK_ESUptimeHistory_ESStringsTitle] FOREIGN KEY ([reasontitle]) REFERENCES [dbo].[ESStrings] ([id]),
    CONSTRAINT [FK_ESUptimeHistory_ESStringsType] FOREIGN KEY ([shutdowntype]) REFERENCES [dbo].[ESStrings] ([id])
);


GO
CREATE CLUSTERED INDEX [IDX_ES_UptimeHistory]
    ON [dbo].[ESUptimeHistory]([recorddate] ASC) WITH (FILLFACTOR = 80);

