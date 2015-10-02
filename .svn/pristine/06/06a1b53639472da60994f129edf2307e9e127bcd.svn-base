CREATE TABLE [dbo].[ESTrackingLogonByType] (
    [recorddate_unix]     INT          NULL,
    [recorddate]          DATETIME     NULL,
    [computername]        INT          NULL,
    [ComputerProductType] VARCHAR (3)  NULL,
    [eventnumber]         BIGINT       NULL,
    [eventid]             INT          NULL,
    [LogonAction]         INT          NULL,
    [LogonActionFailed]   INT          NULL,
    [LogonType]           INT          NULL,
    [TargetAccount]       INT          NULL,
    [TargetDomain]        INT          NULL,
    [TargetAccountID]     INT          NULL,
    [TargetAccountSID]    INT          NULL,
    [LogonProcess]        INT          NULL,
    [LogonID]             VARCHAR (16) NULL,
    [SourceIP]            INT          NULL,
    [SourceComputer]      INT          NULL,
    [SourcePort]          INT          NULL,
    [FailureReason]       INT          NULL,
    CONSTRAINT [FK_ESTrackingLogonByType_ESEventlogAccountDomain] FOREIGN KEY ([TargetDomain]) REFERENCES [dbo].[ESEventlogAccountDomain] ([id]),
    CONSTRAINT [FK_ESTrackingLogonByType_ESEventlogAccountUser] FOREIGN KEY ([TargetAccount]) REFERENCES [dbo].[ESEventlogAccountUser] ([id]),
    CONSTRAINT [FK_ESTrackingLogonByType_ESEventlogComputer] FOREIGN KEY ([computername]) REFERENCES [dbo].[ESEventlogComputer] ([id]),
    CONSTRAINT [FK_ESTrackingLogonByType_ESEventlogComputer_Source] FOREIGN KEY ([SourceComputer]) REFERENCES [dbo].[ESEventlogComputer] ([id]),
    CONSTRAINT [FK_ESTrackingLogonByType_ESEventlogSID] FOREIGN KEY ([TargetAccountSID]) REFERENCES [dbo].[ESEventlogSID] ([id]),
    CONSTRAINT [FK_ESTrackingLogonByType_ESEventlogUser] FOREIGN KEY ([TargetAccountID]) REFERENCES [dbo].[ESEventlogUser] ([id]),
    CONSTRAINT [FK_ESTrackingLogonByType_ESIPAddress] FOREIGN KEY ([SourceIP]) REFERENCES [dbo].[ESIPAddress] ([id]),
    CONSTRAINT [FK_ESTrackingLogonByType_ESStrings_FailureReason] FOREIGN KEY ([FailureReason]) REFERENCES [dbo].[ESStrings] ([id]),
    CONSTRAINT [FK_ESTrackingLogonByType_ESStrings_LogonProcess] FOREIGN KEY ([LogonProcess]) REFERENCES [dbo].[ESStrings] ([id]),
    CONSTRAINT [FK_ESTrackingLogonByType_ESStrings_LogonType] FOREIGN KEY ([LogonType]) REFERENCES [dbo].[ESStrings] ([id])
);


GO
CREATE CLUSTERED INDEX [IDX_ES_TrackingLogonByType]
    ON [dbo].[ESTrackingLogonByType]([recorddate] ASC) WITH (FILLFACTOR = 80);


GO
CREATE NONCLUSTERED INDEX [IDX_ES_TrackingLogonByType_Computer]
    ON [dbo].[ESTrackingLogonByType]([computername] ASC) WITH (FILLFACTOR = 80);


GO
CREATE NONCLUSTERED INDEX [IDX_ES_TrackingLogonByType_LogonActionFailed]
    ON [dbo].[ESTrackingLogonByType]([LogonActionFailed] ASC) WITH (FILLFACTOR = 80);

