CREATE TABLE [dbo].[ESPrintCost] (
    [id]           INT        IDENTITY (1, 1) NOT NULL,
    [computername] INT        NULL,
    [printer]      INT        NULL,
    [costperpage]  FLOAT (53) NULL,
    CONSTRAINT [PK_ESPrintCost] PRIMARY KEY CLUSTERED ([id] ASC),
    CONSTRAINT [FK_ESPrintCost_ESEventlogComputer] FOREIGN KEY ([computername]) REFERENCES [dbo].[ESEventlogComputer] ([id]),
    CONSTRAINT [FK_ESPrintCost_ESPrintPrinters] FOREIGN KEY ([printer]) REFERENCES [dbo].[ESPrintPrinters] ([id])
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IDX_ES_PrintCost_Unique]
    ON [dbo].[ESPrintCost]([computername] ASC, [printer] ASC);

