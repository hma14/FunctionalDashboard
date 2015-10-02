CREATE TABLE [dbo].[ESEnvironment] (
    [data]         INT      NULL,
    [type]         CHAR (1) NULL,
    [subtype]      CHAR (1) NULL,
    [computername] INT      NULL,
    [recorddate]   DATETIME NULL,
    CONSTRAINT [FK_ESEnvironment_ESEventlogComputer] FOREIGN KEY ([computername]) REFERENCES [dbo].[ESEventlogComputer] ([id])
);


GO
CREATE CLUSTERED INDEX [IDX_ESEnvironment_DateTime]
    ON [dbo].[ESEnvironment]([recorddate] ASC) WITH (FILLFACTOR = 80);

