CREATE TABLE [dbo].[ESPerformanceInstance] (
    [id]            INT           IDENTITY (1, 1) NOT NULL,
    [instance]      VARCHAR (255) NULL,
    [ESPerformance] INT           NULL,
    CONSTRAINT [PK_ESPerformanceInstance] PRIMARY KEY CLUSTERED ([id] ASC)
);

