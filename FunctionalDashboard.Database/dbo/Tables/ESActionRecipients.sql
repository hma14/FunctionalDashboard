CREATE TABLE [dbo].[ESActionRecipients] (
    [id]                     INT            IDENTITY (1, 1) NOT NULL,
    [name]                   VARCHAR (1024) NULL,
    [ESActionTriggerHistory] INT            NULL,
    CONSTRAINT [PK_ESActionRecipients] PRIMARY KEY CLUSTERED ([id] ASC)
);

