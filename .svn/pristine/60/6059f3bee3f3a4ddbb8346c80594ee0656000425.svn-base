
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