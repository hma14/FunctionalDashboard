CREATE TABLE [dbo].[ESPerformanceCounter] (
    [id]            INT           IDENTITY (1, 1) NOT NULL,
    [counter]       VARCHAR (255) NULL,
    [ESPerformance] INT           NULL,
    CONSTRAINT [PK_ESPerformanceCounter] PRIMARY KEY CLUSTERED ([id] ASC)
);

