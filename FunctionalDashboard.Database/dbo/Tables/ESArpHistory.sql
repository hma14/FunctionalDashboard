CREATE TABLE [dbo].[ESArpHistory] (
    [recorddate]          DATETIME NULL,
    [receiver_hostname]   INT      NULL,
    [interface_mac]       INT      NULL,
    [discover_mac]        INT      NULL,
    [discover_ip]         INT      NULL,
    [discover_mac_vendor] INT      NULL,
    CONSTRAINT [FK_ESArpHistory_ESEventlogComputer_Receiver] FOREIGN KEY ([receiver_hostname]) REFERENCES [dbo].[ESEventlogComputer] ([id]),
    CONSTRAINT [FK_ESArpHistory_ESIPAddress] FOREIGN KEY ([discover_ip]) REFERENCES [dbo].[ESIPAddress] ([id]),
    CONSTRAINT [FK_ESArpHistory_ESMacAddress_Discover] FOREIGN KEY ([discover_mac]) REFERENCES [dbo].[ESMacAddress] ([id]),
    CONSTRAINT [FK_ESArpHistory_ESMacAddress_Interface] FOREIGN KEY ([interface_mac]) REFERENCES [dbo].[ESMacAddress] ([id]),
    CONSTRAINT [FK_ESArpHistory_ESMacAddressVendor] FOREIGN KEY ([discover_mac_vendor]) REFERENCES [dbo].[ESMacAddressVendor] ([id])
);


GO
CREATE CLUSTERED INDEX [IDX_ES_ArpHistory]
    ON [dbo].[ESArpHistory]([recorddate] ASC) WITH (FILLFACTOR = 80);

