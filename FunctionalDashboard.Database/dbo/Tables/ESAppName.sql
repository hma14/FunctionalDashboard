CREATE TABLE [dbo].[ESAppName] (
    [id]            INT           IDENTITY (1, 1) NOT NULL,
    [name]          VARCHAR (255) NULL,
    [ESApplication] INT           NULL,
    CONSTRAINT [PK_ESAppName] PRIMARY KEY CLUSTERED ([id] ASC)
);

