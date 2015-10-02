CREATE TABLE [dbo].[ESEventlogSID] (
    [id]                            INT          IDENTITY (1, 1) NOT NULL,
    [name]                          VARCHAR (64) NULL,
    [ESTrackingAccountGroups]       INT          NULL,
    [ESTrackingAccountGroupsCaller] INT          NULL,
    [ESTrackingAccountComputersCli] INT          NULL,
    [ESTrackingAccountComputersClr] INT          NULL,
    [ESTrackingAccountUsers]        INT          NULL,
    [ESTrackingAccountUsersCaller]  INT          NULL,
    [ESTrackingPolicy]              INT          NULL,
    [ESTrackingPolicyCaller]        INT          NULL,
    [ESTrackingLogonByType]         INT          NULL,
    [ESTrackingLogonAuth]           INT          NULL,
    CONSTRAINT [PK_ESEventlogSID] PRIMARY KEY CLUSTERED ([id] ASC)
);

