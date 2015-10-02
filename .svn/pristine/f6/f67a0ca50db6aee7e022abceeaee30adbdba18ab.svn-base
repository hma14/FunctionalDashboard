CREATE TABLE [dbo].[ESEventlogFilename] (
    [id]                      INT           IDENTITY (1, 1) NOT NULL,
    [filename]                VARCHAR (255) NULL,
    [ESPSTracking]            INT           NULL,
    [ESFlatFile]              INT           NULL,
    [ESFlatFileDelim]         INT           NULL,
    [ESFilemon]               INT           NULL,
    [ESObjectTracking]        INT           NULL,
    [ESObjectTrackingProcess] INT           NULL,
    CONSTRAINT [PK_ESEventlogFilename] PRIMARY KEY CLUSTERED ([id] ASC)
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IDX_ES_EventlogFilename]
    ON [dbo].[ESEventlogFilename]([filename] ASC) WITH (FILLFACTOR = 50);

