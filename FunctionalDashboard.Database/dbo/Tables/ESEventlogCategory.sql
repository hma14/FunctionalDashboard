CREATE TABLE [dbo].[ESEventlogCategory] (
    [id]             INT           IDENTITY (1, 1) NOT NULL,
    [eventcategory]  VARCHAR (196) NULL,
    [ESEventlogMain] INT           NULL,
    [ESHeartbeat]    INT           NULL,
    CONSTRAINT [PK_ESEventlogCategory] PRIMARY KEY CLUSTERED ([id] ASC)
);

