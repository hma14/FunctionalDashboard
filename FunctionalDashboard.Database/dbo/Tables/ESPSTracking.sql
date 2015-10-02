CREATE TABLE [dbo].[ESPSTracking] (
    [process_id_part1]         INT           NULL,
    [process_id_part2]         INT           NULL,
    [process_creator_id_part1] INT           NULL,
    [process_creator_id_part2] INT           NULL,
    [computername]             INT           NULL,
    [username]                 INT           NULL,
    [filename]                 INT           NULL,
    [filepath]                 INT           NULL,
    [groupname]                INT           NULL,
    [start_unix]               INT           NULL,
    [start_datetime]           DATETIME      NULL,
    [duration]                 INT           NULL,
    [incomplete]               INT           NULL,
    [LogonID]                  VARCHAR (20)  NULL,
    [eventnumber]              BIGINT        NULL,
    [ComputerProductType]      VARCHAR (3)   NULL,
    [commandline]              VARCHAR (512) NULL,
    [token_elevation]          INT           NULL,
    CONSTRAINT [FK_ESPSTracking_ESEventlogComputer] FOREIGN KEY ([computername]) REFERENCES [dbo].[ESEventlogComputer] ([id]),
    CONSTRAINT [FK_ESPSTracking_ESEventlogFilename] FOREIGN KEY ([filename]) REFERENCES [dbo].[ESEventlogFilename] ([id]),
    CONSTRAINT [FK_ESPSTracking_ESEventlogFilepath] FOREIGN KEY ([filepath]) REFERENCES [dbo].[ESEventlogFilepath] ([id]),
    CONSTRAINT [FK_ESPSTracking_ESEventlogUser] FOREIGN KEY ([username]) REFERENCES [dbo].[ESEventlogUser] ([id]),
    CONSTRAINT [FK_ESPSTracking_FKESEventlogGroup] FOREIGN KEY ([groupname]) REFERENCES [dbo].[ESEventlogGroup] ([id])
);


GO
CREATE CLUSTERED INDEX [IDX_ES_PSTracking]
    ON [dbo].[ESPSTracking]([start_datetime] ASC) WITH (FILLFACTOR = 80);


GO
CREATE NONCLUSTERED INDEX [IDX_ES_PSTracking_Computer]
    ON [dbo].[ESPSTracking]([computername] ASC) WITH (FILLFACTOR = 80);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IDX_ES_PSTracking_Unique]
    ON [dbo].[ESPSTracking]([process_id_part2] ASC, [process_creator_id_part2] ASC, [computername] ASC, [username] ASC, [filename] ASC, [filepath] ASC, [start_unix] ASC, [eventnumber] ASC);


GO
CREATE NONCLUSTERED INDEX [IDX_ESPSTracking_UpdateDuration]
    ON [dbo].[ESPSTracking]([process_id_part1] ASC, [process_id_part2] ASC, [computername] ASC, [start_unix] ASC, [incomplete] ASC, [eventnumber] ASC);

