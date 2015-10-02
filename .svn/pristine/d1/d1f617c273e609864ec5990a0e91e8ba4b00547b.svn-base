CREATE TABLE [dbo].[ESEventlogUser] (
    [id]                            INT           IDENTITY (1, 1) NOT NULL,
    [eventuser]                     VARCHAR (767) NULL,
    [ESEventlogMain]                INT           NULL,
    [ESPSTracking]                  INT           NULL,
    [ESEventlogComments]            INT           NULL,
    [ESPrintTracking]               INT           NULL,
    [ESLogonTracking]               INT           NULL,
    [ESHeartbeat]                   INT           NULL,
    [ESObjectTracking]              INT           NULL,
    [ESTrackingAccountGroups]       INT           NULL,
    [ESTrackingAccountGroupsCaller] INT           NULL,
    [ESTrackingAccountComputersClr] INT           NULL,
    [ESTrackingAccountUsers]        INT           NULL,
    [ESTrackingAccountUsersCaller]  INT           NULL,
    [ESTrackingPolicy]              INT           NULL,
    [ESTrackingPolicyCaller]        INT           NULL,
    [ESTrackingAuthFailure]         INT           NULL,
    [ESApplication]                 INT           NULL,
    [ESTrackingLogonByType]         INT           NULL,
    [ESTrackingLogonAuth]           INT           NULL,
    [ESTrackingLogonAuthService]    INT           NULL,
    [ESService]                     INT           NULL,
    [ESUptimeHistory]               INT           NULL,
    [ESScheduledTasks]              INT           NULL,
    CONSTRAINT [PK_ESEventlogUser] PRIMARY KEY CLUSTERED ([id] ASC)
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IDX_ES_EventlogUser]
    ON [dbo].[ESEventlogUser]([eventuser] ASC) WITH (FILLFACTOR = 50);

