CREATE TABLE [dbo].[ESTrackingLogonAuth] (
    [recorddate_unix]     INT         NULL,
    [recorddate]          DATETIME    NULL,
    [computername]        INT         NULL,
    [ComputerProductType] VARCHAR (3) NULL,
    [eventnumber]         BIGINT      NULL,
    [eventid]             INT         NULL,
    [AuthenticationType]  INT         NULL,
    [Protocol]            INT         NULL,
    [TargetAccount]       INT         NULL,
    [TargetDomain]        INT         NULL,
    [TargetEmail]         INT         NULL,
    [LogonGUID]           INT         NULL,
    [TargetAccountSID]    INT         NULL,
    [ServiceID]           INT         NULL,
    [SourceComputer]      INT         NULL,
    [SourcePort]          INT         NULL,
    [SourceIP]            INT         NULL,
    CONSTRAINT [FK_ESTrackingLogonAuth_ESEventlogAccountDomain] FOREIGN KEY ([TargetDomain]) REFERENCES [dbo].[ESEventlogAccountDomain] ([id]),
    CONSTRAINT [FK_ESTrackingLogonAuth_ESEventlogAccountUser] FOREIGN KEY ([TargetAccount]) REFERENCES [dbo].[ESEventlogAccountUser] ([id]),
    CONSTRAINT [FK_ESTrackingLogonAuth_ESEventlogComputer] FOREIGN KEY ([computername]) REFERENCES [dbo].[ESEventlogComputer] ([id]),
    CONSTRAINT [FK_ESTrackingLogonAuth_ESEventlogComputer_Source] FOREIGN KEY ([SourceComputer]) REFERENCES [dbo].[ESEventlogComputer] ([id]),
    CONSTRAINT [FK_ESTrackingLogonAuth_ESEventlogEmail] FOREIGN KEY ([TargetEmail]) REFERENCES [dbo].[ESEventlogEmail] ([id]),
    CONSTRAINT [FK_ESTrackingLogonAuth_ESEventlogGUID] FOREIGN KEY ([LogonGUID]) REFERENCES [dbo].[ESEventlogGUID] ([id]),
    CONSTRAINT [FK_ESTrackingLogonAuth_ESEventlogSID] FOREIGN KEY ([TargetAccountSID]) REFERENCES [dbo].[ESEventlogSID] ([id]),
    CONSTRAINT [FK_ESTrackingLogonAuth_ESEventlogUser] FOREIGN KEY ([ServiceID]) REFERENCES [dbo].[ESEventlogUser] ([id]),
    CONSTRAINT [FK_ESTrackingLogonAuth_ESIPAddress] FOREIGN KEY ([SourceIP]) REFERENCES [dbo].[ESIPAddress] ([id]),
    CONSTRAINT [FK_ESTrackingLogonAuth_ESStrings_AuthType] FOREIGN KEY ([AuthenticationType]) REFERENCES [dbo].[ESStrings] ([id]),
    CONSTRAINT [FK_ESTrackingLogonAuth_ESStrings_Protocol] FOREIGN KEY ([Protocol]) REFERENCES [dbo].[ESStrings] ([id])
);


GO
CREATE CLUSTERED INDEX [IDX_ES_TrackingLogonAuth]
    ON [dbo].[ESTrackingLogonAuth]([recorddate] ASC) WITH (FILLFACTOR = 80);


GO
CREATE NONCLUSTERED INDEX [IDX_ES_TrackingLogonAuth_Computer]
    ON [dbo].[ESTrackingLogonAuth]([computername] ASC) WITH (FILLFACTOR = 80);

