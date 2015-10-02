CREATE TABLE [dbo].[ESPrintDocuments] (
    [id]              INT           IDENTITY (1, 1) NOT NULL,
    [name]            VARCHAR (255) NULL,
    [ESPrintTracking] INT           NULL,
    CONSTRAINT [PK_ESPrintDocuments] PRIMARY KEY CLUSTERED ([id] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IDX_ES_PrintDocuments]
    ON [dbo].[ESPrintDocuments]([name] ASC);

