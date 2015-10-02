CREATE TABLE [dbo].[ESEventlogID] (
    [id]                     INT          IDENTITY (1, 1) NOT NULL,
    [eventid]                VARCHAR (10) NULL,
    [ESEventlogMain]         INT          NULL,
    [ESHeartbeat]            INT          NULL,
    [ESActionTriggerHistory] INT          NULL,
    CONSTRAINT [PK_ESEventlogID] PRIMARY KEY CLUSTERED ([id] ASC)
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IDX_ES_EventlogID]
    ON [dbo].[ESEventlogID]([eventid] ASC) WITH (FILLFACTOR = 80);

