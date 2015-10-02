CREATE TABLE [dbo].[ESEventlogGUID] (
    [id]                  INT          IDENTITY (1, 1) NOT NULL,
    [name]                VARCHAR (64) NULL,
    [ESTrackingPolicy]    INT          NULL,
    [ESTrackingLogonAuth] INT          NULL,
    CONSTRAINT [PK_ESEventlogGUID] PRIMARY KEY CLUSTERED ([id] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IDX_ES_EventlogGUID]
    ON [dbo].[ESEventlogGUID]([name] ASC);

