CREATE TABLE [dbo].[ESFilemon] (
    [recorddate]    DATETIME     NULL,
    [computername]  INT          NULL,
    [filepath]      INT          NULL,
    [filename]      INT          NULL,
    [filesize]      INT          NULL,
    [filesize_type] CHAR (2)     NULL,
    [hash]          VARCHAR (64) NULL,
    [IsStream]      INT          NULL,
    CONSTRAINT [FK_ESFilemon_ESEventlogComputer] FOREIGN KEY ([computername]) REFERENCES [dbo].[ESEventlogComputer] ([id]),
    CONSTRAINT [FK_ESFilemon_ESEventlogFilename] FOREIGN KEY ([filename]) REFERENCES [dbo].[ESEventlogFilename] ([id]),
    CONSTRAINT [FK_ESFilemon_ESEventlogFilepath] FOREIGN KEY ([filepath]) REFERENCES [dbo].[ESEventlogFilepath] ([id])
);


GO
CREATE CLUSTERED INDEX [IDX_ES_Filemon]
    ON [dbo].[ESFilemon]([recorddate] ASC) WITH (FILLFACTOR = 80);

