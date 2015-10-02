CREATE TABLE [dbo].[ESNessusLog] (
    [recorddate]   DATETIME NULL,
    [computername] INT      NULL,
    [port]         INT      NULL,
    [severity]     INT      NULL,
    [plugin_id]    INT      NULL,
    [kbid]         INT      NULL,
    [riskfactor]   INT      NULL,
    [cvss]         INT      NULL,
    CONSTRAINT [FK_ESNessusLog_ESEventlogComputer] FOREIGN KEY ([computername]) REFERENCES [dbo].[ESEventlogComputer] ([id]),
    CONSTRAINT [FK_ESNessusLog_ESNessusPort] FOREIGN KEY ([port]) REFERENCES [dbo].[ESNessusPort] ([id])
);


GO
CREATE CLUSTERED INDEX [IDX_ES_NessusLog]
    ON [dbo].[ESNessusLog]([recorddate] ASC) WITH (FILLFACTOR = 80);

