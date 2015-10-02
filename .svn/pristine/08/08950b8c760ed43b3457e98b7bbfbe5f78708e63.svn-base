CREATE TABLE [dbo].[ESSnmpCommunityUser] (
    [id]         INT           IDENTITY (1, 1) NOT NULL,
    [name]       VARCHAR (255) NULL,
    [ESSnmpTrap] INT           NULL,
    CONSTRAINT [PK_ESSnmpCommunityUser] PRIMARY KEY CLUSTERED ([id] ASC)
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IDX_ES_SnmpCommunityUser]
    ON [dbo].[ESSnmpCommunityUser]([name] ASC) WITH (FILLFACTOR = 50);

