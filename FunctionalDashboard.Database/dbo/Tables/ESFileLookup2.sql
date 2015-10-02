CREATE TABLE [dbo].[ESFileLookup2] (
    [id]              INT            IDENTITY (1, 1) NOT NULL,
    [filetype]        INT            NULL,
    [mytext]          VARCHAR (1024) NULL,
    [ESFlatFileDelim] INT            NULL,
    CONSTRAINT [PK_ESFileLookup2] PRIMARY KEY CLUSTERED ([id] ASC)
);

