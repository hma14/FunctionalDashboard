--
-- jtang: Store eventlog records extracted from ESEventLogMain for FD application use
--
CREATE TABLE [dbo].[TL_EventLog] (
    [ID] BIGINT        IDENTITY (1, 1) NOT NULL,
    [SourceLogID]            BIGINT        NOT NULL,
    [LogName]       VARCHAR (64)  NULL,
    [Level]         VARCHAR (32)  NULL,
    [Source]        VARCHAR (196) NULL,
    [Category]      VARCHAR (196) NULL,
    [EventID]       INT           NULL,
    [Computer]      VARCHAR (255) NOT NULL,
    [LoggedTime]    DATETIME      NOT NULL,
    [ProgramID]       VARCHAR(10)           NULL,
    [InstitutionID] VARCHAR(10) NULL, 
    [UploadFileName] VARCHAR(900) NULL, 
    [FileStatus] VARCHAR(10) NULL, 
    [RequestTxID] VARCHAR(40) NULL, 
    [GUID] VARCHAR(36) NULL, 
    [TaskID] INT NULL, 
    [StateID] INT NULL, 
    [UniqueParticipantId] VARCHAR(60) NULL, 
    [CardSerialNumber] VARCHAR(20) NULL, 
    [ExistingCardSN] VARCHAR(20) NULL, 
    [Action] VARCHAR(2) NULL, 
    [ReasonCode] VARCHAR(2) NULL, 
    [Benefit] VARCHAR(50) NULL, 
    [CardTypeCode] VARCHAR(10) NULL, 
    [SuccessFailureCode] VARCHAR(10) NULL, 
    [SuccessFailureDescr] VARCHAR(128) NULL, 
    [ActionExecuted] VARCHAR(20) NULL, 
    [TSID] VARCHAR(12) NULL, 
    [Elig] VARCHAR(10) NULL, 
    [EligDate] VARCHAR(20) NULL, 
    [Rval] VARCHAR(3) NULL, 
    [Rext] VARCHAR(5) NULL, 
    [BenefitID] INT NULL, 
    [BenefitProductID] BIGINT NULL, 
    [BenefitMonth] INT NULL, 
    [BenefitYear] INT NULL, 
    [URI] VARCHAR(1000) NULL, 
    [URIType] VARCHAR(50) NULL, 
    [ProcessDatetime] DATETIME NOT NULL, 
    [ProcessErrorID] VARCHAR(10) NULL, 
    XmlData xml
    CONSTRAINT [PK_TL_EventLog] PRIMARY KEY CLUSTERED ([ID] ASC)
);


GO

CREATE NONCLUSTERED INDEX [IDX_TL_EventLog_Loggedtime] ON [dbo].[TL_EventLog]
(
	[LoggedTime] ASC
)

GO

CREATE NONCLUSTERED INDEX IDX_TL_EventLog_Category_EventId_ProgramId_InstitutionId_ProcessDateTime
ON [dbo].[TL_EventLog] ([Category],[EventID],[ProgramID],[InstitutionID],[ProcessDatetime]);
GO

