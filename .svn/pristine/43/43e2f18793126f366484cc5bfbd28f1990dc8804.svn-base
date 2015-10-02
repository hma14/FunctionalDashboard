CREATE TABLE [dbo].[ESSysinfoWarranty] (
    [computer]       INT           NULL,
    [id]             INT           IDENTITY (1, 1) NOT NULL,
    [provider]       VARCHAR (32)  NULL,
    [serviceLevel]   VARCHAR (128) NULL,
    [warrantyStatus] VARCHAR (32)  NULL,
    [startDate]      DATETIME      NULL,
    [endDate]        DATETIME      NULL,
    [recorddate]     DATETIME      NULL,
    CONSTRAINT [PK_ESSysinfoWarranty] PRIMARY KEY CLUSTERED ([id] ASC),
    CONSTRAINT [FK_ESSysinfoWarranty_ESEventlogComputer] FOREIGN KEY ([computer]) REFERENCES [dbo].[ESEventlogComputer] ([id])
);


GO
CREATE NONCLUSTERED INDEX [IDX_ESSysinfoWarranty_Computer]
    ON [dbo].[ESSysinfoWarranty]([computer] ASC) WITH (FILLFACTOR = 80);


GO
CREATE NONCLUSTERED INDEX [IDX_ESSysinfoWarranty_EndDate]
    ON [dbo].[ESSysinfoWarranty]([endDate] ASC) WITH (FILLFACTOR = 80);

