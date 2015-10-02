CREATE TABLE [dbo].[ESVersion] (
    [id]         INT           IDENTITY (1, 1) NOT NULL,
    [recorddate] DATETIME      NULL,
    [product]    VARCHAR (128) NULL,
    [build]      VARCHAR (32)  NULL,
    CONSTRAINT [PK_ESVersion] PRIMARY KEY CLUSTERED ([id] ASC)
);

