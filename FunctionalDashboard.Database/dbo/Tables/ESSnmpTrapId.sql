CREATE TABLE [dbo].[ESSnmpTrapId] (
    [id]         INT           IDENTITY (1, 1) NOT NULL,
    [name]       VARCHAR (255) NULL,
    [ESSnmpTrap] INT           NULL,
    CONSTRAINT [PK_ESSnmpTrapId] PRIMARY KEY CLUSTERED ([id] ASC)
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IDX_ES_SnmpTrapId]
    ON [dbo].[ESSnmpTrapId]([name] ASC) WITH (FILLFACTOR = 50);

