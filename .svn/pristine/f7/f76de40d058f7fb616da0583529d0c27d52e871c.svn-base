CREATE TABLE [dbo].[ESSysinfoServerRemoteMgmt] (
    [computer]          INT           NULL,
    [name]              VARCHAR (128) NULL,
    [status]            VARCHAR (16)  NULL,
    [statusdescription] VARCHAR (255) NULL,
    [accessinfo]        VARCHAR (40)  NULL,
    CONSTRAINT [FK_ESSysinfoServerRemoteMgmt_ESEventlogComputer] FOREIGN KEY ([computer]) REFERENCES [dbo].[ESEventlogComputer] ([id])
);


GO
CREATE NONCLUSTERED INDEX [IDX_ESSysinfoServerRemoteMgmt_Computer]
    ON [dbo].[ESSysinfoServerRemoteMgmt]([computer] ASC) WITH (FILLFACTOR = 80);

