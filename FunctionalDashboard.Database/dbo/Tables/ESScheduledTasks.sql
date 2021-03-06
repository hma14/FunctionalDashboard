﻿CREATE TABLE [dbo].[ESScheduledTasks] (
    [recorddate]                   DATETIME       NULL,
    [enabled]                      INT            NULL,
    [taskName]                     INT            NULL,
    [userName]                     INT            NULL,
    [strLastRunResult]             VARCHAR (255)  NULL,
    [strLastRunTime]               VARCHAR (128)  NULL,
    [numLastRunResult]             INT            NULL,
    [numLastRunTime]               BIGINT         NULL,
    [actionCount]                  INT            NULL,
    [actions]                      VARCHAR (1024) NULL,
    [triggerCount]                 INT            NULL,
    [triggers]                     VARCHAR (1024) NULL,
    [state]                        VARCHAR (64)   NULL,
    [computer]                     INT            NULL,
    [hasLogonTrigger]              INT            NULL,
    [hasEventTrigger]              INT            NULL,
    [hasTimeTrigger]               INT            NULL,
    [hasBootTrigger]               INT            NULL,
    [hasSessionStateChangeTrigger] INT            NULL,
    [hasOtherTriggers]             INT            NULL,
    CONSTRAINT [FK_ESScheduledTasks_ESEventlogComputer] FOREIGN KEY ([computer]) REFERENCES [dbo].[ESEventlogComputer] ([id]),
    CONSTRAINT [FK_ESScheduledTasks_ESEventlogUser] FOREIGN KEY ([userName]) REFERENCES [dbo].[ESEventlogUser] ([id]),
    CONSTRAINT [FK_ESScheduledTasks_ESScheduledTasksName] FOREIGN KEY ([taskName]) REFERENCES [dbo].[ESScheduledTasksName] ([id])
);

