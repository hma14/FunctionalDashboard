CREATE TABLE [dbo].[ESServiceHistory] (
    [recorddate]         DATETIME NULL,
    [groupname]          INT      NULL,
    [computer]           INT      NULL,
    [service]            INT      NULL,
    [service_key]        INT      NULL,
    [status_old]         INT      NULL,
    [status_new]         INT      NULL,
    [startup_type]       INT      NULL,
    [startup_type_new]   INT      NULL,
    [serviceaccount_old] INT      NULL,
    [serviceaccount_new] INT      NULL,
    [executable_old]     INT      NULL,
    [executable_new]     INT      NULL,
    [isdriver]           INT      NULL,
    CONSTRAINT [FK_ESServiceHistory_ESESStrings2] FOREIGN KEY ([status_new]) REFERENCES [dbo].[ESStrings] ([id]),
    CONSTRAINT [FK_ESServiceHistory_ESEventlogComputer] FOREIGN KEY ([computer]) REFERENCES [dbo].[ESEventlogComputer] ([id]),
    CONSTRAINT [FK_ESServiceHistory_ESEventlogGroup] FOREIGN KEY ([groupname]) REFERENCES [dbo].[ESEventlogGroup] ([id]),
    CONSTRAINT [FK_ESServiceHistory_ESEventlogUser1] FOREIGN KEY ([serviceaccount_old]) REFERENCES [dbo].[ESEventlogUser] ([id]),
    CONSTRAINT [FK_ESServiceHistory_ESEventlogUser2] FOREIGN KEY ([serviceaccount_new]) REFERENCES [dbo].[ESEventlogUser] ([id]),
    CONSTRAINT [FK_ESServiceHistory_ESFile1] FOREIGN KEY ([executable_old]) REFERENCES [dbo].[ESFile] ([id]),
    CONSTRAINT [FK_ESServiceHistory_ESFile2] FOREIGN KEY ([executable_new]) REFERENCES [dbo].[ESFile] ([id]),
    CONSTRAINT [FK_ESServiceHistory_ESServiceKey] FOREIGN KEY ([service_key]) REFERENCES [dbo].[ESServiceKey] ([id]),
    CONSTRAINT [FK_ESServiceHistory_ESServiceName] FOREIGN KEY ([service]) REFERENCES [dbo].[ESServiceName] ([id]),
    CONSTRAINT [FK_ESServiceHistory_ESStrings1] FOREIGN KEY ([status_old]) REFERENCES [dbo].[ESStrings] ([id]),
    CONSTRAINT [FK_ESServiceHistory_ESStrings3] FOREIGN KEY ([startup_type]) REFERENCES [dbo].[ESStrings] ([id]),
    CONSTRAINT [FK_ESServiceHistory_ESStrings4] FOREIGN KEY ([startup_type_new]) REFERENCES [dbo].[ESStrings] ([id])
);


GO
CREATE CLUSTERED INDEX [IDX_ES_ServiceHistory]
    ON [dbo].[ESServiceHistory]([recorddate] ASC, [computer] ASC) WITH (FILLFACTOR = 80);

