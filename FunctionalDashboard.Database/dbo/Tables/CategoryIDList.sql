CREATE TABLE [dbo].[CategoryIDList] (
    [CategoryID]   INT     NOT NULL,
	[CategoryName] VARCHAR(255) NULL, 
    CONSTRAINT [PK_CategoryIDList] PRIMARY KEY ([CategoryID])
);


GO

CREATE NONCLUSTERED INDEX [IDX_CategoryIDList_CategoryName] ON [dbo].[CategoryIDList]
(
	[CategoryName] ASC
)
GO



