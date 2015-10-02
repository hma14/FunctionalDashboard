﻿CREATE TABLE [dbo].[ESFileMainDelim] (
    [id]               BIGINT         IDENTITY (1, 1) NOT NULL,
    [recorddate]       DATETIME       NULL,
    [filename]         INT            NULL,
    [filepath]         INT            NULL,
    [filename_actual]  INT            NULL,
    [filepath_actual]  INT            NULL,
    [computername]     INT            NULL,
    [filetype]         INT            NULL,
    [revision]         INT            NULL,
    [field_1]          INT            NULL,
    [field_2]          INT            NULL,
    [field_3]          INT            NULL,
    [field_4]          INT            NULL,
    [field_5]          INT            NULL,
    [field_6]          INT            NULL,
    [field_7]          INT            NULL,
    [field_8]          INT            NULL,
    [field_9]          INT            NULL,
    [field_10]         INT            NULL,
    [field_11]         INT            NULL,
    [field_12]         INT            NULL,
    [field_13]         INT            NULL,
    [field_14]         INT            NULL,
    [field_15]         INT            NULL,
    [field_16]         INT            NULL,
    [field_17]         INT            NULL,
    [field_18]         INT            NULL,
    [field_19]         VARCHAR (32)   NULL,
    [field_20]         VARCHAR (32)   NULL,
    [field_21]         VARCHAR (32)   NULL,
    [field_22]         VARCHAR (32)   NULL,
    [field_23]         VARCHAR (512)  NULL,
    [field_24]         VARCHAR (512)  NULL,
    [field_25]         VARCHAR (512)  NULL,
    [field_26]         VARCHAR (512)  NULL,
    [field_27]         VARCHAR (1024) NULL,
    [field_28]         VARCHAR (1024) NULL,
    [field_29]         INT            NULL,
    [field_30]         INT            NULL,
    [field_31]         INT            NULL,
    [field_32]         INT            NULL,
    [field_33]         INT            NULL,
    [field_34]         INT            NULL,
    [field_35]         INT            NULL,
    [field_36]         INT            NULL,
    [file_description] INT            NULL,
    CONSTRAINT [PK_ESFileMainDelim] PRIMARY KEY CLUSTERED ([id] ASC),
    CONSTRAINT [FK_ESFileMainDelim_ESEventlogComputer] FOREIGN KEY ([computername]) REFERENCES [dbo].[ESEventlogComputer] ([id]),
    CONSTRAINT [FK_ESFileMainDelim_ESFileName1] FOREIGN KEY ([filename]) REFERENCES [dbo].[ESEventlogFilename] ([id]),
    CONSTRAINT [FK_ESFileMainDelim_ESFileName2] FOREIGN KEY ([filename_actual]) REFERENCES [dbo].[ESEventlogFilename] ([id]),
    CONSTRAINT [FK_ESFileMainDelim_ESFilePath1] FOREIGN KEY ([filepath]) REFERENCES [dbo].[ESEventlogFilepath] ([id]),
    CONSTRAINT [FK_ESFileMainDelim_ESFilePath2] FOREIGN KEY ([filepath_actual]) REFERENCES [dbo].[ESEventlogFilepath] ([id]),
    CONSTRAINT [FK_ESFileMainDelim_ESLookup1] FOREIGN KEY ([field_29]) REFERENCES [dbo].[ESFileLookup1] ([id]),
    CONSTRAINT [FK_ESFileMainDelim_ESLookup2] FOREIGN KEY ([field_30]) REFERENCES [dbo].[ESFileLookup2] ([id]),
    CONSTRAINT [FK_ESFileMainDelim_ESLookup3] FOREIGN KEY ([field_31]) REFERENCES [dbo].[ESFileLookup3] ([id]),
    CONSTRAINT [FK_ESFileMainDelim_ESLookup4] FOREIGN KEY ([field_32]) REFERENCES [dbo].[ESFileLookup4] ([id]),
    CONSTRAINT [FK_ESFileMainDelim_ESLookup5] FOREIGN KEY ([field_33]) REFERENCES [dbo].[ESFileLookup5] ([id]),
    CONSTRAINT [FK_ESFileMainDelim_ESLookup6] FOREIGN KEY ([field_34]) REFERENCES [dbo].[ESFileLookup6] ([id]),
    CONSTRAINT [FK_ESFileMainDelim_ESLookup7] FOREIGN KEY ([field_35]) REFERENCES [dbo].[ESFileLookup7] ([id]),
    CONSTRAINT [FK_ESFileMainDelim_ESLookup8] FOREIGN KEY ([field_36]) REFERENCES [dbo].[ESFileLookup8] ([id]),
    CONSTRAINT [FK_ESFileMainDelim_ESStrings] FOREIGN KEY ([file_description]) REFERENCES [dbo].[ESStrings] ([id])
);


GO
CREATE NONCLUSTERED INDEX [IDX_ES_FileMainDelim]
    ON [dbo].[ESFileMainDelim]([recorddate] ASC) WITH (FILLFACTOR = 80);

