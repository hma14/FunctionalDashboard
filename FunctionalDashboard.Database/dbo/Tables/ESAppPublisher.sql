CREATE TABLE [dbo].[ESAppPublisher] (
    [id]            INT           IDENTITY (1, 1) NOT NULL,
    [name]          VARCHAR (255) NULL,
    [ESApplication] INT           NULL,
    CONSTRAINT [PK_ESAppPublisher] PRIMARY KEY CLUSTERED ([id] ASC)
);

