-- jtang: 06_stored_procedures

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


CREATE PROCEDURE [dbo].[TL_RetrieveEventLog] (@startDate Datetime, @endDate Datetime)
AS
BEGIN
       
       SET NOCOUNT ON;

                     SELECT 
                           el.ID,
                           el.Source,
                           el.Category,
                           c.CategoryID,
                           e.EventName AS Event,
                           el.EventID,
                           el.Level,
                           el.Computer,
                           el.LoggedTime,
                           env.Environment,
                           DATEPART(MM,el.LoggedTime) As Month,
                           DATEPART(YYYY,el.LoggedTime) As Year,
                           DATEPART(DD,el.LoggedTime) As Day,
                           el.XMLdata
     
                     FROM
                     TL_StgESEventLogs el WITH (NOLOCK)
                     LEFT OUTER JOIN EventIDList e ON el.EventID = e.EventID
                     LEFT OUTER JOIN CategoryIDList c ON el.Category = c.CategoryName           
                     LEFT OUTER JOIN CPGEnvironments env ON el.Computer = env.ServerName                                                                           
      
                     WHERE el.LoggedTime >= @startDate 
                           and el.LoggedTime <= @endDate
                           and el.XMLData.value('(/rawData/ProcessDatetime)[1]', 'varchar(100)') is not null  
                     ORDER BY 9 DESC
       

END--PROC

GO


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
