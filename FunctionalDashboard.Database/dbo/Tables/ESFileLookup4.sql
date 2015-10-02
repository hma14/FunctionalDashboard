CREATE TABLE [dbo].[ESFileLookup4] (
    [id]              INT            IDENTITY (1, 1) NOT NULL,
    [filetype]        INT            NULL,
    [mytext]          VARCHAR (1024) NULL,
    [ESFlatFileDelim] INT            NULL,
    CONSTRAINT [PK_ESFileLookup4] PRIMARY KEY CLUSTERED ([id] ASC)
);

