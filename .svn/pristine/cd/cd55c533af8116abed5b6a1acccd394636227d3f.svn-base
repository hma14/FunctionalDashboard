CREATE TABLE [dbo].[ESObjectTracking] (
    [recorddate_unix]     INT          NULL,
    [recorddate]          DATETIME     NULL,
    [computername]        INT          NULL,
    [filename]            INT          NULL,
    [filepath]            INT          NULL,
    [username]            INT          NULL,
    [LogonID]             VARCHAR (16) NULL,
    [caller_filename]     INT          NULL,
    [caller_filepath]     INT          NULL,
    [caller_pid]          INT          NULL,
    [Action]              INT          NULL,
    [AccessMask]          INT          NULL,
    [Verified]            INT          NULL,
    [eventnumber]         BIGINT       NULL,
    [filename_new]        INT          NULL,
    [filepath_new]        INT          NULL,
    [SourceComputer]      INT          NULL,
    [SourceIP]            INT          NULL,
    [bReadData]           INT          NULL,
    [bReadAttributes]     INT          NULL,
    [bReadEA]             INT          NULL,
    [bWriteData]          INT          NULL,
    [bAppendData]         INT          NULL,
    [bWriteAttributes]    INT          NULL,
    [bWriteEA]            INT          NULL,
    [bDelete]             INT          NULL,
    [bChangePermissions]  INT          NULL,
    [bSetOwner]           INT          NULL,
    [Checksum]            VARCHAR (64) NULL,
    [recordtype]          INT          NULL,
    [VerifiedOperational] INT          NULL,
    CONSTRAINT [FK_ESObjectTracking_ESEventlogComputer] FOREIGN KEY ([computername]) REFERENCES [dbo].[ESEventlogComputer] ([id]),
    CONSTRAINT [FK_ESObjectTracking_ESEventlogComputer_Source] FOREIGN KEY ([SourceComputer]) REFERENCES [dbo].[ESEventlogComputer] ([id]),
    CONSTRAINT [FK_ESObjectTracking_ESEventlogFilename] FOREIGN KEY ([filename]) REFERENCES [dbo].[ESEventlogFilename] ([id]),
    CONSTRAINT [FK_ESObjectTracking_ESEventlogFilename_Caller] FOREIGN KEY ([caller_filename]) REFERENCES [dbo].[ESEventlogFilename] ([id]),
    CONSTRAINT [FK_ESObjectTracking_ESEventlogFilename_New] FOREIGN KEY ([filename_new]) REFERENCES [dbo].[ESEventlogFilename] ([id]),
    CONSTRAINT [FK_ESObjectTracking_ESEventlogFilepath] FOREIGN KEY ([filepath]) REFERENCES [dbo].[ESEventlogFilepath] ([id]),
    CONSTRAINT [FK_ESObjectTracking_ESEventlogFilepath_Caller] FOREIGN KEY ([caller_filepath]) REFERENCES [dbo].[ESEventlogFilepath] ([id]),
    CONSTRAINT [FK_ESObjectTracking_ESEventlogFilepath_New] FOREIGN KEY ([filepath_new]) REFERENCES [dbo].[ESEventlogFilepath] ([id]),
    CONSTRAINT [FK_ESObjectTracking_ESEventlogUser] FOREIGN KEY ([username]) REFERENCES [dbo].[ESEventlogUser] ([id]),
    CONSTRAINT [FK_ESObjectTracking_ESIPAddress] FOREIGN KEY ([SourceIP]) REFERENCES [dbo].[ESIPAddress] ([id])
);


GO
CREATE CLUSTERED INDEX [IDX_ES_ObjectTracking]
    ON [dbo].[ESObjectTracking]([recorddate] ASC) WITH (FILLFACTOR = 80);

