CREATE TABLE [dbo].[ESServiceName] (
    [id]        INT           IDENTITY (1, 1) NOT NULL,
    [name]      VARCHAR (255) NULL,
    [ESService] INT           NULL,
    CONSTRAINT [PK_ESServiceName] PRIMARY KEY CLUSTERED ([id] ASC)
);

