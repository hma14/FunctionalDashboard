CREATE TABLE [dbo].[ESServiceKey] (
    [id]        INT           IDENTITY (1, 1) NOT NULL,
    [name]      VARCHAR (255) NULL,
    [ESService] INT           NULL,
    CONSTRAINT [PK_ESServiceKey] PRIMARY KEY CLUSTERED ([id] ASC)
);

