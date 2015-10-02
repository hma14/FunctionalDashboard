CREATE TABLE [dbo].[CPGFD_Users] (
    [UserID]   INT            IDENTITY (1, 1) NOT NULL,
    [UserName] NVARCHAR (255) NOT NULL,
    [FullName] NVARCHAR (255) NULL,
    [Email]    NVARCHAR (255) NULL,
    PRIMARY KEY CLUSTERED ([UserID] ASC)
);

