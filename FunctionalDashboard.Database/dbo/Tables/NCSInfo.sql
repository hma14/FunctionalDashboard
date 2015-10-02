CREATE TABLE [dbo].[NCSInfo] (
    [OrganizationId] INT           NULL,
    [InstitutionId]  VARCHAR (10)  NOT NULL,
    [ProgramId]      VARCHAR (10)  NOT NULL,
    [Active]         BIT           NOT NULL,
    [Name]           VARCHAR (100) NOT NULL,
    [ShortName]      VARCHAR (24)  NULL
);

