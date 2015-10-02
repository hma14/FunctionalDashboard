CREATE TABLE [dbo].[ESActionTriggerHistory] (
    [recorddate]        DATETIME NULL,
    [computername]      INT      NULL,
    [Action]            INT      NULL,
    [ActionRecipients]  INT      NULL,
    [ActionType]        INT      NULL,
    [EventLogPackage]   INT      NULL,
    [EventLogFilter]    INT      NULL,
    [EventLog]          INT      NULL,
    [EventID]           INT      NULL,
    [EventSource]       INT      NULL,
    [EventRecordNumber] BIGINT   NULL
);


GO
CREATE CLUSTERED INDEX [IDX_ES_ActionTriggerHistory]
    ON [dbo].[ESActionTriggerHistory]([recorddate] ASC) WITH (FILLFACTOR = 80);

