CREATE TABLE [dbo].[ESMotionTracking] (
    [recorddate]   DATETIME NULL,
    [computername] INT      NULL,
    [location]     INT      NULL,
    CONSTRAINT [FK_ESMotionTracking_ESEventlogComputer] FOREIGN KEY ([computername]) REFERENCES [dbo].[ESEventlogComputer] ([id]),
    CONSTRAINT [FK_ESMotionTracking_ESStrings] FOREIGN KEY ([location]) REFERENCES [dbo].[ESStrings] ([id])
);


GO
CREATE CLUSTERED INDEX [IDX_ES_MotionTracking]
    ON [dbo].[ESMotionTracking]([recorddate] ASC) WITH (FILLFACTOR = 80);

