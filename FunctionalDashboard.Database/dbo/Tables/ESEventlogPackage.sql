CREATE TABLE [dbo].[ESEventlogPackage] (
    [id]                     INT           IDENTITY (1, 1) NOT NULL,
    [name]                   VARCHAR (128) NULL,
    [ESActionTriggerHistory] INT           NULL,
    CONSTRAINT [PK_ESEventlogPackage] PRIMARY KEY CLUSTERED ([id] ASC)
);

