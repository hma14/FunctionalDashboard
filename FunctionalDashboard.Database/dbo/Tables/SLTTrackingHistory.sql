create table SLTTrackingHistory(
	ID INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	SLTTrackingID INT  NOT NULL,
	Message TEXT NULL,
	UpdatedBy VARCHAR (50) NULL,
	UpdatedDatetime Datetime NULL
);
