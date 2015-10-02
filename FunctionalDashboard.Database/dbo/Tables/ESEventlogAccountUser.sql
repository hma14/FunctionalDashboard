CREATE TABLE [dbo].[ESEventlogAccountUser] (
    [id]                            INT           IDENTITY (1, 1) NOT NULL,
    [name]                          VARCHAR (255) NULL,
    [ESTrackingAccountGroups]       INT           NULL,
    [ESTrackingAccountGroupsCaller] INT           NULL,
    [ESTrackingAccountComputersClr] INT           NULL,
    [ESTrackingAccountUsers]        INT           NULL,
    [ESTrackingAccountUsersCaller]  INT           NULL,
    [ESTrackingPolicyCaller]        INT           NULL,
    [ESTrackingAuthFailure]         INT           NULL,
    [ESTrackingLogonAuth]           INT           NULL,
    [ESTrackingLogonByType]         INT           NULL,
    CONSTRAINT [PK_ESEventlogAccountUser] PRIMARY KEY CLUSTERED ([id] ASC)
);

