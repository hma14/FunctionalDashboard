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