CREATE TABLE [dbo].[CPGFD_KB](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[EventID] [int] NULL,
	[CategoryID] [int] NULL,
	[Status] [tinyint] NULL,
	[Description] [text] NULL,
	[PotentialErrors] [text] NULL,
	[BusinessImpact] [text] NULL,
	[Sev] [tinyint] NULL,
	[Resolutions] [text] NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedDatetime] [datetime] NULL,
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedDatetime] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

go

ALTER view [dbo].[view_ESEventLogs]
as
SELECT [eventnumber] as ID
      ,ll.[eventlog] as LogName
      ,lt.[eventtype] as Level
      ,ls.[eventsource] as Source
      ,lc.[eventcategory] as Category
      ,lm.[eventid] as EventID
      ,lco.[eventcomputer] as Computer
      ,[eventtime] as LoggedTime
     ,CASE  
      --WHEN LEN(eventmessage) >= 7300 
      --THEN CAST(SUBSTRING(eventmessage, 1, len(eventmessage) - 40) + ' ... </ExceptionInfo></rawData>' AS XML) 
      --THEN CAST(SUBSTRING(eventmessage, 1, len(eventmessage) - 40) + ' ... </StackTrace></rawData>' AS XML)
      WHEN eventmessage not like '%</rawData>%'
      THEN CAST(SUBSTRING(eventmessage, 1, len(eventmessage)) + ' ... </ProcessErrorDescr></rawData>' AS XML)
      ELSE CAST([eventmessage] AS XML)
      END  AS XMLData
     --,Cast([eventmessage] as XML) as XMLData
  FROM [dbo].[ESEventlogMain] LM, [dbo].[ESEventlogLog] LL, 
       [dbo].[ESEventlogType] LT, [dbo].[ESEventlogSource] LS,
       [dbo].[ESEventlogCategory] LC , 
       [dbo].[ESEventlogUser] LU, [dbo].[ESEventlogComputer] LCO
      WITH (NOLOCK)
  where lm.eventlog = ll.id
  and lm.eventType = lt.id
  and lm.eventsource = ls.id
  and lm.eventcategory = lc.id
  and lm.eventuser = lU.id
  and lm.eventcomputer = lco.id
  -- greater than 30000 are heartbeat logging, hence ignored
  and lm.eventid < 30000
  -- below three event IDs are filtered out because their logging format are not match to the defined for Dashboard, hence ignored
  and lm.[eventid] <> 48
  and lm.[eventid] <> 2091  
  and lm.[eventid] <> 2092
  and lm.[eventid] <> 2200
  and lm.[eventid] <> 2122
  and lm.[eventid] <> 3048
  and lm.[eventid] <> 3016

GO

