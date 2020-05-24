/****** Object:  Database ist722_hhkhan_oc4_dw    Script Date: 5/5/2019 8:10:26 PM ******/
/*
Kimball Group, The Microsoft Data Warehouse Toolkit
Generate a database from the datamodel worksheet, version: 4

You can use this Excel workbook as a data modeling tool during the logical design phase of your project.
As discussed in the book, it is in some ways preferable to a real data modeling tool during the inital design.
We expect you to move away from this spreadsheet and into a real modeling tool during the physical design phase.
The authors provide this macro so that the spreadsheet isn't a dead-end. You can 'import' into your
data modeling tool by generating a database using this script, then reverse-engineering that database into
your tool.

Uncomment the next lines if you want to drop and create the database
*/
/*
DROP DATABASE ist722_hhkhan_oc4_dw
GO
CREATE DATABASE ist722_hhkhan_oc4_dw
GO
ALTER DATABASE ist722_hhkhan_oc4_dw
SET RECOVERY SIMPLE
GO
*/
USE ist722_hhkhan_oc4_dw
;
IF EXISTS (SELECT Name from sys.extended_properties where Name = 'Description')
    EXEC sys.sp_dropextendedproperty @name = 'Description'
EXEC sys.sp_addextendedproperty @name = 'Description', @value = 'Default description - you should change this.'
;

/* Drop table ExternalSources2.DimDate */
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'fudge.DimDate') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
DROP TABLE fudge.DimDate 
;

/* Create table fudge.DimDate */
CREATE TABLE fudge.DimDate (
   [DateKey]  int NOT NULL
,  [Date]  datetime   NULL
,  [FullDateUSA]  nchar(10)   NOT NULL
,  [DayOfWeek]  int   NOT NULL
,  [DayName]  nchar(10)   NOT NULL
,  [DayOfMonth]  int   NOT NULL
,  [DayOfYear]  int   NOT NULL
,  [WeekOfYear]  int   NOT NULL
,  [MonthName]  nchar(10)   NOT NULL
,  [MonthOfYear]  int   NOT NULL
,  [Quarter]  int   NOT NULL
,  [QuarterName]  nchar(10)   NOT NULL
,  [Year]  int   NOT NULL
,  [IsWeekday]  varchar(50)  DEFAULT '0' NOT NULL
, CONSTRAINT [PK_ExternalSources2.DimDate] PRIMARY KEY CLUSTERED 
( [DateKey] )
) ON [PRIMARY]
;


INSERT INTO fudge.DimDate (DateKey, Date, FullDateUSA, DayOfWeek, DayName, DayOfMonth, DayOfYear, WeekOfYear, MonthName, MonthOfYear, Quarter, QuarterName, Year, IsWeekday)
VALUES (-1, '', 'Unk date', 0, 'Unk date', 0, 0, 0, 'Unk month', 0, 0, 'Unk qtr', 0, '0')
;

/* Drop table fudge.DimAccount */
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'fudge.DimAccount') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
DROP TABLE fudge.DimAccount 
;

/* Create table fudge.DimAccount */
CREATE TABLE fudge.DimAccount (
   [AccountKey]  int IDENTITY  NOT NULL
,  [AccountID]  int NOT NULL
,  [AccountEmail]  varchar(200)   NOT NULL
,  [AccountName]  nvarchar(100)   NOT NULL
,  [AccountAddress]  varchar(1000)   NOT NULL
,  [AccountZipcode]  varchar(5)   NOT NULL
,  [AccountPlanID]  int   NOT NULL
,  [RowIsCurrent]  bit  DEFAULT 1 NOT NULL
,  [RowStartDate]  datetime   NOT NULL
,  [RowEndDate]  datetime  DEFAULT '12/31/9999' NOT NULL
,  [RowChangeReason]  nvarchar(200)   NOT NULL
, CONSTRAINT [PK_fudge.DimAccount] PRIMARY KEY CLUSTERED 
( [AccountKey] )
) ON [PRIMARY]
;

SET IDENTITY_INSERT fudge.DimAccount ON
;
INSERT INTO fudge.DimAccount (AccountKey, AccountID, AccountEmail, AccountName, AccountAddress, AccountZipcode, AccountPlanID, RowIsCurrent, RowStartDate, RowEndDate, RowChangeReason)
VALUES (-1, -1, '', '', '', '', NULL, 1, '12/31/1899', '12/31/9999', 'N/A')
;
SET IDENTITY_INSERT fudge.DimAccount OFF
;

/* Drop table fudge.DimCustomerAccount */
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'fudge.DimCustomerAccount') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
DROP TABLE fudge.DimCustomerAccount 
;

/* Create table fudge.DimCustomerAccount */
CREATE TABLE fudge.DimCustomerAccount (
   [CustomerAccountKey]  int IDENTITY  NOT NULL
,  [CustomerID]  int  NOT NULL
,  [CustomerEmail]  nvarchar(200)   NOT NULL
,  [CustomerName]  nvarchar(50)   NOT NULL
,  [CustomerState]  nvarchar(15)   NOT NULL
,  [CustomerCity]  nvarchar(15)   NOT NULL
,  [CustomerZip]  nvarchar(10)   NOT NULL
,  [AccountId]  int   NOT NULL
,  [AccountPlanId]  int   NOT NULL
,  [RowIsCurrent]  bit  DEFAULT 1 NOT NULL
,  [RowStartDate]  datetime   NOT NULL
,  [RowEndDate]  datetime  DEFAULT '12/31/9999' NOT NULL
,  [RowChangeReason]  nvarchar(200)   NOT NULL
, CONSTRAINT [PK_fudge.DimCustomerAccount] PRIMARY KEY CLUSTERED 
( [CustomerAccountKey] )
) ON [PRIMARY]
;

SET IDENTITY_INSERT fudge.DimCustomerAccount ON
;
INSERT INTO fudge.DimCustomerAccount (CustomerAccountKey, CustomerID, CustomerEmail, CustomerName, CustomerState, CustomerCity, CustomerZip, AccountId, AccountPlanId, RowIsCurrent, RowStartDate, RowEndDate, RowChangeReason)
VALUES (-1, -1, '', '', '', '', '', NULL, NULL, 1, '12/31/1899', '12/31/9999', 'N/A')
;
SET IDENTITY_INSERT fudge.DimCustomerAccount OFF
;

/* Drop table fudge.DimProduct */
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'fudge.DimProduct') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
DROP TABLE fudge.DimProduct 
;

/* Create table fudge.DimProduct */
CREATE TABLE fudge.DimProduct (
   [ProductKey]  int IDENTITY  NOT NULL
,  [ProductID]  int NOT NULL
,  [ProductDepartment]  varchar(20)   NOT NULL
,  [ProductName]  varchar(50)   NULL
,  [ProductIsActive]  bit   NULL
,  [RowIsCurrent]  bit   NOT NULL
,  [RowStartDate]  datetime   NOT NULL
,  [RowEndDate]  datetime  DEFAULT '12/31/9999' NOT NULL
,  [RowChangeReason]  nvarchar(200)   NOT NULL
, CONSTRAINT [PK_fudge.DimProduct] PRIMARY KEY CLUSTERED 
( [ProductKey] )
) ON [PRIMARY]
;

SET IDENTITY_INSERT fudge.DimProduct ON
;
INSERT INTO fudge.DimProduct (ProductKey, ProductID, ProductDepartment, ProductName, ProductIsActive, RowIsCurrent, RowStartDate, RowEndDate, RowChangeReason)
VALUES (-1, -1, 'Unknown', 'Unknown', Unknown, 1, '12/31/1899', '12/31/9999', 'N/A')
;
SET IDENTITY_INSERT fudge.DimProduct OFF
;


/* Drop table fudge.DimTitle */
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'fudge.DimTitle') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
DROP TABLE fudge.DimTitle 
;

/* Create table fudge.DimTitle */
CREATE TABLE fudge.DimTitle (
   [TitleKey]  int IDENTITY  NOT NULL
,  [TitleID]  varchar(20)   NOT NULL
,  [TitleName]  varchar(200)   NOT NULL
,  [TitleType]  varchar(20)   NOT NULL
,  [TitleAvgRating]  numeric(18,2)   NOT NULL
,  [TitleReleaseYearKey]  int   NOT NULL
,  [TitleRuntime]  int   NOT NULL
,  [TitleRating]  varchar(20)   NOT NULL
,  [RowIsCurrent]  bit  DEFAULT 1 NOT NULL
,  [RowStartDate]  datetime   NOT NULL
,  [RowEndDate]  datetime  DEFAULT '12/31/9999' NOT NULL
,  [RowChangeReason]  nvarchar(200)   NOT NULL
, CONSTRAINT [PK_fudge.DimTitle] PRIMARY KEY CLUSTERED 
( [TitleKey] )
) ON [PRIMARY]
;

SET IDENTITY_INSERT fudge.DimTitle ON
;
INSERT INTO fudge.DimTitle (TitleKey, TitleID, TitleName, TitleType, TitleAvgRating, TitleReleaseYearKey, TitleRuntime, TitleRating, RowIsCurrent, RowStartDate, RowEndDate, RowChangeReason)
VALUES (-1, '-1', 'Unknown', '-1', -1, -1, -1, '-1', 1, '12/31/1899', '12/31/9999', 'N/A')
;
SET IDENTITY_INSERT fudge.DimTitle OFF
;

/* Drop table fudge.DimPlan */
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'fudge.DimPlan') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
DROP TABLE fudge.DimPlan 
;

/* Create table fudge.DimPlan */
CREATE TABLE fudge.DimPlan (
   [PlanKey]  int IDENTITY  NOT NULL
,  [PlanID]  int NOT NULL
,  [PlanName]  varchar(50)   NOT NULL
,  [PlanPrice]  money   NOT NULL
,  [PlanCurrent]  bit   NOT NULL
,  [RowIsCurrent]  bit  DEFAULT 1 NOT NULL
,  [RowStartDate]  datetime   NOT NULL
,  [RowEndDate]  datetime  DEFAULT '12/31/9999' NOT NULL
,  [RowChangeReason]  nvarchar(200)   NOT NULL
, CONSTRAINT [PK_fudge.DimPlan] PRIMARY KEY CLUSTERED 
( [PlanKey] )
) ON [PRIMARY]
;

SET IDENTITY_INSERT fudge.DimPlan ON
;
INSERT INTO fudge.DimPlan (PlanKey, PlanID, PlanName, PlanPrice, PlanCurrent, RowIsCurrent, RowStartDate, RowEndDate, RowChangeReason)
VALUES (-1, -1, 'Unknown', -1, -1, 1, '12/31/1899', '12/31/9999', 'N/A')
;
SET IDENTITY_INSERT fudge.DimPlan OFF
;


/* Drop table fudge.FactDeliveryEfficiency */
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'fudge.FactDeliveryEfficiency') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
DROP TABLE fudge.FactDeliveryEfficiency 
;

/* Create table fudge.FactDeliveryEfficiency */
CREATE TABLE fudge.FactDeliveryEfficiency (
   [AccountKey]  int   NOT NULL
,  [TitleKey]  int   NOT NULL
,  [QueueDateKey]  int   NOT NULL
,  [ShippedDateKey]  int   NOT NULL
,  [shiplag]  int   NULL
, CONSTRAINT [PK_fudge.FactDeliveryEfficiency] PRIMARY KEY NONCLUSTERED 
( [AccountKey] )
) ON [PRIMARY]
;

/* Drop table fudge.FactCustomerReview */
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'fudge.FactCustomerReview') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
DROP TABLE fudge.FactCustomerReview 
;

/* Create table fudge.FactCustomerReview */
CREATE TABLE fudge.FactCustomerReview (
   [CustomerAccountNumber]  int   NULL
,  [CustomerAccountEmail]  varchar(200)   NULL
,  [DimPlanKey]  int   NOT NULL
,  [DimProductKey]  int   NOT NULL
,  [Marital Status]  varchar(255)   NOT NULL
,  [Favorite Department]  varchar(255)   NOT NULL
,  [ReviewStars]  int   NULL
,  [TitleRating]  int   NULL
,  [CsutomerAccountKey]  int   NOT NULL
,  [DimTitleKey]  int   NOT NULL
, CONSTRAINT [PK_fudge.FactCustomerReview] PRIMARY KEY NONCLUSTERED 
( [CsutomerAccountKey] )
) ON [PRIMARY]
;

ALTER TABLE fudge.FactDeliveryEfficiency ADD CONSTRAINT
   FK_fudge_FactDeliveryEfficiency_AccountKey FOREIGN KEY
   (
   AccountKey
   ) REFERENCES fudge.DimCustomerAccount
   ( AccountKey )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;
 
ALTER TABLE fudge.FactDeliveryEfficiency ADD CONSTRAINT
   FK_fudge_FactDeliveryEfficiency_TitleKey FOREIGN KEY
   (
   TitleKey
   ) REFERENCES fudge.DimTitle
   ( TitleKey )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;
 
ALTER TABLE fudge.FactDeliveryEfficiency ADD CONSTRAINT
   FK_fudge_FactDeliveryEfficiency_QueueDateKey FOREIGN KEY
   (
   QueueDateKey
   ) REFERENCES fudge.DimDate
   ( DateKey )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;
 
ALTER TABLE fudge.FactDeliveryEfficiency ADD CONSTRAINT
   FK_fudge_FactDeliveryEfficiency_ShippedDateKey FOREIGN KEY
   (
   ShippedDateKey
   ) REFERENCES fudge.DimDate
   ( DateKey )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;
 
ALTER TABLE fudge.FactCustomerReview ADD CONSTRAINT
   FK_fudge_FactCustomerReview_CustomerAccountNumber FOREIGN KEY
   (
   CustomerAccountNumber
   ) REFERENCES fudge.DimCustomerAccount
   ( CustomerAccountKey )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;
 
ALTER TABLE fudge.FactCustomerReview ADD CONSTRAINT
   FK_fudge_FactCustomerReview_DimPlanKey FOREIGN KEY
   (
   DimPlanKey
   ) REFERENCES fudge.DimPlan
   ( PlanKey )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;
 
ALTER TABLE fudge.FactCustomerReview ADD CONSTRAINT
   FK_fudge_FactCustomerReview_DimProductKey FOREIGN KEY
   (
   DimProductKey
   ) REFERENCES fudge.DimProduct
   ( ProductKey )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;
 
ALTER TABLE fudge.FactCustomerReview ADD CONSTRAINT
   FK_fudge_FactCustomerReview_CsutomerAccountKey FOREIGN KEY
   (
   CsutomerAccountKey
   ) REFERENCES fudge.DimCustomerAccount
   ( CustomerAccountKey )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;
 
ALTER TABLE fudge.FactCustomerReview ADD CONSTRAINT
   FK_fudge_FactCustomerReview_DimTitleKey FOREIGN KEY
   (
   DimTitleKey
   ) REFERENCES fudge.DimTittle
   ( TitleKey )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;
 