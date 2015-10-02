--Jun Tang: 03_schema_migration

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
	[RuleDescription]     VARCHAR(1000)         NULL,
    CONSTRAINT [pk_SLTRules] PRIMARY KEY CLUSTERED ([ID] ASC)
);

GO


CREATE TABLE [dbo].[CPGFD_SLTTracking] (
	ID bigint Identity(1, 1) NOT NULL,
	[EventID]             INT           NOT NULL,
	[CategoryID]          INT           NOT NULL,
    [ProgramID]           varchar(10)           NOT NULL,
    [InstitutionID]       varchar(10)           NOT NULL,	
	SLTRuleID int  NOT NULL,
	[RuleDescription]     VARCHAR(1000)          NULL,
	SLTStartDatetime Datetime NOT NULL,
	SLTWarningDatetime Datetime NOT NULL,
	SLTBreachDatetime Datetime NOT NULL,
	SLTCompleteDatetime Datetime,
	[Status] TinyInt NOT NULL,
	UpdatedDatetime Datetime NOT NULL,
	UpdatedUser VARCHAR(50) NOT NULL,
	constraint pk_SLTTracking primary key CLUSTERED (ID ASC),
	constraint fk_SLTTracking foreign key (SLTRuleID) references CPGFD_SLTRules(ID)
	);


GO
