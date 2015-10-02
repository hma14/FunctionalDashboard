CREATE TABLE [dbo].[ESHeartbeatStatus] (
    [recorddate]       DATETIME      NULL,
    [lastScanDuration] INT           NULL,
    [computername]     INT           NULL,
    [computersource]   INT           NULL,
    [filtergroup]      INT           NULL,
    [status]           INT           NULL,
    [ping]             INT           NULL,
    [agent]            INT           NULL,
    [tcp]              INT           NULL,
    [tcp_ports_all]    VARCHAR (384) NULL,
    [tcp_ports_failed] VARCHAR (384) NULL,
    [description]      INT           NULL,
    [ping_roundtrip]   INT           NULL,
    CONSTRAINT [FK_ESHeartbeatStatus_ESEventlogComputer] FOREIGN KEY ([computername]) REFERENCES [dbo].[ESEventlogComputer] ([id]),
    CONSTRAINT [FK_ESHeartbeatStatus_ESEventlogComputer2] FOREIGN KEY ([computersource]) REFERENCES [dbo].[ESEventlogComputer] ([id]),
    CONSTRAINT [FK_ESHeartbeatStatus_ESEventlogGroup] FOREIGN KEY ([filtergroup]) REFERENCES [dbo].[ESEventlogGroup] ([id]),
    CONSTRAINT [FK_ESHeartbeatStatus_ESHeartbeatLDescription] FOREIGN KEY ([description]) REFERENCES [dbo].[ESHeartbeatLDescription] ([id]),
    CONSTRAINT [FK_ESHeartbeatStatus_ESHeartbeatLStatus] FOREIGN KEY ([status]) REFERENCES [dbo].[ESHeartbeatLStatus] ([id]),
    CONSTRAINT [FK_ESHeartbeatStatus_ESHeartbeatLStatus1] FOREIGN KEY ([ping]) REFERENCES [dbo].[ESHeartbeatLStatus] ([id]),
    CONSTRAINT [FK_ESHeartbeatStatus_ESHeartbeatLStatus2] FOREIGN KEY ([agent]) REFERENCES [dbo].[ESHeartbeatLStatus] ([id]),
    CONSTRAINT [FK_ESHeartbeatStatus_ESHeartbeatLStatus3] FOREIGN KEY ([tcp]) REFERENCES [dbo].[ESHeartbeatLStatus] ([id])
);


GO
CREATE CLUSTERED INDEX [IDX_ES_HBStatus]
    ON [dbo].[ESHeartbeatStatus]([recorddate] ASC) WITH (FILLFACTOR = 80);

