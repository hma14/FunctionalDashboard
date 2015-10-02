CREATE TABLE [dbo].[ESSyslogMain] (
    [recorddate]   DATETIME       NULL,
    [isTcp]        INT            NULL,
    [computername] INT            NULL,
    [remotehost]   INT            NULL,
    [facility]     INT            NULL,
    [severity]     INT            NULL,
    [message]      VARCHAR (7400) NULL,
    CONSTRAINT [FK_ESSyslogMain_ESEventlogComputer] FOREIGN KEY ([computername]) REFERENCES [dbo].[ESEventlogComputer] ([id]),
    CONSTRAINT [FK_ESSyslogMain_ESSyslogFacility] FOREIGN KEY ([facility]) REFERENCES [dbo].[ESSyslogFacility] ([id]),
    CONSTRAINT [FK_ESSyslogMain_ESSyslogHost] FOREIGN KEY ([remotehost]) REFERENCES [dbo].[ESEventlogComputer] ([id]),
    CONSTRAINT [FK_ESSyslogMain_ESSyslogSeverity] FOREIGN KEY ([severity]) REFERENCES [dbo].[ESSyslogSeverity] ([id])
);


GO
CREATE CLUSTERED INDEX [IDX_ES_SyslogMain]
    ON [dbo].[ESSyslogMain]([recorddate] ASC) WITH (FILLFACTOR = 80);


GO
CREATE NONCLUSTERED INDEX [IDX_ESSyslogMain_computername]
    ON [dbo].[ESSyslogMain]([computername] ASC) WITH (FILLFACTOR = 80);


GO
CREATE NONCLUSTERED INDEX [IDX_ESSyslogMain_facility]
    ON [dbo].[ESSyslogMain]([facility] ASC) WITH (FILLFACTOR = 80);


GO
CREATE NONCLUSTERED INDEX [IDX_ESSyslogMain_remotehost]
    ON [dbo].[ESSyslogMain]([remotehost] ASC) WITH (FILLFACTOR = 80);


GO
CREATE NONCLUSTERED INDEX [IDX_ESSyslogMain_severity]
    ON [dbo].[ESSyslogMain]([severity] ASC) WITH (FILLFACTOR = 80);

