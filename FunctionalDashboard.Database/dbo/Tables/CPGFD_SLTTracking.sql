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