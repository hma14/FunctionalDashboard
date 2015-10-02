CREATE TABLE [dbo].[ESDiskspaceLargeFiles] (
    [recorddate]   DATETIME      NULL,
    [computer]     INT           NULL,
    [groupname]    INT           NULL,
    [filename]     INT           NULL,
    [logicaldrive] VARCHAR (255) NULL,
    [filesize]     BIGINT        NULL,
    [rank]         INT           NULL,
    CONSTRAINT [FK_ESDiskspaceLargeFiles_ESEventlogComputer] FOREIGN KEY ([computer]) REFERENCES [dbo].[ESEventlogComputer] ([id]),
    CONSTRAINT [FK_ESDiskspaceLargeFiles_ESEventlogGroup] FOREIGN KEY ([groupname]) REFERENCES [dbo].[ESEventlogGroup] ([id]),
    CONSTRAINT [FK_ESDiskspaceLargeFiles_ESFile] FOREIGN KEY ([filename]) REFERENCES [dbo].[ESFile] ([id])
);


GO
CREATE NONCLUSTERED INDEX [IDX_ESDiskspaceLargeFiles_Default]
    ON [dbo].[ESDiskspaceLargeFiles]([filename] ASC) WITH (FILLFACTOR = 50);

