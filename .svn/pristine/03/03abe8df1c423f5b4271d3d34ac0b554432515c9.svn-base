CREATE TABLE [dbo].[ESPerformanceMapping] (
    [recorddate]            DATETIME   NULL,
    [computername]          INT        NULL,
    [name]                  INT        NULL,
    [counter]               INT        NULL,
    [instance]              INT        NULL,
    [alert_type]            INT        NULL,
    [alert_limit]           INT        NULL,
    [alert_limit_float]     FLOAT (53) NULL,
    [alert_limit_max]       INT        NULL,
    [alert_limit_max_float] FLOAT (53) NULL,
    [groupname]             INT        NULL,
    [usefloat]              INT        NULL,
    [data_last_float]       FLOAT (53) NULL,
    [data_last_int]         BIGINT     NULL,
    [description]           INT        NULL,
    CONSTRAINT [FK_ESPerformanceMapping_ESEventlogComputer] FOREIGN KEY ([computername]) REFERENCES [dbo].[ESEventlogComputer] ([id]),
    CONSTRAINT [FK_ESPerformanceMapping_ESEventlogGroup] FOREIGN KEY ([groupname]) REFERENCES [dbo].[ESEventlogGroup] ([id]),
    CONSTRAINT [FK_ESPerformanceMapping_ESPerformanceCounter] FOREIGN KEY ([counter]) REFERENCES [dbo].[ESPerformanceCounter] ([id]),
    CONSTRAINT [FK_ESPerformanceMapping_ESPerformanceInstance] FOREIGN KEY ([instance]) REFERENCES [dbo].[ESPerformanceInstance] ([id]),
    CONSTRAINT [FK_ESPerformanceMapping_ESPerformanceName] FOREIGN KEY ([name]) REFERENCES [dbo].[ESPerformanceName] ([id])
);


GO
CREATE CLUSTERED INDEX [IDX_ES_ESPerformanceMapping]
    ON [dbo].[ESPerformanceMapping]([computername] ASC) WITH (FILLFACTOR = 80);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IDX_ES_PerformanceMapping_Unique]
    ON [dbo].[ESPerformanceMapping]([computername] ASC, [name] ASC, [counter] ASC, [instance] ASC);

