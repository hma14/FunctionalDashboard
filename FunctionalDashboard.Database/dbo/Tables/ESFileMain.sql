CREATE TABLE [dbo].[ESFileMain] (
    [recorddate]       DATETIME       NULL,
    [filename]         INT            NULL,
    [filepath]         INT            NULL,
    [filename_actual]  INT            NULL,
    [filepath_actual]  INT            NULL,
    [computername]     INT            NULL,
    [content]          VARCHAR (7980) NULL,
    [file_description] INT            NULL,
    CONSTRAINT [FK_ESFileMain_ESEventlogComputer] FOREIGN KEY ([computername]) REFERENCES [dbo].[ESEventlogComputer] ([id]),
    CONSTRAINT [FK_ESFileMain_ESFileName1] FOREIGN KEY ([filename]) REFERENCES [dbo].[ESEventlogFilename] ([id]),
    CONSTRAINT [FK_ESFileMain_ESFileName2] FOREIGN KEY ([filename_actual]) REFERENCES [dbo].[ESEventlogFilename] ([id]),
    CONSTRAINT [FK_ESFileMain_ESFilePath1] FOREIGN KEY ([filepath]) REFERENCES [dbo].[ESEventlogFilepath] ([id]),
    CONSTRAINT [FK_ESFileMain_ESFilePath2] FOREIGN KEY ([filepath_actual]) REFERENCES [dbo].[ESEventlogFilepath] ([id]),
    CONSTRAINT [FK_ESFileMain_ESStrings] FOREIGN KEY ([file_description]) REFERENCES [dbo].[ESStrings] ([id])
);


GO
CREATE CLUSTERED INDEX [IDX_ES_FileMain]
    ON [dbo].[ESFileMain]([recorddate] ASC) WITH (FILLFACTOR = 80);

