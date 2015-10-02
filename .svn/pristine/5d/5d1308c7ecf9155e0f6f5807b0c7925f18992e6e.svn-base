CREATE TABLE [dbo].[ESLogonTracking] (
    [computername]        INT          NULL,
    [username]            INT          NULL,
    [start_unix]          INT          NULL,
    [start_datetime]      DATETIME     NULL,
    [duration]            INT          NULL,
    [incomplete]          INT          NULL,
    [LogonID]             VARCHAR (16) NULL,
    [LogonType]           INT          NULL,
    [SourceIP]            INT          NULL,
    [SourceComputer]      INT          NULL,
    [SourcePort]          INT          NULL,
    [RemoteDesktopState]  INT          NULL,
    [HasConnections]      INT          NULL,
    [IsSession]           INT          NULL,
    [IsAdmin]             INT          NULL,
    [ComputerProductType] VARCHAR (3)  NULL,
    [groupname]           INT          NULL,
    [eventid]             INT          NULL,
    [eventnumber]         BIGINT       NULL,
    CONSTRAINT [FK_ESLogonTracking_ESEventlogComputer] FOREIGN KEY ([computername]) REFERENCES [dbo].[ESEventlogComputer] ([id]),
    CONSTRAINT [FK_ESLogonTracking_ESEventlogGroup] FOREIGN KEY ([groupname]) REFERENCES [dbo].[ESEventlogGroup] ([id]),
    CONSTRAINT [FK_ESLogonTracking_ESEventlogUser] FOREIGN KEY ([username]) REFERENCES [dbo].[ESEventlogUser] ([id]),
    CONSTRAINT [FK_ESLogonTracking_ESIPAddress] FOREIGN KEY ([SourceIP]) REFERENCES [dbo].[ESIPAddress] ([id])
);


GO
CREATE CLUSTERED INDEX [IDX_ES_LogonTracking]
    ON [dbo].[ESLogonTracking]([start_datetime] ASC) WITH (FILLFACTOR = 80);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IDX_ES_LogonTracking_Unique]
    ON [dbo].[ESLogonTracking]([computername] ASC, [username] ASC, [start_unix] ASC, [LogonID] ASC);

