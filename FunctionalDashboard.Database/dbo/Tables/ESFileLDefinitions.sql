CREATE TABLE [dbo].[ESFileLDefinitions] (
    [id]              INT           IDENTITY (1, 1) NOT NULL,
    [name]            VARCHAR (128) NULL,
    [ESFlatFileDelim] INT           NULL,
    CONSTRAINT [PK_ESFileLDefinitions] PRIMARY KEY CLUSTERED ([id] ASC)
);

