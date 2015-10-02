CREATE TABLE [dbo].[ESServiceStatus] (
    [recorddate]     DATETIME NULL,
    [pid]            INT      NULL,
    [groupname]      INT      NULL,
    [computer]       INT      NULL,
    [service]        INT      NULL,
    [service_key]    INT      NULL,
    [status]         INT      NULL,
    [isdriver]       INT      NULL,
    [startup_type]   INT      NULL,
    [serviceaccount] INT      NULL,
    [executable]     INT      NULL,
    CONSTRAINT [FK_ESServiceStatus_ESEventlogComputer] FOREIGN KEY ([computer]) REFERENCES [dbo].[ESEventlogComputer] ([id]),
    CONSTRAINT [FK_ESServiceStatus_ESEventlogGroup] FOREIGN KEY ([groupname]) REFERENCES [dbo].[ESEventlogGroup] ([id]),
    CONSTRAINT [FK_ESServiceStatus_ESEventlogUser] FOREIGN KEY ([serviceaccount]) REFERENCES [dbo].[ESEventlogUser] ([id]),
    CONSTRAINT [FK_ESServiceStatus_ESFile] FOREIGN KEY ([executable]) REFERENCES [dbo].[ESFile] ([id]),
    CONSTRAINT [FK_ESServiceStatus_ESServiceKey] FOREIGN KEY ([service_key]) REFERENCES [dbo].[ESServiceKey] ([id]),
    CONSTRAINT [FK_ESServiceStatus_ESServiceName] FOREIGN KEY ([service]) REFERENCES [dbo].[ESServiceName] ([id]),
    CONSTRAINT [FK_ESServiceStatus_ESStrings] FOREIGN KEY ([status]) REFERENCES [dbo].[ESStrings] ([id]),
    CONSTRAINT [FK_ESServiceStatus_ESStrings_startuptype] FOREIGN KEY ([startup_type]) REFERENCES [dbo].[ESStrings] ([id])
);


GO
CREATE CLUSTERED INDEX [IDX_ES_ServiceStatus]
    ON [dbo].[ESServiceStatus]([recorddate] ASC, [computer] ASC) WITH (FILLFACTOR = 80);


GO
CREATE NONCLUSTERED INDEX [IDX_ES_ServiceStatus_ComputerServicekey]
    ON [dbo].[ESServiceStatus]([computer] ASC, [service_key] ASC);

