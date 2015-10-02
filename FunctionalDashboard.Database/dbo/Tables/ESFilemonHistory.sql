CREATE TABLE [dbo].[ESFilemonHistory] (
    [recorddate]        DATETIME     NULL,
    [computername]      INT          NULL,
    [filepath]          INT          NULL,
    [filename]          INT          NULL,
    [filesize_old]      INT          NULL,
    [filesize_old_type] CHAR (2)     NULL,
    [hash_old]          VARCHAR (64) NULL,
    [filesize_new]      INT          NULL,
    [filesize_new_type] CHAR (2)     NULL,
    [hash_new]          VARCHAR (64) NULL,
    [action]            INT          NULL,
    [IsStream]          INT          NULL,
    CONSTRAINT [FK_ESFilemonHistory_ESEventlogComputer] FOREIGN KEY ([computername]) REFERENCES [dbo].[ESEventlogComputer] ([id]),
    CONSTRAINT [FK_ESFilemonHistory_ESEventlogFilename] FOREIGN KEY ([filename]) REFERENCES [dbo].[ESEventlogFilename] ([id]),
    CONSTRAINT [FK_ESFilemonHistory_ESEventlogFilepath] FOREIGN KEY ([filepath]) REFERENCES [dbo].[ESEventlogFilepath] ([id])
);


GO
CREATE CLUSTERED INDEX [IDX_ES_FilemonHistory]
    ON [dbo].[ESFilemonHistory]([recorddate] ASC) WITH (FILLFACTOR = 80);

