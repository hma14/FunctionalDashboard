CREATE TABLE [dbo].[ESSysinfoDiskCtrl] (
    [computer]     INT          NULL,
    [adaptername]  VARCHAR (64) NULL,
    [device_id]    VARCHAR (96) NULL,
    [driver]       VARCHAR (32) NULL,
    [manufacturer] VARCHAR (48) NULL,
    [type]         VARCHAR (4)  NULL
);


GO
CREATE CLUSTERED INDEX [IDX_ES_SysinfoDiskCtrl]
    ON [dbo].[ESSysinfoDiskCtrl]([computer] ASC) WITH (FILLFACTOR = 80);

