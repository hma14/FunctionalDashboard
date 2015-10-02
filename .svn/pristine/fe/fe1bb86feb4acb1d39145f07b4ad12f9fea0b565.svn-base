CREATE TABLE [dbo].[ESSysinfoServerTempSensor] (
    [computer]          INT           NULL,
    [name]              VARCHAR (64)  NULL,
    [status]            VARCHAR (16)  NULL,
    [statusdescription] VARCHAR (255) NULL,
    [temperature]       INT           NULL,
    CONSTRAINT [FK_ESSysinfoServerTempSensor_ESEventlogComputer] FOREIGN KEY ([computer]) REFERENCES [dbo].[ESEventlogComputer] ([id])
);


GO
CREATE NONCLUSTERED INDEX [IDX_ESSysinfoServerTempSensor_Computer]
    ON [dbo].[ESSysinfoServerTempSensor]([computer] ASC) WITH (FILLFACTOR = 80);

