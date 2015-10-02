-- jtang: 05_post_data_initializaion_schema_changes

-- fix duplicate category name (both 8 and 10 have the same category name) 
update [dbo].[CategoryIDList] set CategoryName = 'MediaRequestFileProcessor' where CategoryID = 10;

go

