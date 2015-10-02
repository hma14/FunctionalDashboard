CREATE TABLE [dbo].[ESArpStatus] (
    [timestamp_firstseen]   DATETIME       NULL,
    [timestamp_lastseen]    DATETIME       NULL,
    [receiver_hostname]     INT            NULL,
    [interface_mac]         INT            NULL,
    [discover_mac]          INT            NULL,
    [discover_ips]          VARCHAR (1024) NULL,
    [discover_ips_hostname] INT            NULL,
    [discover_mac_vendor]   INT            NULL,
    CONSTRAINT [FK_ESArpStatus_ESEventlogComputer_Receiver] FOREIGN KEY ([receiver_hostname]) REFERENCES [dbo].[ESEventlogComputer] ([id]),
    CONSTRAINT [FK_ESArpStatus_ESEventlogComputer_Resolved] FOREIGN KEY ([discover_ips_hostname]) REFERENCES [dbo].[ESEventlogComputer] ([id]),
    CONSTRAINT [FK_ESArpStatus_ESMacAddress_Discover] FOREIGN KEY ([discover_mac]) REFERENCES [dbo].[ESMacAddress] ([id]),
    CONSTRAINT [FK_ESArpStatus_ESMacAddress_Interface] FOREIGN KEY ([interface_mac]) REFERENCES [dbo].[ESMacAddress] ([id]),
    CONSTRAINT [FK_ESArpStatus_ESMacAddressVendor] FOREIGN KEY ([discover_mac_vendor]) REFERENCES [dbo].[ESMacAddressVendor] ([id])
);


GO
CREATE CLUSTERED INDEX [IDX_ES_ArpStatus_LastSeen]
    ON [dbo].[ESArpStatus]([timestamp_lastseen] ASC) WITH (FILLFACTOR = 80);


GO
CREATE NONCLUSTERED INDEX [IDX_ES_ArpStatus_FirstSeen]
    ON [dbo].[ESArpStatus]([timestamp_firstseen] ASC) WITH (FILLFACTOR = 80);


GO
CREATE NONCLUSTERED INDEX [IDX_ES_ArpStatus_Mac]
    ON [dbo].[ESArpStatus]([discover_mac] ASC) WITH (FILLFACTOR = 80);

