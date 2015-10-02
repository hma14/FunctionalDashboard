CREATE TABLE [dbo].[ESEventlogLocationMapping] (
    [location] INT NULL,
    [computer] INT NULL
);


GO
CREATE CLUSTERED INDEX [IDX_ES_LocationMapping]
    ON [dbo].[ESEventlogLocationMapping]([location] ASC, [computer] ASC) WITH (FILLFACTOR = 90);

