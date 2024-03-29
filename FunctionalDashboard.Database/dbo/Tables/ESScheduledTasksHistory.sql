﻿CREATE TABLE [dbo].[ESScheduledTasksHistory] (
    [recorddate]       DATETIME       NULL,
    [id]               INT            IDENTITY (1, 1) NOT NULL,
    [action]           CHAR (1)       NULL,
    [enabled]          INT            NULL,
    [taskName]         VARCHAR (255)  NULL,
    [userName]         INT            NULL,
    [strLastRunResult] VARCHAR (255)  NULL,
    [strLastRunTime]   VARCHAR (128)  NULL,
    [numLastRunResult] INT            NULL,
    [numLastRunTime]   BIGINT         NULL,
    [actionCount]      INT            NULL,
    [actions]          VARCHAR (1024) NULL,
    [triggerCount]     INT            NULL,
    [triggers]         VARCHAR (1024) NULL,
    [state]            VARCHAR (64)   NULL,
    [computer]         INT            NULL,
    [field_changed]    VARCHAR (128)  NULL,
    [field_old]        VARCHAR (512)  NULL,
    [field_new]        VARCHAR (512)  NULL,
    CONSTRAINT [PK_ESScheduledTasksHistory] PRIMARY KEY CLUSTERED ([id] ASC),
    CONSTRAINT [FK_ESScheduledTasksHistory_ESEventlogComputer] FOREIGN KEY ([computer]) REFERENCES [dbo].[ESEventlogComputer] ([id]),
    CONSTRAINT [FK_ESScheduledTasksHistory_ESEventlogUser] FOREIGN KEY ([userName]) REFERENCES [dbo].[ESEventlogUser] ([id])
);

