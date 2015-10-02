CREATE TABLE [dbo].[ESAppStatus] (
    [recorddate]      DATETIME     NULL,
    [installdate]     DATETIME     NULL,
    [groupname]       INT          NULL,
    [computer]        INT          NULL,
    [application]     INT          NULL,
    [installdir]      INT          NULL,
    [publisher]       INT          NULL,
    [myversion]       VARCHAR (32) NULL,
    [iswindowsupdate] INT          NULL,
    [is64bit]         INT          NULL,
    [licensekey]      VARCHAR (64) NULL,
    CONSTRAINT [FK_ESAppStatus_ESAppName] FOREIGN KEY ([application]) REFERENCES [dbo].[ESAppName] ([id]),
    CONSTRAINT [FK_ESAppStatus_ESAppPublisher] FOREIGN KEY ([publisher]) REFERENCES [dbo].[ESAppPublisher] ([id]),
    CONSTRAINT [FK_ESAppStatus_ESEventlogComputer] FOREIGN KEY ([computer]) REFERENCES [dbo].[ESEventlogComputer] ([id]),
    CONSTRAINT [FK_ESAppStatus_ESEventlogFilepath] FOREIGN KEY ([installdir]) REFERENCES [dbo].[ESEventlogFilepath] ([id]),
    CONSTRAINT [FK_ESAppStatus_ESEventlogGroup] FOREIGN KEY ([groupname]) REFERENCES [dbo].[ESEventlogGroup] ([id])
);


GO
CREATE CLUSTERED INDEX [IDX_ES_AppStatus]
    ON [dbo].[ESAppStatus]([recorddate] ASC, [computer] ASC) WITH (FILLFACTOR = 80);

