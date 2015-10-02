CREATE TABLE [dbo].[ESTrackingAuthFailure] (
    [recorddate_unix]     INT         NULL,
    [recorddate]          DATETIME    NULL,
    [computername]        INT         NULL,
    [ComputerProductType] VARCHAR (3) NULL,
    [eventnumber]         BIGINT      NULL,
    [eventid]             INT         NULL,
    [Protocol]            INT         NULL,
    [AuthenticationType]  INT         NULL,
    [SourceComputer]      INT         NULL,
    [SourceIP]            INT         NULL,
    [SourcePort]          INT         NULL,
    [TargetAccount]       INT         NULL,
    [TargetDomain]        INT         NULL,
    [TargetAccountID]     INT         NULL,
    [FailureReason]       INT         NULL,
    [FailureReasonNum]    INT         NULL,
    CONSTRAINT [FK_ESTrackingAuthFailure_ESEventlogAccountDomain] FOREIGN KEY ([TargetDomain]) REFERENCES [dbo].[ESEventlogAccountDomain] ([id]),
    CONSTRAINT [FK_ESTrackingAuthFailure_ESEventlogAccountUser] FOREIGN KEY ([TargetAccount]) REFERENCES [dbo].[ESEventlogAccountUser] ([id]),
    CONSTRAINT [FK_ESTrackingAuthFailure_ESEventlogComputer] FOREIGN KEY ([computername]) REFERENCES [dbo].[ESEventlogComputer] ([id]),
    CONSTRAINT [FK_ESTrackingAuthFailure_ESEventlogComputer_Source] FOREIGN KEY ([SourceComputer]) REFERENCES [dbo].[ESEventlogComputer] ([id]),
    CONSTRAINT [FK_ESTrackingAuthFailure_ESEventlogUser] FOREIGN KEY ([TargetAccountID]) REFERENCES [dbo].[ESEventlogUser] ([id]),
    CONSTRAINT [FK_ESTrackingAuthFailure_ESIPAddress] FOREIGN KEY ([SourceIP]) REFERENCES [dbo].[ESIPAddress] ([id]),
    CONSTRAINT [FK_ESTrackingAuthFailure_ESStrings_AuthType] FOREIGN KEY ([AuthenticationType]) REFERENCES [dbo].[ESStrings] ([id]),
    CONSTRAINT [FK_ESTrackingAuthFailure_ESStrings_FailureReason] FOREIGN KEY ([FailureReason]) REFERENCES [dbo].[ESStrings] ([id]),
    CONSTRAINT [FK_ESTrackingAuthFailure_ESStrings_Protocol] FOREIGN KEY ([Protocol]) REFERENCES [dbo].[ESStrings] ([id])
);


GO
CREATE CLUSTERED INDEX [IDX_ES_TrackingAuthFailure]
    ON [dbo].[ESTrackingAuthFailure]([recorddate] ASC) WITH (FILLFACTOR = 80);


GO
CREATE NONCLUSTERED INDEX [IDX_ES_TrackingAuthFailure_Computer]
    ON [dbo].[ESTrackingAuthFailure]([computername] ASC) WITH (FILLFACTOR = 80);

