CREATE TABLE [dbo].[ESFolderStatus] (
    [recorddate]         DATETIME NULL,
    [computername]       INT      NULL,
    [filepath]           INT      NULL,
    [files]              INT      NULL,
    [folders]            INT      NULL,
    [size_logical]       INT      NULL,
    [size_logical_type]  CHAR (2) NULL,
    [size_physical]      INT      NULL,
    [size_physical_type] CHAR (2) NULL,
    CONSTRAINT [FK_ESFolderStatus_ESEventlogComputer] FOREIGN KEY ([computername]) REFERENCES [dbo].[ESEventlogComputer] ([id]),
    CONSTRAINT [FK_ESFolderStatus_ESEventlogFilepath] FOREIGN KEY ([filepath]) REFERENCES [dbo].[ESEventlogFilepath] ([id])
);


GO
CREATE CLUSTERED INDEX [IDX_ES_FolderStatus]
    ON [dbo].[ESFolderStatus]([recorddate] ASC) WITH (FILLFACTOR = 80);

