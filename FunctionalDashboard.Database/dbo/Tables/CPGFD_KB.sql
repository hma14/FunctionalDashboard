CREATE TABLE [dbo].[CPGFD_KB] (
    [ID]              INT           IDENTITY (1, 1) NOT NULL,
    [EventID]         INT           NULL,
    [CategoryID]      INT           NULL,
    [Status]          TINYINT       NULL,
    [Description]     TEXT          NULL,
    [PotentialErrors] TEXT          NULL,
    [BusinessImpact]  TEXT          NULL,
    [Sev]             TINYINT       NULL,
    [Resolutions]     TEXT          NULL,
    [CreatedBy]       NVARCHAR (50) NULL,
    [CreatedDatetime] DATETIME      NULL,
    [UpdatedBy]       NVARCHAR (50) NULL,
    [UpdatedDatetime] DATETIME      NULL,
    PRIMARY KEY CLUSTERED ([ID] ASC)
);

