--Jun Tang: 03_schema_migration

GO

CREATE TABLE [dbo].[LogSource]
(
	[Id] INT NOT NULL, 
    [SourceName] VARCHAR(100) NOT NULL,
	CONSTRAINT [PK_LogSource] PRIMARY KEY ([Id])
);

GO

CREATE UNIQUE NONCLUSTERED INDEX [IDX_LogSource_SourceName] ON [dbo].[LogSource]
(
	[SourceName] ASC
);

GO

