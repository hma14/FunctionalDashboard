CREATE TABLE [dbo].[ESSysinfoServerFan] (
    [computer]          INT           NULL,
    [name]              VARCHAR (64)  NULL,
    [status]            VARCHAR (16)  NULL,
    [statusdescription] VARCHAR (255) NULL,
    [speed]             INT           NULL,
    CONSTRAINT [FK_ESSysinfoServerFan_ESEventlogComputer] FOREIGN KEY ([computer]) REFERENCES [dbo].[ESEventlogComputer] ([id])
);


GO
CREATE NONCLUSTERED INDEX [IDX_ESSysinfoServerFan_Computer]
    ON [dbo].[ESSysinfoServerFan]([computer] ASC) WITH (FILLFACTOR = 80);

