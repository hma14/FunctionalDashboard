CREATE TABLE [dbo].[ESSyslogFacility] (
    [id]       INT          IDENTITY (1, 1) NOT NULL,
    [name]     VARCHAR (64) NULL,
    [ESSyslog] INT          NULL,
    CONSTRAINT [PK_ESSyslogFacility] PRIMARY KEY CLUSTERED ([id] ASC)
);

