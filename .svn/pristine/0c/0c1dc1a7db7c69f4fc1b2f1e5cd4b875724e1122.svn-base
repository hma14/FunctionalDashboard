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
