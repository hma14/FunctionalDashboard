CREATE TABLE [dbo].[ESSysinfoNIC] (
    [computer]          INT           NULL,
    [adapterindex]      INT           NULL,
    [macaddress]        CHAR (17)     NULL,
    [devicedescription] VARCHAR (128) NULL,
    [adaptername]       VARCHAR (40)  NULL,
    [ipaddressv4]       VARCHAR (15)  NULL,
    [linkspeed]         INT           NULL,
    [isUp]              INT           NULL
);


GO
CREATE CLUSTERED INDEX [IDX_ES_SysinfoNIC]
    ON [dbo].[ESSysinfoNIC]([computer] ASC) WITH (FILLFACTOR = 80);

