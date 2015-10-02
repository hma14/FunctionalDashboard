CREATE TABLE [dbo].[ESTrackingAccountUsers] (
    [recorddate_unix]     INT          NULL,
    [recorddate]          DATETIME     NULL,
    [computername]        INT          NULL,
    [eventnumber]         BIGINT       NULL,
    [eventid]             INT          NULL,
    [user_operation]      INT          NULL,
    [TargetAccount]       INT          NULL,
    [TargetDomain]        INT          NULL,
    [TargetAccountID]     INT          NULL,
    [TargetAccountSID]    INT          NULL,
    [CallerComputerName]  INT          NULL,
    [CallerUser]          INT          NULL,
    [CallerDomain]        INT          NULL,
    [CallerAccountID]     INT          NULL,
    [CallerAccountSID]    INT          NULL,
    [CallerLogonID]       VARCHAR (16) NULL,
    [UserTypeChange]      INT          NULL,
    [SourceComputer]      INT          NULL,
    [SourceIP]            INT          NULL,
    [ComputerProductType] VARCHAR (3)  NULL,
    CONSTRAINT [FK_ESTrackingAccountUsers_ESEventlogAccountDomain_Target] FOREIGN KEY ([TargetDomain]) REFERENCES [dbo].[ESEventlogAccountDomain] ([id]),
    CONSTRAINT [FK_ESTrackingAccountUsers_ESEventlogAccountUser_Caller] FOREIGN KEY ([CallerUser]) REFERENCES [dbo].[ESEventlogAccountUser] ([id]),
    CONSTRAINT [FK_ESTrackingAccountUsers_ESEventlogAccountUser_Target] FOREIGN KEY ([TargetAccount]) REFERENCES [dbo].[ESEventlogAccountUser] ([id]),
    CONSTRAINT [FK_ESTrackingAccountUsers_ESEventlogComputer] FOREIGN KEY ([computername]) REFERENCES [dbo].[ESEventlogComputer] ([id]),
    CONSTRAINT [FK_ESTrackingAccountUsers_ESEventlogComputer_Caller] FOREIGN KEY ([CallerComputerName]) REFERENCES [dbo].[ESEventlogComputer] ([id]),
    CONSTRAINT [FK_ESTrackingAccountUsers_ESEventlogComputer_Source] FOREIGN KEY ([SourceComputer]) REFERENCES [dbo].[ESEventlogComputer] ([id]),
    CONSTRAINT [FK_ESTrackingAccountUsers_ESEventlogSID_Caller] FOREIGN KEY ([CallerAccountSID]) REFERENCES [dbo].[ESEventlogSID] ([id]),
    CONSTRAINT [FK_ESTrackingAccountUsers_ESEventlogSID_Target] FOREIGN KEY ([TargetAccountSID]) REFERENCES [dbo].[ESEventlogSID] ([id]),
    CONSTRAINT [FK_ESTrackingAccountUsers_ESEventlogUser_Caller] FOREIGN KEY ([CallerAccountID]) REFERENCES [dbo].[ESEventlogUser] ([id]),
    CONSTRAINT [FK_ESTrackingAccountUsers_ESEventlogUser_Target] FOREIGN KEY ([TargetAccountID]) REFERENCES [dbo].[ESEventlogUser] ([id]),
    CONSTRAINT [FK_ESTrackingAccountUsers_ESIPAddress] FOREIGN KEY ([SourceIP]) REFERENCES [dbo].[ESIPAddress] ([id]),
    CONSTRAINT [FK_ESTrackingAccountUsers_ESStrings] FOREIGN KEY ([UserTypeChange]) REFERENCES [dbo].[ESStrings] ([id])
);


GO
CREATE CLUSTERED INDEX [IDX_ES_TrackingAccountUsers]
    ON [dbo].[ESTrackingAccountUsers]([recorddate] ASC) WITH (FILLFACTOR = 80);

