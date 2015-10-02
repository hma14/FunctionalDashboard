CREATE TABLE [dbo].[ESHeartbeatLType] (
    [id]   INT          IDENTITY (1, 1) NOT NULL,
    [type] VARCHAR (32) NULL,
    CONSTRAINT [PK_ESHeartbeatLType] PRIMARY KEY CLUSTERED ([id] ASC)
);

