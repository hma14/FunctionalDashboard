CREATE TABLE [dbo].[ESPrintPrinters] (
    [id]              INT           IDENTITY (1, 1) NOT NULL,
    [name]            VARCHAR (255) NULL,
    [ESPrintTracking] INT           NULL,
    CONSTRAINT [PK_ESPrintPrinters] PRIMARY KEY CLUSTERED ([id] ASC)
);

