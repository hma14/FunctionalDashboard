CREATE TABLE [dbo].[CPGEnvironments] (
    [ServerName]  NVARCHAR (255) NULL,
    [Environment] NVARCHAR (255) NULL
);


GO
CREATE UNIQUE CLUSTERED INDEX [CL_ENV]
    ON [dbo].[CPGEnvironments]([ServerName] ASC);

