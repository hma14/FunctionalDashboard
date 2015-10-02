CREATE TABLE [dbo].[ESEventlogGroup] (
    [id]                    INT           IDENTITY (1, 1) NOT NULL,
    [groupname]             VARCHAR (128) NULL,
    [ESEventlogMain]        INT           NULL,
    [ESHeartbeat]           INT           NULL,
    [ESService]             INT           NULL,
    [ESApplication]         INT           NULL,
    [ESPerformance]         INT           NULL,
    [ESDiskspace]           INT           NULL,
    [ESSysinfo]             INT           NULL,
    [ESUptimeHistory]       INT           NULL,
    [ESLogonTracking]       INT           NULL,
    [ESPSTracking]          INT           NULL,
    [ESDiskspaceLargeFiles] INT           NULL,
    CONSTRAINT [PK_ESEventlogGroup] PRIMARY KEY CLUSTERED ([id] ASC)
);

