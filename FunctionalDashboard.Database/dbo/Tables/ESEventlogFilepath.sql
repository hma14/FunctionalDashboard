CREATE TABLE [dbo].[ESEventlogFilepath] (
    [id]                      INT           IDENTITY (1, 1) NOT NULL,
    [filepath]                VARCHAR (255) NULL,
    [ESPSTracking]            INT           NULL,
    [ESApplication]           INT           NULL,
    [ESFlatFile]              INT           NULL,
    [ESFlatFileDelim]         INT           NULL,
    [ESFolderStatus]          INT           NULL,
    [ESFilemon]               INT           NULL,
    [ESObjectTracking]        INT           NULL,
    [ESObjectTrackingProcess] INT           NULL,
    [ESSysinfo]               INT           NULL,
    CONSTRAINT [PK_ESEventlogFilepath] PRIMARY KEY CLUSTERED ([id] ASC)
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IDX_ES_EventlogFilepath]
    ON [dbo].[ESEventlogFilepath]([filepath] ASC) WITH (FILLFACTOR = 50);

