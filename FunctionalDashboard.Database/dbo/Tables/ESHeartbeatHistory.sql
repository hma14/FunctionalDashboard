CREATE TABLE [dbo].[ESHeartbeatHistory] (
    [recorddate]     DATETIME NULL,
    [computername]   INT      NULL,
    [computersource] INT      NULL,
    [filtergroup]    INT      NULL,
    [type]           INT      NULL,
    [status_old]     INT      NULL,
    [status_new]     INT      NULL,
    [description]    INT      NULL,
    [maint_secs]     INT      NULL,
    CONSTRAINT [FK_ESHeartbeatHistory_ESEventlogComputer] FOREIGN KEY ([computername]) REFERENCES [dbo].[ESEventlogComputer] ([id]),
    CONSTRAINT [FK_ESHeartbeatHistory_ESEventlogComputer2] FOREIGN KEY ([computersource]) REFERENCES [dbo].[ESEventlogComputer] ([id]),
    CONSTRAINT [FK_ESHeartbeatHistory_ESEventlogGroup] FOREIGN KEY ([filtergroup]) REFERENCES [dbo].[ESEventlogGroup] ([id]),
    CONSTRAINT [FK_ESHeartbeatHistory_ESHeartbeatLDescription] FOREIGN KEY ([description]) REFERENCES [dbo].[ESHeartbeatLDescription] ([id]),
    CONSTRAINT [FK_ESHeartbeatHistory_ESHeartbeatLStatus] FOREIGN KEY ([status_old]) REFERENCES [dbo].[ESHeartbeatLStatus] ([id]),
    CONSTRAINT [FK_ESHeartbeatHistory_ESHeartbeatLStatus1] FOREIGN KEY ([status_new]) REFERENCES [dbo].[ESHeartbeatLStatus] ([id]),
    CONSTRAINT [FK_ESHeartbeatHistory_ESHeartbeatLType] FOREIGN KEY ([type]) REFERENCES [dbo].[ESHeartbeatLType] ([id])
);


GO
CREATE CLUSTERED INDEX [IDX_ES_HBHistory]
    ON [dbo].[ESHeartbeatHistory]([recorddate] ASC) WITH (FILLFACTOR = 80);

