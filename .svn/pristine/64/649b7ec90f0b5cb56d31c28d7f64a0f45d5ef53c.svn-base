-- jtang: 06_stored_procedures

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE dbo.CheckSLTRuleIsActive(@eventID int, @categoryID int, @programID int, @institutionID int)
AS
BEGIN
	select count(*) from CPGFD_SLTRules 
	where EventID=@eventID and CategoryID=@categoryID and ProgramID=@programID and InstitutionID=@institutionID and Status=1

END

GO
CREATE PROCEDURE dbo.ClearFromCPGFD_SLTTracking(@ID int)
AS
BEGIN
	UPDATE [dbo].[CPGFD_SLTTracking] 
	SET Status=4
	WHERE EventID=@ID 	  

END

GO
CREATE PROCEDURE dbo.ExistInCPGFD_SLTTracking( @ruleID varchar(10))
AS
BEGIN
	SELECT COUNT(*) FROM [dbo].[CPGFD_SLTTracking] 
	WHERE SLTRuleID=@ruleID AND (Status=1 OR Status=2)
END

GO
CREATE PROCEDURE dbo.InsertCPGFD_SLTTracking( @eventID int,@categoryID int,  @programID varchar(10), @institutionID varchar(10),  @ruleID int, @ruleDescription text,
										 @startDatetime Datetime, @warningDatetime Datetime, @breachDatetime Datetime, @completeDatetime Datetime=null, 
										 @status tinyint, @user nvarchar(50))
AS
BEGIN

	INSERT INTO CPGFD_SLTTracking VALUES( @eventID, @categoryID, @programID, @institutionID, @ruleID, @ruleDescription, 
										 @startDatetime, @warningDatetime, @breachDatetime,
										 @completeDatetime, @status, GETDATE(), @user)
	
END

GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[InsertErrorMsg](@cate int,  @evt int, @message text, @processDatetime bigint, @status tinyint, @updatedBy nvarchar(50), 
									   @programID varchar(10) = null, @institutionID varchar(10) = null )
	AS

	DECLARE @errorListID INT;
	IF (@programID is not null)
		BEGIN			
			set @errorListID = (select ID from CPGFD_ErrorList  where ProcessDatetime >= @processDatetime and 
																	  ProgramID = @programID and 
																	  InstitutionID = @institutionID and 
																	  EventID = @evt and 
																	  CategoryID = @cate);
		END
	ELSE
		BEGIN
			set @errorListID = (select ID from CPGFD_ErrorList  where ProcessDatetime >= @processDatetime and 
																	  EventID = @evt and 
																	  CategoryID = @cate);
		END
		insert into CPGFD_ErrorMsg values(@errorListID, @message, @status, @updatedBy, GETDATE())

GO

create PROCEDURE [dbo].[IsExistInErrorList] (@cate int, @evt int,  @processDatetime bigint, @programID varchar(10) = null, @institutionID varchar(10) = null )
AS
BEGIN
	
	SET NOCOUNT ON;
	if (@programID is null)
		begin
			select COUNT(*)
			from CPGFD_ErrorList l
			where l.CategoryID = @cate and l.EventID = @evt 
			and l.ProcessDatetime >= @processDatetime
		end
	else
		begin
			select COUNT(*)
			from CPGFD_ErrorList l
			where l.CategoryID = @cate and l.EventID = @evt and 
			l.ProcessDatetime >= @processDatetime and 
			l.ProgramID = @programID and l.InstitutionID = @institutionID
		end
END


GO
CREATE PROCEDURE [dbo].RetrieveAllCPGFD_SLTTracking
AS
BEGIN

 
	SELECT t.ID as ID
	,t.SLTRuleID as SLTRuleID
	,t.ProgramID as ProgramID
	,t.InstitutionID as InstitutionID
	,nf.Name as Institution
	,c.CategoryName as Category
	,t.CategoryID as CategoryID
	,e.EventName  as Event	 
	,t.EventID as EventID
	,r.RuleDescription as RuleDescription
	,t.SLTStartDatetime as SLTStartDatetime
	,t.SLTWarningDatetime as SLTWarningDatetime
	,t.SLTBreachDatetime as SLTBreachDatetime
	,t.SLTCompleteDatetime as SLTCompleteDatetime
	,t.Status	as Status
	FROM [dbo].[CPGFD_SLTTracking]  t
	INNER JOIN [dbo].[CPGFD_SLTRules] r ON t.SLTRuleID=r.ID
	INNER JOIN [dbo].[EventIDList] e ON t.EventID=e.EventID
	INNER JOIN [dbo].[CategoryIDList]  c on t.CategoryID=c.CategoryID
	INNER JOIN [dbo].[NCSInfo] nf on t.InstitutionID=nf.InstitutionId
	WHERE  t.Status in (1, 2, 3)
	

END

GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
create PROCEDURE [dbo].[RetrieveCPGFD_ErrorMsg](@cate int, @evt int, @processDatetime bigint,
									            @programID varchar(10) = null, @institutionID varchar(10) = null) 
	
AS
BEGIN
	if (@programID is null)
		BEGIN
			select m.Message, m.UpdatedBy, m.UpdatedDatetime
			from [dbo].[CPGFD_ErrorMsg] m
			inner join [dbo].[CPGFD_ErrorList] l on m.ErrorListID = l.ID
			where l.ProcessDatetime >= @processDatetime and l.CategoryID = @cate and l.EventID = @evt 
		END
		
	else
		BEGIN
			select m.Message, m.UpdatedBy, m.UpdatedDatetime
			from [dbo].[CPGFD_ErrorMsg] m
			inner join [dbo].[CPGFD_ErrorList] l on m.ErrorListID = l.ID
			where l.ProcessDatetime >= @processDatetime and l.CategoryID = @cate and l.EventID = @evt and 
				  l.ProgramID = @programID and l.InstitutionID = @institutionID
		END
END

GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[RetrieveCPGFD_KB](@eventID int, @categoryID int)
AS
BEGIN
	select EventID, CategoryID, Status, Description, PotentialErrors, BusinessImpact, 
		   Sev, Resolutions, CreatedBy,  CreatedDatetime, UpdatedBy, UpdatedDatetime
	from [dbo].[CPGFD_KB]
	where EventID=@eventID and CategoryID=@categoryID
END

GO
create PROCEDURE [dbo].RetrieveCPGFD_SLTRules
AS
BEGIN
	select ID
		,[EventID]
		,[CategoryID]
		,[ProgramID]
		,[InstitutionID]
		,[RuleDescription]
		,[RuleType]
		,[DayOfWeek]
		,[RuleDay]
		,[RuleTime]
		,[WarningThreshold]		
		,[Status]
		,[NextTriggerDatetime]
		,[UpdatedDatetime]
		,[UpdatedUser]

	from [dbo].[CPGFD_SLTRules]
	where Status=1
END

GO
CREATE PROCEDURE [dbo].RetrieveCPGFD_SLTTracking( @ruleID bigint)
AS
BEGIN

	SELECT ID
	,SLTRuleID
	,ProgramID
	,InstitutionID
	,CategoryID
	,EventID
	,SLTStartDatetime
	,SLTWarningDatetime
	,SLTBreachDatetime
	,SLTCompleteDatetime
	,Status
	
	FROM [dbo].[CPGFD_SLTTracking] 
	WHERE SLTRuleID=@ruleID AND (Status=1 OR Status=2)

END

GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[RetrieveErrorExceptions]
AS
BEGIN
	select EventID, CategoryID, Status from CPGFD_ErrorExceptions 
	
END

GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[RetrieveErrorListRecords]
AS
BEGIN
	
	SET NOCOUNT ON;

	select ProgramID, InstitutionID, EventID, CategoryID, ProcessDatetime, Status, UpdatedBy, UpdatedDatetime 
	from CPGFD_ErrorList
END


GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[RetrieveErrorStatus] (@eventID int, @categoryID int, @processDatetime Datetime = null)

AS
BEGIN
	declare @res int
	if (@processDatetime is null)
		begin		
			set @res = (select count(*) from CPGFD_ErrorList where EventID = @eventID and CategoryID = @categoryID )
			if (@res <> 0)
				begin
					select Status from CPGFD_ErrorList
					where EventID = @eventID and CategoryID = @categoryID 
				end
			else
				begin
					select -1
				end
		end
	else
		begin
			set @res = (select count(*) from CPGFD_ErrorList where EventID = @eventID and CategoryID = @categoryID and ProcessDatetime = @processDatetime )
			if (@res <> 0)
				begin
					select Status from CPGFD_ErrorList
					where EventID = @eventID and CategoryID = @categoryID and ProcessDatetime = @processDatetime
				end
			else
				begin
					select -1
				end
		end
END

GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[RetrieveEventSentryStatus] 
	
AS
BEGIN
	select c.eventcomputer Server,
       LastUpdateTime = dateadd(mi, datediff(mi, getutcdate(),getdate()),max(eventtime))
	from ESEventlogMain m, ESEventlogComputer c with (NOLOCK)
	where c.id = m.eventcomputer
	group by c.eventcomputer
END

GO
-- =============================================
-- Author:		jun tang
-- Create date: <Create Date,,>
-- Description:	return all NCSINFO
-- =============================================
CREATE PROCEDURE [dbo].[usp_RetrieveNCSInfo]
AS
BEGIN
	SELECT OrganizationId, upper(InstitutionId) as InstitutionId, ProgramId, Active, Name, ShortName
	FROM NCSInfo
END

GO
CREATE PROCEDURE [dbo].[usp_RetrieveTLEventLog] (@startDate Datetime, @endDate Datetime)
AS
BEGIN
      
      SELECT [ID]
      ,[SourceLogID]
      ,[LogName]
      ,[Level]
      ,[Source]
      ,el.[Category]
	  ,isnull(c.CategoryID, 0) as CategoryID
      ,el.[EventID]
	  ,e.EventName as [Event]
      ,[Computer]
      ,[LoggedTime]
      ,env.Environment
      ,[ProgramID]
      ,upper([InstitutionID]) as [InstitutionID]
      ,[UploadFileName]
      ,[FileStatus]
      ,[RequestTxID]
      ,[GUID]
      ,[TaskID]
      ,[StateID]
      ,[UniqueParticipantId]
      ,[CardSerialNumber]
      ,[ExistingCardSN]
      ,[Action]
      ,[ReasonCode]
      ,[Benefit]
      ,[CardTypeCode]
      ,[SuccessFailureCode]
      ,[SuccessFailureDescr]
      ,[ActionExecuted]
      ,[TSID]
      ,[Elig]
      ,[EligDate]
      ,[Rval]
      ,[Rext]
      ,isnull([BenefitID],0) as [BenefitID]
      ,isnull([BenefitProductID],0) as [BenefitProductID]
      ,isnull([BenefitMonth],0) as [BenefitMonth]
      ,isnull([BenefitYear],0) as [BenefitYear]
      ,[URI]
      ,[URIType]
      ,[ProcessDatetime]
      ,[ProcessErrorID]
	  ,Year([ProcessDatetime]) as [Year]
	  ,Month([ProcessDatetime]) as [Month]
	  ,Day([ProcessDatetime]) as [Day]
  FROM [dbo].[TL_EventLog] el
  Left outer join EventIDList e ON el.EventID = e.EventID
  LEFT OUTER JOIN CategoryIDList c ON el.Category = c.CategoryName 
  LEFT OUTER JOIN CPGEnvironments env ON el.Computer = env.ServerName
 WHERE el.LoggedTime >= @startDate 
   and el.LoggedTime <= @endDate
 order by el.LoggedTime desc

END--PROC

GO


--
-- jtang: return error description and stack trace of a specifying log 
--
CREATE PROCEDURE [dbo].[usp_RetrieveTLEventLogErrorDetail] (@logId bigint)
AS
BEGIN

	SELECT ID, xmldata.value('(/rawData/ProcessErrorDescr/node())[1]','varchar(4000)') as ProcessErrorDescr
		   ,xmldata.value('(/rawData/StackTrace/node())[1]','varchar(4000)') as StackTrace
	  FROM [dbo].[TL_EventLog]
	 WHERE ID = @logId

END--PROC

GO


CREATE PROCEDURE [dbo].RetrieveTrackingEntryFromTL_EventLog(@eventID int, @categoryID int, @programID varchar(10), @institutionID varchar(10), 
													 @startDatetime Datetime, @breachDatetime Datetime)
AS
BEGIN
	declare @category varchar(255);
	set @category = (select CategoryName from CategoryIDList where CategoryID=@categoryID);
	
      SELECT [ID]
      ,[SourceLogID]
      ,[LogName]
      ,[Level]
      ,[Source]
      ,[Category]
	  ,[EventID]
      ,[Computer]
      ,[LoggedTime]
      ,[ProgramID]
      ,[InstitutionID]
      ,[UploadFileName]
      ,[FileStatus]
      ,[RequestTxID]
      ,[GUID]
      ,[TaskID]
      ,[StateID]
      ,[UniqueParticipantId]
      ,[CardSerialNumber]
      ,[ExistingCardSN]
      ,[Action]
      ,[ReasonCode]
      ,[Benefit]
      ,[CardTypeCode]
      ,[SuccessFailureCode]
      ,[SuccessFailureDescr]
      ,[ActionExecuted]
      ,[TSID]
      ,[Elig]
      ,[EligDate]
      ,[Rval]
      ,[Rext]
      ,[BenefitID]
      ,[BenefitProductID]
      ,[BenefitMonth]
      ,[BenefitYear]
      ,[URI]
      ,[URIType]
	  ,[ProcessDatetime]
      ,[ProcessErrorID]
	 
	from [dbo].[TL_EventLog] 
	where EventID=@eventID 
		  and Category= @category
		  and ProgramID=@programID 
		  and InstitutionID=@institutionID
		  and ProcessDatetime > @startDatetime
		  and ProcessDatetime < @breachDatetime

END

GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].RetrieveUserRole
AS
BEGIN
	select u.UserName, u.FullName, u.Email, r.RoleName 
	from CPGFD_Users u
	inner join CPGFD_UsersInRoles ur on u.UserID = ur.UserID
	inner join CPGFD_Roles r on ur.RoleID = r.RoleID
END
go
CREATE PROCEDURE [dbo].[UpdateCPGFD_KB](@eventID int, @categoryID int, @status tinyint, 
								@description text, @potentialErrors text, @businessImpact text,
								@sev tinyint, @resolutions text, @updatedBy nvarchar(50))
AS
BEGIN	
	if( not exists (select 1 from CPGFD_KB where EventID=@eventID and CategoryID=@categoryID))
		begin 
			insert into CPGFD_KB (EventID, CategoryID, Status, Description, PotentialErrors, BusinessImpact, 
								  Sev, Resolutions, CreatedBy, CreatedDatetime, UpdatedBy, UpdatedDatetime)
						   values(@eventID, @categoryID,  @status, @description, @potentialErrors, @businessImpact, 
								  @sev, @resolutions, @updatedBy,  GETDATE(), @updatedBy, GETDATE())			
		end
	else
		begin
			update CPGFD_KB 
			set Status = @status, Description = @description, PotentialErrors = @potentialErrors,
				BusinessImpact = @businessImpact, Sev = @sev, Resolutions = @resolutions,
				UpdatedBy = @updatedBy, UpdatedDatetime = GETDATE()
			where EventID=@eventID and CategoryID=@categoryID
		end	
END

GO
CREATE PROCEDURE [dbo].UpdateCPGFD_SLTRules_By_NextTriggerDatetime(@eventID int, @categoryID int, @programID varchar(10), @institutionID varchar(10), 
															 @nextTriggerDatetime Datetime, @user nvarchar(50))
AS
BEGIN

	UPDATE [dbo].[CPGFD_SLTRules] SET [NextTriggerDatetime]=@nextTriggerDatetime, [UpdatedDatetime]=GETDATE(), [UpdatedUser]=@user
		
	WHERE EventID=@eventID 
		  AND CategoryID= @categoryID
		  AND ProgramID=@programID 
		  AND InstitutionID=@institutionID
END

GO
CREATE PROCEDURE [dbo].UpdateCPGFD_SLTTracking( @id bigint, @completeDatetime Datetime=NULL, @status tinyint, @user nvarchar(50))
AS
BEGIN
	UPDATE CPGFD_SLTTracking SET [SLTCompleteDatetime]=@completeDatetime, [Status]=@status, [UpdatedDatetime]=GETDATE(), [UpdatedUser]=@user
	WHERE ID=@id 
END

GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[UpdateErrorList](@eventID int, @categoryID int, @processDatetime bigint, 
										@status int, @updatedby varchar(50), @programID varchar(10) = null, 
										@institutionID varchar(10) = null)
AS
BEGIN
	if (@programID is not null)
		begin
			if (not exists (select 1 from CPGFD_ErrorList where ProgramID = @programID and
																InstitutionID = @institutionID and
																EventID = @eventID and 
																CategoryID = @categoryID
																) ) 
				begin
					insert into CPGFD_ErrorList values(@programID, @institutionID, @eventID, 
													   @categoryID, @processDatetime, @status, @updatedby, GETDATE())
				end
			else
				begin 
					update CPGFD_ErrorList 
					set ProcessDatetime = @processDatetime, Status = @status, UpdatedBy = @updatedby, UpdatedDatetime = GETDATE()
					where ProgramID = @programID and InstitutionID = @institutionID and EventID = @eventID and CategoryID = @categoryID 
				end
		end
	else
		begin
			if (not exists (select 1 from CPGFD_ErrorList where EventID = @eventID and CategoryID = @categoryID ) ) 
				begin
					insert into CPGFD_ErrorList values(@programID, @institutionID, @eventID, @categoryID, 
													@processDatetime, @status, @updatedby, GETDATE())
				end
			else
				begin 
					update CPGFD_ErrorList 
					set ProcessDatetime = @processDatetime, Status = @status, UpdatedBy = @updatedby, UpdatedDatetime = GETDATE()
					where ProgramID = @programID and InstitutionID = @institutionID and EventID = @eventID and CategoryID = @categoryID 
				end
		end
END


GO
--
-- jtang: update rule status by rule id
--
CREATE PROCEDURE [dbo].[usp_UpdateSLTRuleStatusById]( @id bigint, @status tinyint, @user nvarchar(50))
AS
BEGIN
	UPDATE CPGFD_SLTRules SET [Status]=@status, [UpdatedDatetime]=GETDATE(), [UpdatedUser]=@user
	WHERE ID=@id 
END

go

