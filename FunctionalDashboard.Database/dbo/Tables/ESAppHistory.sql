CREATE TABLE [dbo].[ESAppHistory] (
    [recorddate]      DATETIME     NULL,
    [groupname]       INT          NULL,
    [computer]        INT          NULL,
    [application]     INT          NULL,
    [installdir]      INT          NULL,
    [publisher]       INT          NULL,
    [myaction]        INT          NULL,
    [myversion]       VARCHAR (32) NULL,
    [username]        INT          NULL,
    [iswindowsupdate] INT          NULL,
    [is64bit]         INT          NULL,
    [licensekey]      VARCHAR (64) NULL,
    CONSTRAINT [FK_ESAppHistory_ESAppName] FOREIGN KEY ([application]) REFERENCES [dbo].[ESAppName] ([id]),
    CONSTRAINT [FK_ESAppHistory_ESAppPublisher] FOREIGN KEY ([publisher]) REFERENCES [dbo].[ESAppPublisher] ([id]),
    CONSTRAINT [FK_ESAppHistory_ESEventlogComputer] FOREIGN KEY ([computer]) REFERENCES [dbo].[ESEventlogComputer] ([id]),
    CONSTRAINT [FK_ESAppHistory_ESEventlogFilepath] FOREIGN KEY ([installdir]) REFERENCES [dbo].[ESEventlogFilepath] ([id]),
    CONSTRAINT [FK_ESAppHistory_ESEventlogGroup] FOREIGN KEY ([groupname]) REFERENCES [dbo].[ESEventlogGroup] ([id]),
    CONSTRAINT [FK_ESAppHistory_ESEventlogUser] FOREIGN KEY ([username]) REFERENCES [dbo].[ESEventlogUser] ([id]),
    CONSTRAINT [FK_ESAppHistory_ESStrings] FOREIGN KEY ([myaction]) REFERENCES [dbo].[ESStrings] ([id])
);


GO
CREATE CLUSTERED INDEX [IDX_ES_AppHistory]
    ON [dbo].[ESAppHistory]([recorddate] ASC, [computer] ASC) WITH (FILLFACTOR = 80);

