-- jtang: your data initialization scripts

update [dbo].[EventIDList] set eventid=eventid/1000 * 100 + (eventid - eventid/1000 * 1000) where eventid >= 85000;
GO

insert into logsource values (1,'ConfiscationRequestAsyncProcessor');
insert into logsource values (2,'CubicRequestAsyncProcessor');
insert into logsource values (3,'CubicRequestProcessor');
insert into logsource values (4,'EligibilityFileCubicApi');
insert into logsource values (5,'EmailRequestProcessor');
insert into logsource values (6,'FunctionalDashboard');
insert into logsource values (7,'GeneralCpg');
insert into logsource values (8,'InboundFileMonitorGD');
insert into logsource values (9,'InboundFileMonitorTL');
insert into logsource values (10,'InboundFileProcessor');
insert into logsource values (11,'IufInboundFileService');
insert into logsource values (12,'MediaRequestFileCubicApi');
insert into logsource values (13,'MediaRequestSchedulerCubicApi');
insert into logsource values (14,'OutboundFileMonitor');
insert into logsource values (15,'OutboundFileMonitorService');
insert into logsource values (16,'OutboundFileProcessor');
insert into logsource values (17,'PassCpg');
insert into logsource values (18,'RemediationInboundMonitor');
insert into logsource values (19,'RemediationStateMachine');
insert into logsource values (20,'RemediationWebService');
insert into logsource values (21,'ScheduledFileDataDeletion');
insert into logsource values (22,'SyncUtility');
insert into logsource values (23,'TransLinkWebServiceCubicApi');
insert into logsource values (24,'UpassCpg');
insert into logsource values (25,'UpassEligibilityWebServiceCubicApi');
insert into logsource values (26,'UPassRequestProcessor');
insert into logsource values (27,'UpassWebServices');
insert into logsource values (28,'ConfiscationRequestProcessor');
insert into logsource values (29,'FilePurge');
insert into logsource values (30,'LongRunningTaskUpdateGenerator');
insert into logsource values (31,'MonitorsAndAlerts');
insert into logsource values (32,'MonthlyReminderGenerator');
insert into logsource values (33,'StoredProcExecutor');
insert into logsource values (34,'SLTRulesProcessor');
insert into logsource values (35,'SLTTrackingProcessor');



go

insert into [dbo].[CategoryIDList] (categoryname, categoryid) values ('IBMandatoryKeywordReceivedTask', 56);
insert into [dbo].[CategoryIDList] (categoryname, categoryid) values ('IBOptInRequestedTask',57);
insert into [dbo].[CategoryIDList] (categoryname, categoryid) values ('IBOptOutRequestedTask',58);
insert into [dbo].[CategoryIDList] (categoryname, categoryid) values ('IBSMSReceivedTask',59);
insert into [dbo].[CategoryIDList] (categoryname, categoryid) values ('OBSMSRequestedTask',60);
insert into [dbo].[CategoryIDList] (categoryname, categoryid) values ('RemediationInboundMonitor',61);

go

insert into [dbo].[EventIDList] values (2503, 'GetStatusBySmartcardStarted');
insert into [dbo].[EventIDList] values (2504, 'GetStatusBySmartcardFailed');
insert into [dbo].[EventIDList] values (2505, 'GetStatusBySmartcardEnded');
insert into [dbo].[EventIDList] values (2506, 'CloseRequestStarted');
insert into [dbo].[EventIDList] values (2507, 'CloseRequestFailed');
insert into [dbo].[EventIDList] values (2508, 'CloseRequestEnded');
insert into [dbo].[EventIDList] values (2509, 'IssueSmartCardStarted');
insert into [dbo].[EventIDList] values (2510, 'IssueSmartCardFailed');
insert into [dbo].[EventIDList] values (2511, 'IssueSmartCardEnded');
insert into [dbo].[EventIDList] values (2512, 'TerminateSmartCardStarted');
insert into [dbo].[EventIDList] values (2513, 'TerminateSmartCardFailed');
insert into [dbo].[EventIDList] values (2514, 'TerminateSmartCardEnded');
insert into [dbo].[EventIDList] values (2515, 'UpdateRiderClassStarted');
insert into [dbo].[EventIDList] values (2516, 'UpdateRiderClassFailed');
insert into [dbo].[EventIDList] values (2517, 'UpdateRiderClassEnded');
insert into [dbo].[EventIDList] values (5541, 'UPassWSResendConfirmationSMS');
insert into [dbo].[EventIDList] values (5542, 'UPassWSIsSMSNumberBlackListed');
insert into [dbo].[EventIDList] values (7103, 'AdHocEmailRequestedStarted');
insert into [dbo].[EventIDList] values (7104, 'AdHocEmailRequestedEnded');
insert into [dbo].[EventIDList] values (7105, 'IBMandatoryKeywordReceivedTaskStarted');
insert into [dbo].[EventIDList] values (7106, 'IBMandatoryKeywordReceivedTaskEnded');
insert into [dbo].[EventIDList] values (7107, 'IBOptInRequestedTaskStarted');
insert into [dbo].[EventIDList] values (7108, 'IBOptInRequestedTaskEnded');
insert into [dbo].[EventIDList] values (7109, 'IBOptOutRequestedTaskStarted');
insert into [dbo].[EventIDList] values (7110, 'IBOptOutRequestedTaskEnded');
insert into [dbo].[EventIDList] values (7111, 'IBSMSReceivedTaskStarted');
insert into [dbo].[EventIDList] values (7112, 'IBSMSReceivedTaskEnded');
insert into [dbo].[EventIDList] values (7113, 'OBSMSRequestedTaskStarted');
insert into [dbo].[EventIDList] values (7114, 'OBSMSRequestedTaskEnded');
insert into [dbo].[EventIDList] values (10318, 'SuspendCardRequestedStarted');
insert into [dbo].[EventIDList] values (10319, 'SuspendCardRequestedEnded');
insert into [dbo].[EventIDList] values (10320, 'SuspendCardAccountBasedPendingStarted');
insert into [dbo].[EventIDList] values (10321, 'SuspendCardAccountBasedPendingEnded');
insert into [dbo].[EventIDList] values (10322, 'ResumeCardRequestedStart');
insert into [dbo].[EventIDList] values (10323, 'ResumeCardRequestedEnd');
insert into [dbo].[EventIDList] values (10324, 'ResumeCardAccountBasedPendingStart');
insert into [dbo].[EventIDList] values (10325, 'ResumeCardAccountBasedPendingEnd');
insert into [dbo].[EventIDList] values (10326, 'TerminateCardRequestedStarted');
insert into [dbo].[EventIDList] values (10327, 'TerminateCardRequestedEnded');
insert into [dbo].[EventIDList] values (10328, 'TerminateCardAccountBasedPendingStarted');
insert into [dbo].[EventIDList] values (10329, 'TerminateCardAccountBasedPendingEnded');
insert into [dbo].[EventIDList] values (10330, 'TerminateCardCloseAccountPendingStarted');
insert into [dbo].[EventIDList] values (10331, 'TerminateCardCloseAccountPendingEnded');
insert into [dbo].[EventIDList] values (10332, 'TerminateCardTerminateAccountPendingStarted');
insert into [dbo].[EventIDList] values (10333, 'TerminateCardTerminateAccountPendingEnded');
insert into [dbo].[EventIDList] values (10334, 'ReplacementCardCheckCardStatePendingStarted');
insert into [dbo].[EventIDList] values (10335, 'ReplacementCardCheckCardStatePendingEnded');
insert into [dbo].[EventIDList] values (10336, 'ReplacementCardAccountBasedTerminationPendingStarted');
insert into [dbo].[EventIDList] values (10337, 'ReplacementCardAccountBasedTerminationPendingEnded');
insert into [dbo].[EventIDList] values (10338, 'NewCardAddMemberIssueSmartCardPendingStarted');
insert into [dbo].[EventIDList] values (10339, 'NewCardAddMemberIssueSmartCardPendingEnded');
insert into [dbo].[EventIDList] values (10340, 'NewCardUpdateMemberIssueSmartCardPendingStarted');
insert into [dbo].[EventIDList] values (10341, 'NewCardUpdateMemberIssueSmartCardPendingEnded');
insert into [dbo].[EventIDList] values (10342, 'NewCardAddMemberUpdateRiderClassStarted');
insert into [dbo].[EventIDList] values (10343, 'NewCardAddMemberUpdateRiderClassEnded');
insert into [dbo].[EventIDList] values (10344, 'NewCardAddMemberUpdateRiderClassPendingStarted');
insert into [dbo].[EventIDList] values (10345, 'NewCardAddMemberUpdateRiderClassPendingEnded');
insert into [dbo].[EventIDList] values (13029, 'RemediationBatchSubmitStarted');
insert into [dbo].[EventIDList] values (13030, 'RemediationBatchSubmitFailed');
insert into [dbo].[EventIDList] values (13031, 'RemediationBatchSubmitEnded');
insert into [dbo].[EventIDList] values (13032, 'RemediationBatchResultUpdateStarted');
insert into [dbo].[EventIDList] values (13033, 'RemediationBatchResultUpdateFailed');
insert into [dbo].[EventIDList] values (13034, 'RemediationBatchResultUpdateEnded');
insert into [dbo].[EventIDList] values (13035, 'RemediationInboundMonitorStarted');
insert into [dbo].[EventIDList] values (13036, 'RemediationInboundMonitorFailed');
insert into [dbo].[EventIDList] values (13037, 'RemediationInboundMonitorEnded');

go
