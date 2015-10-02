CREATE TABLE [dbo].[ESPackageAssignments] (
    [recorddate]     DATETIME      NULL,
    [computer]       INT           NULL,
    [packageType]    INT           NULL,
    [assignmentType] INT           NULL,
    [packageName]    VARCHAR (128) NULL,
    CONSTRAINT [FK_ESPackageAssignments_ESEventlogComputer] FOREIGN KEY ([computer]) REFERENCES [dbo].[ESEventlogComputer] ([id])
);


GO
CREATE CLUSTERED INDEX [IDX_ESPackageAssignments_computer]
    ON [dbo].[ESPackageAssignments]([computer] ASC) WITH (FILLFACTOR = 80);

