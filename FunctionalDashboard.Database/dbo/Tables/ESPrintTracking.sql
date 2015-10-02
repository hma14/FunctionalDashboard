CREATE TABLE [dbo].[ESPrintTracking] (
    [computername]   INT      NULL,
    [username]       INT      NULL,
    [start_unix]     INT      NULL,
    [start_datetime] DATETIME NULL,
    [printer]        INT      NULL,
    [document_name]  INT      NULL,
    [document_id]    INT      NULL,
    [bytes_printed]  INT      NULL,
    [pages]          INT      NULL,
    [paid]           INT      NULL,
    CONSTRAINT [FK_ESPrintTracking_ESEventlogComputer] FOREIGN KEY ([computername]) REFERENCES [dbo].[ESEventlogComputer] ([id]),
    CONSTRAINT [FK_ESPrintTracking_ESEventlogUser] FOREIGN KEY ([username]) REFERENCES [dbo].[ESEventlogUser] ([id]),
    CONSTRAINT [FK_ESPrintTracking_ESPrintDocuments] FOREIGN KEY ([document_name]) REFERENCES [dbo].[ESPrintDocuments] ([id]),
    CONSTRAINT [FK_ESPrintTracking_ESPrintPrinters] FOREIGN KEY ([printer]) REFERENCES [dbo].[ESPrintPrinters] ([id])
);


GO
CREATE CLUSTERED INDEX [IDX_ES_PrintTracking]
    ON [dbo].[ESPrintTracking]([start_datetime] ASC) WITH (FILLFACTOR = 80);

