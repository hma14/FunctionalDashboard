CREATE TABLE [dbo].[ESSnmpTrapOid] (
    [id]         INT           IDENTITY (1, 1) NOT NULL,
    [name]       VARCHAR (255) NULL,
    [ESSnmpTrap] INT           NULL,
    CONSTRAINT [PK_ESSnmpTrapOid] PRIMARY KEY CLUSTERED ([id] ASC)
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IDX_ES_SnmpTrapOid]
    ON [dbo].[ESSnmpTrapOid]([name] ASC) WITH (FILLFACTOR = 50);

