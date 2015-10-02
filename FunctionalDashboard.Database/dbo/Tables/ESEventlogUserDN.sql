CREATE TABLE [dbo].[ESEventlogUserDN] (
    [id]                      INT            IDENTITY (1, 1) NOT NULL,
    [name]                    VARCHAR (1024) NULL,
    [ESTrackingAccountGroups] INT            NULL,
    CONSTRAINT [PK_ESEventlogUserDN] PRIMARY KEY CLUSTERED ([id] ASC)
);

