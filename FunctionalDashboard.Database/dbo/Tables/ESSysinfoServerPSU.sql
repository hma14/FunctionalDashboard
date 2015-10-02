CREATE TABLE [dbo].[ESSysinfoServerPSU] (
    [computer]          INT           NULL,
    [name]              VARCHAR (64)  NULL,
    [status]            VARCHAR (16)  NULL,
    [statusdescription] VARCHAR (255) NULL,
    CONSTRAINT [FK_ESSysinfoServerPSU_ESEventlogComputer] FOREIGN KEY ([computer]) REFERENCES [dbo].[ESEventlogComputer] ([id])
);


GO
CREATE NONCLUSTERED INDEX [IDX_ESSysinfoServerPSU_Computer]
    ON [dbo].[ESSysinfoServerPSU]([computer] ASC) WITH (FILLFACTOR = 80);

