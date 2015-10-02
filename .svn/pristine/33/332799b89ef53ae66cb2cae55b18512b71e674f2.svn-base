CREATE TABLE [dbo].[ESSysinfoVirtualMachines] (
    [recorddate] DATETIME      NULL,
    [vmHost]     INT           NULL,
    [vmProduct]  VARCHAR (64)  NULL,
    [vmVersion]  VARCHAR (32)  NULL,
    [vmBuildNr]  VARCHAR (16)  NULL,
    [vmName]     VARCHAR (255) NULL,
    [fullPath]   VARCHAR (255) NULL,
    [os]         VARCHAR (128) NULL,
    [status]     VARCHAR (32)  NULL,
    [id]         VARCHAR (64)  NULL,
    [cpuCount]   INT           NULL,
    [memMb]      INT           NULL,
    CONSTRAINT [FK_ESSysinfoVirtualMachines_ESEventlogComputer] FOREIGN KEY ([vmHost]) REFERENCES [dbo].[ESEventlogComputer] ([id])
);


GO
CREATE CLUSTERED INDEX [IDX_ESSysinfoVirtualMachines_vmhost]
    ON [dbo].[ESSysinfoVirtualMachines]([vmHost] ASC) WITH (FILLFACTOR = 80);


GO
CREATE NONCLUSTERED INDEX [IDX_ESSysinfoVirtualMachines_vmName]
    ON [dbo].[ESSysinfoVirtualMachines]([vmName] ASC) WITH (FILLFACTOR = 80);

