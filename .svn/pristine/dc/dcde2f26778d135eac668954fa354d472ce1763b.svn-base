CREATE TABLE [dbo].[ESTrackingAccountGroups] (
    [recorddate_unix]     INT          NULL,
    [recorddate]          DATETIME     NULL,
    [computername]        INT          NULL,
    [ComputerProductType] VARCHAR (3)  NULL,
    [eventnumber]         BIGINT       NULL,
    [eventid]             INT          NULL,
    [group_operation]     INT          NULL,
    [group_type]          INT          NULL,
    [group_scope]         INT          NULL,
    [TargetAccount]       INT          NULL,
    [TargetDomain]        INT          NULL,
    [TargetAccountID]     INT          NULL,
    [TargetAccountSID]    INT          NULL,
    [CallerUser]          INT          NULL,
    [CallerDomain]        INT          NULL,
    [CallerLogonID]       VARCHAR (16) NULL,
    [CallerAccountID]     INT          NULL,
    [CallerAccountSID]    INT          NULL,
    [MemberName]          INT          NULL,
    [MemberAccountID]     INT          NULL,
    [GroupTypeChange]     INT          NULL,
    [SourceComputer]      INT          NULL,
    [SourceIP]            INT          NULL,
    CONSTRAINT [FK_ESTrackingAccountGroups_ESEventlogAccountDomain_Caller] FOREIGN KEY ([CallerDomain]) REFERENCES [dbo].[ESEventlogAccountDomain] ([id]),
    CONSTRAINT [FK_ESTrackingAccountGroups_ESEventlogAccountDomain_Target] FOREIGN KEY ([TargetDomain]) REFERENCES [dbo].[ESEventlogAccountDomain] ([id]),
    CONSTRAINT [FK_ESTrackingAccountGroups_ESEventlogAccountDomainGp] FOREIGN KEY ([TargetAccountID]) REFERENCES [dbo].[ESEventlogAccountDomainGp] ([id]),
    CONSTRAINT [FK_ESTrackingAccountGroups_ESEventlogAccountGroup] FOREIGN KEY ([TargetAccount]) REFERENCES [dbo].[ESEventlogAccountGroup] ([id]),
    CONSTRAINT [FK_ESTrackingAccountGroups_ESEventlogAccountUser_Caller] FOREIGN KEY ([CallerUser]) REFERENCES [dbo].[ESEventlogAccountUser] ([id]),
    CONSTRAINT [FK_ESTrackingAccountGroups_ESEventlogComputer] FOREIGN KEY ([computername]) REFERENCES [dbo].[ESEventlogComputer] ([id]),
    CONSTRAINT [FK_ESTrackingAccountGroups_ESEventlogComputer_Source] FOREIGN KEY ([SourceComputer]) REFERENCES [dbo].[ESEventlogComputer] ([id]),
    CONSTRAINT [FK_ESTrackingAccountGroups_ESEventlogSID_Caller] FOREIGN KEY ([CallerAccountSID]) REFERENCES [dbo].[ESEventlogSID] ([id]),
    CONSTRAINT [FK_ESTrackingAccountGroups_ESEventlogSID_Target] FOREIGN KEY ([TargetAccountSID]) REFERENCES [dbo].[ESEventlogSID] ([id]),
    CONSTRAINT [FK_ESTrackingAccountGroups_ESEventlogUser_Caller] FOREIGN KEY ([CallerAccountID]) REFERENCES [dbo].[ESEventlogUser] ([id]),
    CONSTRAINT [FK_ESTrackingAccountGroups_ESEventlogUser_Member] FOREIGN KEY ([MemberAccountID]) REFERENCES [dbo].[ESEventlogUser] ([id]),
    CONSTRAINT [FK_ESTrackingAccountGroups_ESEventlogUserDN] FOREIGN KEY ([MemberName]) REFERENCES [dbo].[ESEventlogUserDN] ([id]),
    CONSTRAINT [FK_ESTrackingAccountGroups_ESIPAddress] FOREIGN KEY ([SourceIP]) REFERENCES [dbo].[ESIPAddress] ([id])
);


GO
CREATE CLUSTERED INDEX [IDX_ES_TrackingAccountGroups]
    ON [dbo].[ESTrackingAccountGroups]([recorddate] ASC) WITH (FILLFACTOR = 80);

