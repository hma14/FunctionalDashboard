CREATE TABLE [dbo].[ESEventlogSource] (
    [id]                     INT           IDENTITY (1, 1) NOT NULL,
    [eventsource]            VARCHAR (196) NULL,
    [ESEventlogMain]         INT           NULL,
    [ESHeartbeat]            INT           NULL,
    [ESActionTriggerHistory] INT           NULL,
    CONSTRAINT [PK_ESEventlogSource] PRIMARY KEY CLUSTERED ([id] ASC)
);

