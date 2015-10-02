CREATE TABLE [dbo].[ESPerformance] (
    [recorddate]   DATETIME   NULL,
    [computername] INT        NULL,
    [name]         INT        NULL,
    [counter]      INT        NULL,
    [instance]     INT        NULL,
    [data_low]     BIGINT     NULL,
    [data_high]    BIGINT     NULL,
    [groupname]    INT        NULL,
    [data_float]   FLOAT (53) NULL,
    [usefloat]     INT        NULL,
    CONSTRAINT [FK_ESPerformance_ESEventlogComputer] FOREIGN KEY ([computername]) REFERENCES [dbo].[ESEventlogComputer] ([id]),
    CONSTRAINT [FK_ESPerformance_ESPerformanceCounter] FOREIGN KEY ([counter]) REFERENCES [dbo].[ESPerformanceCounter] ([id]),
    CONSTRAINT [FK_ESPerformance_ESPerformanceInstance] FOREIGN KEY ([instance]) REFERENCES [dbo].[ESPerformanceInstance] ([id]),
    CONSTRAINT [FK_ESPerformance_ESPerformanceName] FOREIGN KEY ([name]) REFERENCES [dbo].[ESPerformanceName] ([id])
);


GO
CREATE CLUSTERED INDEX [IDX_ES_Performance]
    ON [dbo].[ESPerformance]([recorddate] ASC) WITH (FILLFACTOR = 80);


GO
CREATE NONCLUSTERED INDEX [IDX_ES_PERF_ENUMERATE]
    ON [dbo].[ESPerformance]([computername] ASC, [name] ASC, [instance] ASC);

