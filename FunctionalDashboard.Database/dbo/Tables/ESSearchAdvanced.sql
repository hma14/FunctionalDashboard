CREATE TABLE [dbo].[ESSearchAdvanced] (
    [search_id]       INT            NULL,
    [field]           VARCHAR (32)   NULL,
    [condition_value] CHAR (2)       NULL,
    [search_value]    VARCHAR (1024) NULL,
    CONSTRAINT [FK_ESSearchAdvanced_ESSearchSimple] FOREIGN KEY ([search_id]) REFERENCES [dbo].[ESSearchSimple] ([id])
);

