CREATE TABLE [dbo].[CPGFD_ErrorMsg] (
    [ID]              INT          IDENTITY (1, 1) NOT NULL,
    [ErrorListID]     INT          NULL,
    [Message]         TEXT         NULL,
    [Status]          TINYINT      NULL,
    [UpdatedBy]       VARCHAR (50) NULL,
    [UpdatedDatetime] DATETIME     NULL,
    CONSTRAINT [pk_ErrorMsg] PRIMARY KEY CLUSTERED ([ID] ASC),
    CONSTRAINT [fk_ErrorList] FOREIGN KEY ([ErrorListID]) REFERENCES [dbo].[CPGFD_ErrorList] ([ID])
);

