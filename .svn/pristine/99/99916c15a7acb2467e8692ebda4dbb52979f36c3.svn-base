CREATE TABLE [dbo].[ESHeartbeatPingTracking] (
    [computername]   INT      NULL,
    [computersource] INT      NULL,
    [recorddate]     DATETIME NULL,
    [filtergroup]    INT      NULL,
    [responsetime]   INT      NULL,
    CONSTRAINT [FK_ESHeartbeatPingTracking_ESEventlogComputer] FOREIGN KEY ([computername]) REFERENCES [dbo].[ESEventlogComputer] ([id]),
    CONSTRAINT [FK_ESHeartbeatPingTracking_ESEventlogComputer2] FOREIGN KEY ([computersource]) REFERENCES [dbo].[ESEventlogComputer] ([id])
);


GO
CREATE CLUSTERED INDEX [IDX_ES_HBPingTracking]
    ON [dbo].[ESHeartbeatPingTracking]([recorddate] ASC) WITH (FILLFACTOR = 80);

