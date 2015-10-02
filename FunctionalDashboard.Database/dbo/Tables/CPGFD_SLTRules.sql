CREATE TABLE [dbo].[CPGFD_SLTRules] (
    
	[ID]                  INT           NOT NULL,
	[ProgramID]           varchar(10)           NOT NULL,
    [InstitutionID]       varchar(10)           NOT NULL,
	[CategoryID]          INT           NOT NULL,
	[EventID]             INT           NOT NULL,
    [RuleType]            TINYINT       NOT NULL,
    [DayOfWeek]           TINYINT       NULL,
    [RuleDay]             INT           NULL,
    [RuleTime]            DATETIME      NULL,
    [WarningThreshold]    INT           NULL,
    [Status]              TINYINT       NOT NULL,
    [NextTriggerDatetime] DATETIME      NULL,
    [UpdatedDatetime]     DATETIME      NOT NULL,
    [UpdatedUser]         VARCHAR (50) NOT NULL,
	[RuleDescription]     VARCHAR(1000)          NULL,
    CONSTRAINT [pk_SLTRules] PRIMARY KEY CLUSTERED ([ID] ASC)
);

