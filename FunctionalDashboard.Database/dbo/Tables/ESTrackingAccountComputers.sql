CREATE TABLE [dbo].[ESTrackingAccountComputers] (
    [recorddate_unix]    INT          NULL,
    [recorddate]         DATETIME     NULL,
    [computername]       INT          NULL,
    [eventnumber]        BIGINT       NULL,
    [eventid]            INT          NULL,
    [computer_operation] INT          NULL,
    [TargetAccount]      INT          NULL,
    [TargetDomain]       INT          NULL,
    [TargetAccountID]    INT          NULL,
    [TargetAccountSID]   INT          NULL,
    [CallerUser]         INT          NULL,
    [CallerDomain]       INT          NULL,
    [CallerLogonID]      VARCHAR (16) NULL,
    [CallerAccountID]    INT          NULL,
    [CallerAccountSID]   INT          NULL,
    [ComputerTypeChange] INT          NULL,
    [SourceComputer]     INT          NULL,
    [SourceIP]           INT          NULL,
    CONSTRAINT [FK_ESTrackingAccountComputers_ESEventlogAccountDomain_Caller] FOREIGN KEY ([CallerDomain]) REFERENCES [dbo].[ESEventlogAccountDomain] ([id]),
    CONSTRAINT [FK_ESTrackingAccountComputers_ESEventlogAccountDomain_Target] FOREIGN KEY ([TargetDomain]) REFERENCES [dbo].[ESEventlogAccountDomain] ([id]),
    CONSTRAINT [FK_ESTrackingAccountComputers_ESEventlogAccountDomainGp] FOREIGN KEY ([TargetAccountID]) REFERENCES [dbo].[ESEventlogAccountDomainGp] ([id]),
    CONSTRAINT [FK_ESTrackingAccountComputers_ESEventlogAccountUser_Caller] FOREIGN KEY ([CallerUser]) REFERENCES [dbo].[ESEventlogAccountUser] ([id]),
    CONSTRAINT [FK_ESTrackingAccountComputers_ESEventlogComputer] FOREIGN KEY ([computername]) REFERENCES [dbo].[ESEventlogComputer] ([id]),
    CONSTRAINT [FK_ESTrackingAccountComputers_ESEventlogComputer_Source] FOREIGN KEY ([SourceComputer]) REFERENCES [dbo].[ESEventlogComputer] ([id]),
    CONSTRAINT [FK_ESTrackingAccountComputers_ESEventlogComputer_Target] FOREIGN KEY ([TargetAccount]) REFERENCES [dbo].[ESEventlogComputer] ([id]),
    CONSTRAINT [FK_ESTrackingAccountComputers_ESEventlogSID_Caller] FOREIGN KEY ([CallerAccountSID]) REFERENCES [dbo].[ESEventlogSID] ([id]),
    CONSTRAINT [FK_ESTrackingAccountComputers_ESEventlogSID_Target] FOREIGN KEY ([TargetAccountSID]) REFERENCES [dbo].[ESEventlogSID] ([id]),
    CONSTRAINT [FK_ESTrackingAccountComputers_ESEventlogUser_Caller] FOREIGN KEY ([CallerAccountID]) REFERENCES [dbo].[ESEventlogUser] ([id]),
    CONSTRAINT [FK_ESTrackingAccountComputers_ESIPAddress] FOREIGN KEY ([SourceIP]) REFERENCES [dbo].[ESIPAddress] ([id])
);


GO
CREATE CLUSTERED INDEX [IDX_ES_TrackingAccountComputers]
    ON [dbo].[ESTrackingAccountComputers]([recorddate] ASC) WITH (FILLFACTOR = 80);

