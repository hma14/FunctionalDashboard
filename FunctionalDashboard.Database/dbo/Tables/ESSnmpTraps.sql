CREATE TABLE [dbo].[ESSnmpTraps] (
    [recorddate]        DATETIME       NULL,
    [receiver_hostname] INT            NULL,
    [sender_hostname]   INT            NULL,
    [sender_ip]         INT            NULL,
    [communityuser]     INT            NULL,
    [version]           INT            NULL,
    [trap_id]           INT            NULL,
    [trap_oid]          INT            NULL,
    [bindings]          VARCHAR (7400) NULL,
    CONSTRAINT [FK_ESSnmpTraps_ESEventlogComputer_Receiver] FOREIGN KEY ([receiver_hostname]) REFERENCES [dbo].[ESEventlogComputer] ([id]),
    CONSTRAINT [FK_ESSnmpTraps_ESEventlogComputer_Sender] FOREIGN KEY ([sender_hostname]) REFERENCES [dbo].[ESEventlogComputer] ([id]),
    CONSTRAINT [FK_ESSnmpTraps_ESIPAddress_Sender] FOREIGN KEY ([sender_ip]) REFERENCES [dbo].[ESIPAddress] ([id]),
    CONSTRAINT [FK_ESSnmpTraps_ESSnmpCommunityUser] FOREIGN KEY ([communityuser]) REFERENCES [dbo].[ESSnmpCommunityUser] ([id]),
    CONSTRAINT [FK_ESSnmpTraps_ESSnmpTrapId] FOREIGN KEY ([trap_id]) REFERENCES [dbo].[ESSnmpTrapId] ([id]),
    CONSTRAINT [FK_ESSnmpTraps_ESSnmpTrapOid] FOREIGN KEY ([trap_oid]) REFERENCES [dbo].[ESSnmpTrapOid] ([id])
);


GO
CREATE CLUSTERED INDEX [IDX_ES_SnmpTraps]
    ON [dbo].[ESSnmpTraps]([recorddate] ASC) WITH (FILLFACTOR = 80);

