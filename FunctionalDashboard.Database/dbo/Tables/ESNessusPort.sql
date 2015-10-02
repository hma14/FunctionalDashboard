CREATE TABLE [dbo].[ESNessusPort] (
    [id]          INT           IDENTITY (1, 1) NOT NULL,
    [name]        VARCHAR (128) NULL,
    [ESNessusLog] INT           NULL,
    CONSTRAINT [PK_ESNessusPort] PRIMARY KEY CLUSTERED ([id] ASC)
);

