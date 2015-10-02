CREATE TABLE [dbo].[ESPerformanceTrend] (
    [recorddate]   DATETIME   NULL,
    [computername] INT        NULL,
    [name]         INT        NULL,
    [counter]      INT        NULL,
    [instance]     INT        NULL,
    [day]          INT        NULL,
    [hour]         INT        NULL,
    [hour_period]  INT        NULL,
    [usefloat]     INT        NULL,
    [data_points]  INT        NULL,
    [data]         FLOAT (53) NULL,
    CONSTRAINT [FK_ESPerformanceTrend_ESEventlogComputer] FOREIGN KEY ([computername]) REFERENCES [dbo].[ESEventlogComputer] ([id]),
    CONSTRAINT [FK_ESPerformanceTrend_ESPerformanceCounter] FOREIGN KEY ([counter]) REFERENCES [dbo].[ESPerformanceCounter] ([id]),
    CONSTRAINT [FK_ESPerformanceTrend_ESPerformanceInstance] FOREIGN KEY ([instance]) REFERENCES [dbo].[ESPerformanceInstance] ([id]),
    CONSTRAINT [FK_ESPerformanceTrend_ESPerformanceName] FOREIGN KEY ([name]) REFERENCES [dbo].[ESPerformanceName] ([id])
);


GO
CREATE NONCLUSTERED INDEX [IDX_ES_PerformanceTrend]
    ON [dbo].[ESPerformanceTrend]([computername] ASC, [name] ASC, [counter] ASC, [instance] ASC);


GO
CREATE NONCLUSTERED INDEX [IDX_ES_PerformanceTrend_Computer]
    ON [dbo].[ESPerformanceTrend]([computername] ASC) WITH (FILLFACTOR = 80);

