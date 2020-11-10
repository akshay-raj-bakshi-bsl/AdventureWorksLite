CREATE SCHEMA SalesLT
GO

CREATE TYPE AccountNumber FROM NVARCHAR(15) NULL
GO

CREATE TYPE Flag FROM BIT NOT NULL
GO

CREATE TYPE [Name] FROM NVARCHAR(50) NULL
GO

CREATE TYPE NameStyle FROM BIT NOT NULL
GO

CREATE TYPE OrderNumber FROM NVARCHAR(25) NULL
GO

CREATE TYPE Phone FROM NVARCHAR(25) NULL
GO

CREATE XML SCHEMA COLLECTION [SalesLT].[ProductDescriptionSchemaCollection]
AS
N'<xsd:schema xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:t="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelWarrAndMain" targetNamespace="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelWarrAndMain" elementFormDefault="qualified">
    <xsd:element name="Maintenance">
        <xsd:complexType>
            <xsd:complexContent>
                <xsd:restriction base="xsd:anyType">
                    <xsd:sequence>
                        <xsd:element name="NoOfYears" type="xsd:string" />
                        <xsd:element name="Description" type="xsd:string" />
                    </xsd:sequence>
                </xsd:restriction>
            </xsd:complexContent>
        </xsd:complexType>
    </xsd:element>
    <xsd:element name="Warranty">
        <xsd:complexType>
            <xsd:complexContent>
                <xsd:restriction base="xsd:anyType">
                    <xsd:sequence>
                        <xsd:element name="WarrantyPeriod" type="xsd:string" />
                        <xsd:element name="Description" type="xsd:string" />
                    </xsd:sequence>
                </xsd:restriction>
            </xsd:complexContent>
        </xsd:complexType>
    </xsd:element>
</xsd:schema>
<xsd:schema xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:ns1="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelWarrAndMain" xmlns:t="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelDescription" targetNamespace="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelDescription" elementFormDefault="qualified">
    <xsd:import namespace="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelWarrAndMain" />
    <xsd:element name="Code" type="xsd:string" />
    <xsd:element name="Description" type="xsd:string" />
    <xsd:element name="ProductDescription" type="t:ProductDescription" />
    <xsd:element name="Taxonomy" type="xsd:string" />
    <xsd:complexType name="Category">
        <xsd:complexContent>
            <xsd:restriction base="xsd:anyType">
                <xsd:sequence>
                    <xsd:element ref="t:Taxonomy" />
                    <xsd:element ref="t:Code" />
                    <xsd:element ref="t:Description" minOccurs="0" />
                </xsd:sequence>
            </xsd:restriction>
        </xsd:complexContent>
    </xsd:complexType>
    <xsd:complexType name="Features" mixed="true">
        <xsd:complexContent mixed="true">
            <xsd:restriction base="xsd:anyType">
                <xsd:sequence>
                    <xsd:element ref="ns1:Warranty" />
                    <xsd:element ref="ns1:Maintenance" />
                    <xsd:any namespace="##other" processContents="skip" minOccurs="0" maxOccurs="unbounded" />
                </xsd:sequence>
            </xsd:restriction>
        </xsd:complexContent>
    </xsd:complexType>
    <xsd:complexType name="Manufacturer">
        <xsd:complexContent>
            <xsd:restriction base="xsd:anyType">
                <xsd:sequence>
                    <xsd:element name="Name" type="xsd:string" minOccurs="0" />
                    <xsd:element name="CopyrightURL" type="xsd:string" minOccurs="0" />
                    <xsd:element name="Copyright" type="xsd:string" minOccurs="0" />
                    <xsd:element name="ProductURL" type="xsd:string" minOccurs="0" />
                </xsd:sequence>
            </xsd:restriction>
        </xsd:complexContent>
    </xsd:complexType>
    <xsd:complexType name="Picture">
        <xsd:complexContent>
            <xsd:restriction base="xsd:anyType">
                <xsd:sequence>
                    <xsd:element name="Name" type="xsd:string" minOccurs="0" />
                    <xsd:element name="Angle" type="xsd:string" minOccurs="0" />
                    <xsd:element name="Size" type="xsd:string" minOccurs="0" />
                    <xsd:element name="ProductPhotoID" type="xsd:integer" minOccurs="0" />
                </xsd:sequence>
            </xsd:restriction>
        </xsd:complexContent>
    </xsd:complexType>
    <xsd:complexType name="ProductDescription">
        <xsd:complexContent>
            <xsd:restriction base="xsd:anyType">
                <xsd:sequence>
                    <xsd:element name="Summary" type="t:Summary" minOccurs="0" />
                    <xsd:element name="Manufacturer" type="t:Manufacturer" minOccurs="0" />
                    <xsd:element name="Features" type="t:Features" minOccurs="0" maxOccurs="unbounded" />
                    <xsd:element name="Picture" type="t:Picture" minOccurs="0" maxOccurs="unbounded" />
                    <xsd:element name="Category" type="t:Category" minOccurs="0" maxOccurs="unbounded" />
                    <xsd:element name="Specifications" type="t:Specifications" minOccurs="0" maxOccurs="unbounded" />
                </xsd:sequence>
                <xsd:attribute name="ProductModelID" type="xsd:string" />
                <xsd:attribute name="ProductModelName" type="xsd:string" />
            </xsd:restriction>
        </xsd:complexContent>
    </xsd:complexType>
    <xsd:complexType name="Specifications" mixed="true">
        <xsd:complexContent mixed="true">
            <xsd:restriction base="xsd:anyType">
                <xsd:sequence>
                    <xsd:any processContents="skip" minOccurs="0" maxOccurs="unbounded" />
                </xsd:sequence>
            </xsd:restriction>
        </xsd:complexContent>
    </xsd:complexType>
    <xsd:complexType name="Summary" mixed="true">
        <xsd:complexContent mixed="true">
            <xsd:restriction base="xsd:anyType">
                <xsd:sequence>
                    <xsd:any namespace="http://www.w3.org/1999/xhtml" processContents="skip" minOccurs="0" maxOccurs="unbounded" />
                </xsd:sequence>
            </xsd:restriction>
        </xsd:complexContent>
    </xsd:complexType>
</xsd:schema>'
GO

CREATE TABLE [SalesLT].[Address]
(
	[AddressID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[AddressLine1] [nvarchar](60) NOT NULL,
	[AddressLine2] [nvarchar](60) NULL,
	[City] [nvarchar](30) NOT NULL,
	[StateProvince] [dbo].[Name] NOT NULL,
	[CountryRegion] [dbo].[Name] NOT NULL,
	[PostalCode] [nvarchar](15) NOT NULL,
	[rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[ModifiedDate] [datetime] NOT NULL,

	CONSTRAINT [PK_Address_AddressID] PRIMARY KEY CLUSTERED ([AddressID]),
	CONSTRAINT [AK_Address_rowguid] UNIQUE NONCLUSTERED ([rowguid])
)
GO

CREATE TABLE [SalesLT].[Customer]
(
	[CustomerID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[NameStyle] [dbo].[NameStyle] NOT NULL,
	[Title] [nvarchar](8) NULL,
	[FirstName] [dbo].[Name] NOT NULL,
	[MiddleName] [dbo].[Name] NULL,
	[LastName] [dbo].[Name] NOT NULL,
	[Suffix] [nvarchar](10) NULL,
	[CompanyName] [nvarchar](128) NULL,
	[SalesPerson] [nvarchar](256) NULL,
	[EmailAddress] [nvarchar](50) NULL,
	[Phone] [dbo].[Phone] NULL,
	[PasswordHash] [varchar](128) NOT NULL,
	[PasswordSalt] [varchar](10) NOT NULL,
	[rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[ModifiedDate] [datetime] NOT NULL,

	CONSTRAINT [PK_Customer_CustomerID] PRIMARY KEY CLUSTERED ([CustomerID]),
	CONSTRAINT [AK_Customer_rowguid] UNIQUE NONCLUSTERED ([rowguid])
) ON [PRIMARY]
GO

CREATE TABLE [SalesLT].[CustomerAddress]
(
	[CustomerID] [int] NOT NULL,
	[AddressID] [int] NOT NULL,
	[AddressType] [dbo].[Name] NOT NULL,
	[rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[ModifiedDate] [datetime] NOT NULL,

	CONSTRAINT [PK_CustomerAddress_CustomerID_AddressID] PRIMARY KEY CLUSTERED ([CustomerID], [AddressID]),
	CONSTRAINT [AK_CustomerAddress_rowguid] UNIQUE NONCLUSTERED ([rowguid])
)
GO

CREATE TABLE [SalesLT].[Product]
(
	[ProductID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [dbo].[Name] NOT NULL,
	[ProductNumber] [nvarchar](25) NOT NULL,
	[Color] [nvarchar](15) NULL,
	[StandardCost] [money] NOT NULL,
	[ListPrice] [money] NOT NULL,
	[Size] [nvarchar](5) NULL,
	[Weight] [decimal](8, 2) NULL,
	[ProductCategoryID] [int] NULL,
	[ProductModelID] [int] NULL,
	[SellStartDate] [datetime] NOT NULL,
	[SellEndDate] [datetime] NULL,
	[DiscontinuedDate] [datetime] NULL,
	[ThumbNailPhoto] [varbinary](max) NULL,
	[ThumbnailPhotoFileName] [nvarchar](50) NULL,
	[rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[ModifiedDate] [datetime] NOT NULL,

	CONSTRAINT [PK_Product_ProductID] PRIMARY KEY CLUSTERED ([ProductID]),
	CONSTRAINT [AK_Product_Name] UNIQUE NONCLUSTERED ([Name]),
	CONSTRAINT [AK_Product_ProductNumber] UNIQUE NONCLUSTERED ([ProductNumber]),
	CONSTRAINT [AK_Product_rowguid] UNIQUE NONCLUSTERED ([rowguid])
)
GO

CREATE TABLE [SalesLT].[ProductCategory]
(
	[ProductCategoryID] [int] IDENTITY(1,1) NOT NULL,
	[ParentProductCategoryID] [int] NULL,
	[Name] [dbo].[Name] NOT NULL,
	[rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[ModifiedDate] [datetime] NOT NULL,

	CONSTRAINT [PK_ProductCategory_ProductCategoryID] PRIMARY KEY CLUSTERED ([ProductCategoryID]),
	CONSTRAINT [AK_ProductCategory_Name] UNIQUE NONCLUSTERED ([Name]),
	CONSTRAINT [AK_ProductCategory_rowguid] UNIQUE NONCLUSTERED ([rowguid])
)
GO

CREATE TABLE [SalesLT].[ProductDescription]
(
	[ProductDescriptionID] [int] IDENTITY(1,1) NOT NULL,
	[Description] [nvarchar](400) NOT NULL,
	[rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[ModifiedDate] [datetime] NOT NULL,

	CONSTRAINT [PK_ProductDescription_ProductDescriptionID] PRIMARY KEY CLUSTERED ([ProductDescriptionID]),
	CONSTRAINT [AK_ProductDescription_rowguid] UNIQUE NONCLUSTERED ([rowguid])
)
GO

CREATE TABLE [SalesLT].[ProductModel]
(
	[ProductModelID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [dbo].[Name] NOT NULL,
	[CatalogDescription] [xml](CONTENT [SalesLT].[ProductDescriptionSchemaCollection]) NULL,
	[rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[ModifiedDate] [datetime] NOT NULL,

	CONSTRAINT [PK_ProductModel_ProductModelID] PRIMARY KEY CLUSTERED ([ProductModelID]),
	CONSTRAINT [AK_ProductModel_Name] UNIQUE NONCLUSTERED ([Name]),
	CONSTRAINT [AK_ProductModel_rowguid] UNIQUE NONCLUSTERED ([rowguid])
)
GO

CREATE TABLE [SalesLT].[ProductModelProductDescription]
(
	[ProductModelID] [int] NOT NULL,
	[ProductDescriptionID] [int] NOT NULL,
	[Culture] [nchar](6) NOT NULL,
	[rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[ModifiedDate] [datetime] NOT NULL,

	CONSTRAINT [PK_ProductModelProductDescription_ProductModelID_ProductDescriptionID_Culture] PRIMARY KEY CLUSTERED ([ProductModelID], [ProductDescriptionID], [Culture]),
	CONSTRAINT [AK_ProductModelProductDescription_rowguid] UNIQUE NONCLUSTERED ([rowguid])
)
GO

CREATE TABLE [SalesLT].[SalesOrderDetail]
(
	[SalesOrderID] [int] NOT NULL,
	[SalesOrderDetailID] [int] IDENTITY(1,1) NOT NULL,
	[OrderQty] [SMALLINT] NOT NULL,
	[ProductID] [int] NOT NULL,
	[UnitPrice] [money] NOT NULL,
	[UnitPriceDiscount] [money] NOT NULL,
	[LineTotal]  AS (isnull(([UnitPrice]*((1.0)-[UnitPriceDiscount]))*[OrderQty],(0.0))),
	[rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[ModifiedDate] [datetime] NOT NULL,

	CONSTRAINT [PK_SalesOrderDetail_SalesOrderID_SalesOrderDetailID] PRIMARY KEY CLUSTERED ([SalesOrderID], [SalesOrderDetailID]),
	CONSTRAINT [AK_SalesOrderDetail_rowguid] UNIQUE NONCLUSTERED ([rowguid])
)
GO

CREATE TABLE [SalesLT].[SalesOrderHeader]
(
	[SalesOrderID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[RevisionNumber] [tinyint] NOT NULL,
	[OrderDate] [DATETIME] NOT NULL,
	[DueDate] [datetime] NOT NULL,
	[ShipDate] [datetime] NULL,
	[Status] [tinyint] NOT NULL,
	[OnlineOrderFlag] [dbo].[Flag] NOT NULL,
	[SalesOrderNumber]  AS (ISNULL(N'SO'+CONVERT(NVARCHAR(23),[SalesOrderID],0),N'*** ERROR ***')),
	[PurchaseOrderNumber] [dbo].[OrderNumber] NULL,
	[AccountNumber] [dbo].[AccountNumber] NULL,
	[CustomerID] [int] NOT NULL,
	[ShipToAddressID] [int] NULL,
	[BillToAddressID] [int] NULL,
	[ShipMethod] [nvarchar](50) NOT NULL,
	[CreditCardApprovalCode] [varchar](15) NULL,
	[SubTotal] [money] NOT NULL,
	[TaxAmt] [money] NOT NULL,
	[Freight] [money] NOT NULL,
	[TotalDue]  AS (isnull(([SubTotal]+[TaxAmt])+[Freight],(0))),
	[Comment] [nvarchar](max) NULL,
	[rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[ModifiedDate] [datetime] NOT NULL,

	CONSTRAINT [PK_SalesOrderHeader_SalesOrderID] PRIMARY KEY CLUSTERED ([SalesOrderID]),
	CONSTRAINT [AK_SalesOrderHeader_rowguid] UNIQUE NONCLUSTERED ([rowguid]),
	CONSTRAINT [AK_SalesOrderHeader_SalesOrderNumber] UNIQUE NONCLUSTERED ([SalesOrderNumber])
)
GO

CREATE VIEW [SalesLT].[vGetAllCategories]
WITH SCHEMABINDING 
AS 
-- Returns the CustomerID, first name, and last name for the specified customer.

WITH CategoryCTE([ParentProductCategoryID], [ProductCategoryID], [Name]) AS 
(
	SELECT [ParentProductCategoryID], [ProductCategoryID], [Name]
	FROM SalesLT.ProductCategory
	WHERE ParentProductCategoryID IS NULL

UNION ALL

	SELECT C.[ParentProductCategoryID], C.[ProductCategoryID], C.[Name]
	FROM SalesLT.ProductCategory AS C
	INNER JOIN CategoryCTE AS BC ON BC.ProductCategoryID = C.ParentProductCategoryID
)

SELECT PC.[Name] AS [ParentProductCategoryName], CCTE.[Name] as [ProductCategoryName], CCTE.[ProductCategoryID]  
FROM CategoryCTE AS CCTE
JOIN SalesLT.ProductCategory AS PC 
ON PC.[ProductCategoryID] = CCTE.[ParentProductCategoryID]
GO

CREATE VIEW [SalesLT].[vProductAndDescription] 
WITH SCHEMABINDING 
AS 
-- View (indexed or standard) to display products and product descriptions by language.
SELECT 
    p.[ProductID] 
    ,p.[Name] 
    ,pm.[Name] AS [ProductModel] 
    ,pmx.[Culture] 
    ,pd.[Description] 
FROM [SalesLT].[Product] p 
    INNER JOIN [SalesLT].[ProductModel] pm 
    ON p.[ProductModelID] = pm.[ProductModelID] 
    INNER JOIN [SalesLT].[ProductModelProductDescription] pmx 
    ON pm.[ProductModelID] = pmx.[ProductModelID] 
    INNER JOIN [SalesLT].[ProductDescription] pd 
    ON pmx.[ProductDescriptionID] = pd.[ProductDescriptionID];
GO

CREATE UNIQUE CLUSTERED INDEX [IX_vProductAndDescription] ON [SalesLT].[vProductAndDescription] ([Culture], [ProductID])
GO

CREATE VIEW [SalesLT].[vProductModelCatalogDescription] 
AS 
SELECT 
    [ProductModelID] 
    ,[Name] 
    ,[CatalogDescription].value(N'declare namespace p1="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelDescription"; 
        declare namespace html="http://www.w3.org/1999/xhtml"; 
        (/p1:ProductDescription/p1:Summary/html:p)[1]', 'nvarchar(max)') AS [Summary] 
    ,[CatalogDescription].value(N'declare namespace p1="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelDescription"; 
        (/p1:ProductDescription/p1:Manufacturer/p1:Name)[1]', 'nvarchar(max)') AS [Manufacturer] 
    ,[CatalogDescription].value(N'declare namespace p1="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelDescription"; 
        (/p1:ProductDescription/p1:Manufacturer/p1:Copyright)[1]', 'nvarchar(30)') AS [Copyright] 
    ,[CatalogDescription].value(N'declare namespace p1="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelDescription"; 
        (/p1:ProductDescription/p1:Manufacturer/p1:ProductURL)[1]', 'nvarchar(256)') AS [ProductURL] 
    ,[CatalogDescription].value(N'declare namespace p1="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelDescription"; 
        declare namespace wm="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelWarrAndMain"; 
        (/p1:ProductDescription/p1:Features/wm:Warranty/wm:WarrantyPeriod)[1]', 'nvarchar(256)') AS [WarrantyPeriod] 
    ,[CatalogDescription].value(N'declare namespace p1="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelDescription"; 
        declare namespace wm="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelWarrAndMain"; 
        (/p1:ProductDescription/p1:Features/wm:Warranty/wm:Description)[1]', 'nvarchar(256)') AS [WarrantyDescription] 
    ,[CatalogDescription].value(N'declare namespace p1="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelDescription"; 
        declare namespace wm="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelWarrAndMain"; 
        (/p1:ProductDescription/p1:Features/wm:Maintenance/wm:NoOfYears)[1]', 'nvarchar(256)') AS [NoOfYears] 
    ,[CatalogDescription].value(N'declare namespace p1="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelDescription"; 
        declare namespace wm="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelWarrAndMain"; 
        (/p1:ProductDescription/p1:Features/wm:Maintenance/wm:Description)[1]', 'nvarchar(256)') AS [MaintenanceDescription] 
    ,[CatalogDescription].value(N'declare namespace p1="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelDescription"; 
        declare namespace wf="http://www.adventure-works.com/schemas/OtherFeatures"; 
        (/p1:ProductDescription/p1:Features/wf:wheel)[1]', 'nvarchar(256)') AS [Wheel] 
    ,[CatalogDescription].value(N'declare namespace p1="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelDescription"; 
        declare namespace wf="http://www.adventure-works.com/schemas/OtherFeatures"; 
        (/p1:ProductDescription/p1:Features/wf:saddle)[1]', 'nvarchar(256)') AS [Saddle] 
    ,[CatalogDescription].value(N'declare namespace p1="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelDescription"; 
        declare namespace wf="http://www.adventure-works.com/schemas/OtherFeatures"; 
        (/p1:ProductDescription/p1:Features/wf:pedal)[1]', 'nvarchar(256)') AS [Pedal] 
    ,[CatalogDescription].value(N'declare namespace p1="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelDescription"; 
        declare namespace wf="http://www.adventure-works.com/schemas/OtherFeatures"; 
        (/p1:ProductDescription/p1:Features/wf:BikeFrame)[1]', 'nvarchar(max)') AS [BikeFrame] 
    ,[CatalogDescription].value(N'declare namespace p1="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelDescription"; 
        declare namespace wf="http://www.adventure-works.com/schemas/OtherFeatures"; 
        (/p1:ProductDescription/p1:Features/wf:crankset)[1]', 'nvarchar(256)') AS [Crankset] 
    ,[CatalogDescription].value(N'declare namespace p1="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelDescription"; 
        (/p1:ProductDescription/p1:Picture/p1:Angle)[1]', 'nvarchar(256)') AS [PictureAngle] 
    ,[CatalogDescription].value(N'declare namespace p1="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelDescription"; 
        (/p1:ProductDescription/p1:Picture/p1:Size)[1]', 'nvarchar(256)') AS [PictureSize] 
    ,[CatalogDescription].value(N'declare namespace p1="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelDescription"; 
        (/p1:ProductDescription/p1:Picture/p1:ProductPhotoID)[1]', 'nvarchar(256)') AS [ProductPhotoID] 
    ,[CatalogDescription].value(N'declare namespace p1="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelDescription"; 
        (/p1:ProductDescription/p1:Specifications/Material)[1]', 'nvarchar(256)') AS [Material] 
    ,[CatalogDescription].value(N'declare namespace p1="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelDescription"; 
        (/p1:ProductDescription/p1:Specifications/Color)[1]', 'nvarchar(256)') AS [Color] 
    ,[CatalogDescription].value(N'declare namespace p1="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelDescription"; 
        (/p1:ProductDescription/p1:Specifications/ProductLine)[1]', 'nvarchar(256)') AS [ProductLine] 
    ,[CatalogDescription].value(N'declare namespace p1="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelDescription"; 
        (/p1:ProductDescription/p1:Specifications/Style)[1]', 'nvarchar(256)') AS [Style] 
    ,[CatalogDescription].value(N'declare namespace p1="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelDescription"; 
        (/p1:ProductDescription/p1:Specifications/RiderExperience)[1]', 'nvarchar(1024)') AS [RiderExperience] 
    ,[rowguid] 
    ,[ModifiedDate]
FROM [SalesLT].[ProductModel] 
WHERE [CatalogDescription] IS NOT NULL;
GO

CREATE FUNCTION [dbo].[ufnGetSalesOrderStatusText](@Status [tinyint])
RETURNS [nvarchar](15) 
AS 
-- Returns the sales order status text representation for the status value.
BEGIN
    DECLARE @ret [nvarchar](15);

    SET @ret = 
        CASE @Status
            WHEN 1 THEN 'In process'
            WHEN 2 THEN 'Approved'
            WHEN 3 THEN 'Backordered'
            WHEN 4 THEN 'Rejected'
            WHEN 5 THEN 'Shipped'
            WHEN 6 THEN 'Cancelled'
            ELSE '** Invalid **'
        END;
    
    RETURN @ret
END;
GO

CREATE FUNCTION [dbo].[ufnGetCustomerInformation](@CustomerID int)
RETURNS TABLE 
AS 
-- Returns the CustomerID, first name, and last name for the specified customer.
RETURN (
    SELECT 
        CustomerID, 
        FirstName, 
        LastName
    FROM [SalesLT].[Customer] 
    WHERE [CustomerID] = @CustomerID
);
GO

CREATE FUNCTION [dbo].[ufnGetAllCategories]()
RETURNS @retCategoryInformation TABLE 
(
    -- Columns returned by the function
    [ParentProductCategoryName] [nvarchar](50) NULL, 
    [ProductCategoryName] [nvarchar](50) NOT NULL,
	[ProductCategoryID] [int] NOT NULL
)
AS 
-- Returns the CustomerID, first name, and last name for the specified customer.
BEGIN
	WITH CategoryCTE([ParentProductCategoryID], [ProductCategoryID], [Name]) AS 
	(
		SELECT [ParentProductCategoryID], [ProductCategoryID], [Name]
		FROM SalesLT.ProductCategory
		WHERE ParentProductCategoryID IS NULL

	UNION ALL

		SELECT C.[ParentProductCategoryID], C.[ProductCategoryID], C.[Name]
		FROM SalesLT.ProductCategory AS C
		INNER JOIN CategoryCTE AS BC ON BC.ProductCategoryID = C.ParentProductCategoryID
	)

	INSERT INTO @retCategoryInformation
	SELECT PC.[Name] AS [ParentProductCategoryName], CCTE.[Name] as [ProductCategoryName], CCTE.[ProductCategoryID]  
	FROM CategoryCTE AS CCTE
	JOIN SalesLT.ProductCategory AS PC 
	ON PC.[ProductCategoryID] = CCTE.[ParentProductCategoryID];
	RETURN;
END;
GO

CREATE NONCLUSTERED INDEX [IX_Address_AddressLine1_AddressLine2_City_StateProvince_PostalCode_CountryRegion] ON [SalesLT].[Address] ([AddressLine1], [AddressLine2], [City], [StateProvince], [PostalCode], [CountryRegion])
GO

CREATE NONCLUSTERED INDEX [IX_Address_StateProvince] ON [SalesLT].[Address] ([StateProvince])
GO

CREATE NONCLUSTERED INDEX [IX_Customer_EmailAddress] ON [SalesLT].[Customer] ([EmailAddress])
GO

CREATE NONCLUSTERED INDEX [IX_SalesOrderDetail_ProductID] ON [SalesLT].[SalesOrderDetail] ([ProductID])
GO

CREATE NONCLUSTERED INDEX [IX_SalesOrderHeader_CustomerID] ON [SalesLT].[SalesOrderHeader] ([CustomerID])
GO

CREATE PRIMARY XML INDEX [PXML_ProductModel_CatalogDescription] ON [SalesLT].[ProductModel] ([CatalogDescription])
GO

ALTER TABLE [SalesLT].[Address] ADD  CONSTRAINT [DF_Address_rowguid]  DEFAULT (newid()) FOR [rowguid]
GO

ALTER TABLE [SalesLT].[Address] ADD  CONSTRAINT [DF_Address_ModifiedDate]  DEFAULT (getdate()) FOR [ModifiedDate]
GO

ALTER TABLE [SalesLT].[Customer] ADD  CONSTRAINT [DF_Customer_NameStyle]  DEFAULT ((0)) FOR [NameStyle]
GO

ALTER TABLE [SalesLT].[Customer] ADD  CONSTRAINT [DF_Customer_rowguid]  DEFAULT (newid()) FOR [rowguid]
GO

ALTER TABLE [SalesLT].[Customer] ADD  CONSTRAINT [DF_Customer_ModifiedDate]  DEFAULT (getdate()) FOR [ModifiedDate]
GO

ALTER TABLE [SalesLT].[CustomerAddress] ADD  CONSTRAINT [DF_CustomerAddress_rowguid]  DEFAULT (newid()) FOR [rowguid]
GO

ALTER TABLE [SalesLT].[CustomerAddress] ADD  CONSTRAINT [DF_CustomerAddress_ModifiedDate]  DEFAULT (getdate()) FOR [ModifiedDate]
GO

ALTER TABLE [SalesLT].[Product] ADD  CONSTRAINT [DF_Product_rowguid]  DEFAULT (newid()) FOR [rowguid]
GO

ALTER TABLE [SalesLT].[Product] ADD  CONSTRAINT [DF_Product_ModifiedDate]  DEFAULT (getdate()) FOR [ModifiedDate]
GO

ALTER TABLE [SalesLT].[ProductCategory] ADD  CONSTRAINT [DF_ProductCategory_rowguid]  DEFAULT (newid()) FOR [rowguid]
GO

ALTER TABLE [SalesLT].[ProductCategory] ADD  CONSTRAINT [DF_ProductCategory_ModifiedDate]  DEFAULT (getdate()) FOR [ModifiedDate]
GO

ALTER TABLE [SalesLT].[ProductDescription] ADD  CONSTRAINT [DF_ProductDescription_rowguid]  DEFAULT (newid()) FOR [rowguid]
GO

ALTER TABLE [SalesLT].[ProductDescription] ADD  CONSTRAINT [DF_ProductDescription_ModifiedDate]  DEFAULT (getdate()) FOR [ModifiedDate]
GO

ALTER TABLE [SalesLT].[ProductModel] ADD  CONSTRAINT [DF_ProductModel_rowguid]  DEFAULT (newid()) FOR [rowguid]
GO

ALTER TABLE [SalesLT].[ProductModel] ADD  CONSTRAINT [DF_ProductModel_ModifiedDate]  DEFAULT (getdate()) FOR [ModifiedDate]
GO

ALTER TABLE [SalesLT].[ProductModelProductDescription] ADD  CONSTRAINT [DF_ProductModelProductDescription_rowguid]  DEFAULT (newid()) FOR [rowguid]
GO

ALTER TABLE [SalesLT].[ProductModelProductDescription] ADD  CONSTRAINT [DF_ProductModelProductDescription_ModifiedDate]  DEFAULT (getdate()) FOR [ModifiedDate]
GO

ALTER TABLE [SalesLT].[SalesOrderDetail] ADD  CONSTRAINT [DF_SalesOrderDetail_UnitPriceDiscount]  DEFAULT ((0.0)) FOR [UnitPriceDiscount]
GO

ALTER TABLE [SalesLT].[SalesOrderDetail] ADD  CONSTRAINT [DF_SalesOrderDetail_rowguid]  DEFAULT (newid()) FOR [rowguid]
GO

ALTER TABLE [SalesLT].[SalesOrderDetail] ADD  CONSTRAINT [DF_SalesOrderDetail_ModifiedDate]  DEFAULT (getdate()) FOR [ModifiedDate]
GO

ALTER TABLE [SalesLT].[SalesOrderHeader] ADD  CONSTRAINT [DF_SalesOrderHeader_RevisionNumber]  DEFAULT ((0)) FOR [RevisionNumber]
GO

ALTER TABLE [SalesLT].[SalesOrderHeader] ADD  CONSTRAINT [DF_SalesOrderHeader_OrderDate]  DEFAULT (getdate()) FOR [OrderDate]
GO

ALTER TABLE [SalesLT].[SalesOrderHeader] ADD  CONSTRAINT [DF_SalesOrderHeader_Status]  DEFAULT ((1)) FOR [Status]
GO

ALTER TABLE [SalesLT].[SalesOrderHeader] ADD  CONSTRAINT [DF_SalesOrderHeader_OnlineOrderFlag]  DEFAULT ((1)) FOR [OnlineOrderFlag]
GO

ALTER TABLE [SalesLT].[SalesOrderHeader] ADD  CONSTRAINT [DF_SalesOrderHeader_SubTotal]  DEFAULT ((0.00)) FOR [SubTotal]
GO

ALTER TABLE [SalesLT].[SalesOrderHeader] ADD  CONSTRAINT [DF_SalesOrderHeader_TaxAmt]  DEFAULT ((0.00)) FOR [TaxAmt]
GO

ALTER TABLE [SalesLT].[SalesOrderHeader] ADD  CONSTRAINT [DF_SalesOrderHeader_Freight]  DEFAULT ((0.00)) FOR [Freight]
GO

ALTER TABLE [SalesLT].[SalesOrderHeader] ADD  CONSTRAINT [DF_SalesOrderHeader_rowguid]  DEFAULT (newid()) FOR [rowguid]
GO

ALTER TABLE [SalesLT].[SalesOrderHeader] ADD  CONSTRAINT [DF_SalesOrderHeader_ModifiedDate]  DEFAULT (getdate()) FOR [ModifiedDate]
GO

ALTER TABLE [SalesLT].[CustomerAddress]  WITH CHECK ADD  CONSTRAINT [FK_CustomerAddress_Address_AddressID] FOREIGN KEY([AddressID])
REFERENCES [SalesLT].[Address] ([AddressID])
GO

ALTER TABLE [SalesLT].[CustomerAddress] CHECK CONSTRAINT [FK_CustomerAddress_Address_AddressID]
GO

ALTER TABLE [SalesLT].[CustomerAddress]  WITH CHECK ADD  CONSTRAINT [FK_CustomerAddress_Customer_CustomerID] FOREIGN KEY([CustomerID])
REFERENCES [SalesLT].[Customer] ([CustomerID])
GO

ALTER TABLE [SalesLT].[CustomerAddress] CHECK CONSTRAINT [FK_CustomerAddress_Customer_CustomerID]
GO

ALTER TABLE [SalesLT].[Product]  WITH CHECK ADD  CONSTRAINT [FK_Product_ProductCategory_ProductCategoryID] FOREIGN KEY([ProductCategoryID])
REFERENCES [SalesLT].[ProductCategory] ([ProductCategoryID])
GO

ALTER TABLE [SalesLT].[Product] CHECK CONSTRAINT [FK_Product_ProductCategory_ProductCategoryID]
GO

ALTER TABLE [SalesLT].[Product]  WITH CHECK ADD  CONSTRAINT [FK_Product_ProductModel_ProductModelID] FOREIGN KEY([ProductModelID])
REFERENCES [SalesLT].[ProductModel] ([ProductModelID])
GO

ALTER TABLE [SalesLT].[Product] CHECK CONSTRAINT [FK_Product_ProductModel_ProductModelID]
GO

ALTER TABLE [SalesLT].[ProductCategory]  WITH CHECK ADD  CONSTRAINT [FK_ProductCategory_ProductCategory_ParentProductCategoryID_ProductCategoryID] FOREIGN KEY([ParentProductCategoryID])
REFERENCES [SalesLT].[ProductCategory] ([ProductCategoryID])
GO

ALTER TABLE [SalesLT].[ProductCategory] CHECK CONSTRAINT [FK_ProductCategory_ProductCategory_ParentProductCategoryID_ProductCategoryID]
GO

ALTER TABLE [SalesLT].[ProductModelProductDescription]  WITH CHECK ADD  CONSTRAINT [FK_ProductModelProductDescription_ProductDescription_ProductDescriptionID] FOREIGN KEY([ProductDescriptionID])
REFERENCES [SalesLT].[ProductDescription] ([ProductDescriptionID])
GO

ALTER TABLE [SalesLT].[ProductModelProductDescription] CHECK CONSTRAINT [FK_ProductModelProductDescription_ProductDescription_ProductDescriptionID]
GO

ALTER TABLE [SalesLT].[ProductModelProductDescription]  WITH CHECK ADD  CONSTRAINT [FK_ProductModelProductDescription_ProductModel_ProductModelID] FOREIGN KEY([ProductModelID])
REFERENCES [SalesLT].[ProductModel] ([ProductModelID])
GO

ALTER TABLE [SalesLT].[ProductModelProductDescription] CHECK CONSTRAINT [FK_ProductModelProductDescription_ProductModel_ProductModelID]
GO

ALTER TABLE [SalesLT].[SalesOrderDetail]  WITH CHECK ADD  CONSTRAINT [FK_SalesOrderDetail_Product_ProductID] FOREIGN KEY([ProductID])
REFERENCES [SalesLT].[Product] ([ProductID])
GO

ALTER TABLE [SalesLT].[SalesOrderDetail] CHECK CONSTRAINT [FK_SalesOrderDetail_Product_ProductID]
GO

ALTER TABLE [SalesLT].[SalesOrderDetail]  WITH CHECK ADD  CONSTRAINT [FK_SalesOrderDetail_SalesOrderHeader_SalesOrderID] FOREIGN KEY([SalesOrderID])
REFERENCES [SalesLT].[SalesOrderHeader] ([SalesOrderID])
ON DELETE CASCADE

GO
ALTER TABLE [SalesLT].[SalesOrderDetail] CHECK CONSTRAINT [FK_SalesOrderDetail_SalesOrderHeader_SalesOrderID]
GO

ALTER TABLE [SalesLT].[SalesOrderHeader]  WITH CHECK ADD  CONSTRAINT [FK_SalesOrderHeader_Address_BillTo_AddressID] FOREIGN KEY([BillToAddressID])
REFERENCES [SalesLT].[Address] ([AddressID])
GO

ALTER TABLE [SalesLT].[SalesOrderHeader] CHECK CONSTRAINT [FK_SalesOrderHeader_Address_BillTo_AddressID]
GO

ALTER TABLE [SalesLT].[SalesOrderHeader]  WITH CHECK ADD  CONSTRAINT [FK_SalesOrderHeader_Address_ShipTo_AddressID] FOREIGN KEY([ShipToAddressID])
REFERENCES [SalesLT].[Address] ([AddressID])
GO

ALTER TABLE [SalesLT].[SalesOrderHeader] CHECK CONSTRAINT [FK_SalesOrderHeader_Address_ShipTo_AddressID]
GO

ALTER TABLE [SalesLT].[SalesOrderHeader]  WITH CHECK ADD  CONSTRAINT [FK_SalesOrderHeader_Customer_CustomerID] FOREIGN KEY([CustomerID])
REFERENCES [SalesLT].[Customer] ([CustomerID])
GO

ALTER TABLE [SalesLT].[SalesOrderHeader] CHECK CONSTRAINT [FK_SalesOrderHeader_Customer_CustomerID]
GO

ALTER TABLE [SalesLT].[Product]  WITH CHECK ADD  CONSTRAINT [CK_Product_ListPrice] CHECK  (([ListPrice]>=(0.00)))
GO

ALTER TABLE [SalesLT].[Product] CHECK CONSTRAINT [CK_Product_ListPrice]
GO

ALTER TABLE [SalesLT].[Product]  WITH CHECK ADD  CONSTRAINT [CK_Product_SellEndDate] CHECK  (([SellEndDate]>=[SellStartDate] OR [SellEndDate] IS NULL))
GO

ALTER TABLE [SalesLT].[Product] CHECK CONSTRAINT [CK_Product_SellEndDate]
GO

ALTER TABLE [SalesLT].[Product]  WITH CHECK ADD  CONSTRAINT [CK_Product_StandardCost] CHECK  (([StandardCost]>=(0.00)))
GO

ALTER TABLE [SalesLT].[Product] CHECK CONSTRAINT [CK_Product_StandardCost]
GO

ALTER TABLE [SalesLT].[Product]  WITH CHECK ADD  CONSTRAINT [CK_Product_Weight] CHECK  (([Weight]>(0.00)))
GO

ALTER TABLE [SalesLT].[Product] CHECK CONSTRAINT [CK_Product_Weight]
GO

ALTER TABLE [SalesLT].[SalesOrderDetail]  WITH CHECK ADD  CONSTRAINT [CK_SalesOrderDetail_OrderQty] CHECK  (([OrderQty]>(0)))
GO

ALTER TABLE [SalesLT].[SalesOrderDetail] CHECK CONSTRAINT [CK_SalesOrderDetail_OrderQty]
GO

ALTER TABLE [SalesLT].[SalesOrderDetail]  WITH CHECK ADD  CONSTRAINT [CK_SalesOrderDetail_UnitPrice] CHECK  (([UnitPrice]>=(0.00)))
GO

ALTER TABLE [SalesLT].[SalesOrderDetail] CHECK CONSTRAINT [CK_SalesOrderDetail_UnitPrice]
GO

ALTER TABLE [SalesLT].[SalesOrderDetail]  WITH CHECK ADD  CONSTRAINT [CK_SalesOrderDetail_UnitPriceDiscount] CHECK  (([UnitPriceDiscount]>=(0.00)))
GO

ALTER TABLE [SalesLT].[SalesOrderDetail] CHECK CONSTRAINT [CK_SalesOrderDetail_UnitPriceDiscount]
GO

ALTER TABLE [SalesLT].[SalesOrderHeader]  WITH CHECK ADD  CONSTRAINT [CK_SalesOrderHeader_DueDate] CHECK  (([DueDate]>=[OrderDate]))
GO

ALTER TABLE [SalesLT].[SalesOrderHeader] CHECK CONSTRAINT [CK_SalesOrderHeader_DueDate]
GO

ALTER TABLE [SalesLT].[SalesOrderHeader]  WITH CHECK ADD  CONSTRAINT [CK_SalesOrderHeader_Freight] CHECK  (([Freight]>=(0.00)))
GO

ALTER TABLE [SalesLT].[SalesOrderHeader] CHECK CONSTRAINT [CK_SalesOrderHeader_Freight]
GO

ALTER TABLE [SalesLT].[SalesOrderHeader]  WITH CHECK ADD  CONSTRAINT [CK_SalesOrderHeader_ShipDate] CHECK  (([ShipDate]>=[OrderDate] OR [ShipDate] IS NULL))
GO

ALTER TABLE [SalesLT].[SalesOrderHeader] CHECK CONSTRAINT [CK_SalesOrderHeader_ShipDate]
GO

ALTER TABLE [SalesLT].[SalesOrderHeader]  WITH CHECK ADD  CONSTRAINT [CK_SalesOrderHeader_Status] CHECK  (([Status]>=(0) AND [Status]<=(8)))
GO

ALTER TABLE [SalesLT].[SalesOrderHeader] CHECK CONSTRAINT [CK_SalesOrderHeader_Status]
GO

ALTER TABLE [SalesLT].[SalesOrderHeader]  WITH CHECK ADD  CONSTRAINT [CK_SalesOrderHeader_SubTotal] CHECK  (([SubTotal]>=(0.00)))
GO

ALTER TABLE [SalesLT].[SalesOrderHeader] CHECK CONSTRAINT [CK_SalesOrderHeader_SubTotal]
GO

ALTER TABLE [SalesLT].[SalesOrderHeader]  WITH CHECK ADD  CONSTRAINT [CK_SalesOrderHeader_TaxAmt] CHECK  (([TaxAmt]>=(0.00)))
GO

ALTER TABLE [SalesLT].[SalesOrderHeader] CHECK CONSTRAINT [CK_SalesOrderHeader_TaxAmt]
GO

BULK INSERT [SalesLT].[Address] FROM 'Address.csv'
WITH
(
	DATAFILETYPE = 'char',
	FIELDTERMINATOR = '|+|',
	KEEPNULLS
);
GO

BULK INSERT [SalesLT].[Customer] FROM 'Customer.csv'
WITH
(
	DATAFILETYPE = 'char',
	FIELDTERMINATOR = '|+|',
	KEEPNULLS
);
GO

BULK INSERT [SalesLT].[CustomerAddress] FROM 'CustomerAddress.csv'
WITH
(
	DATAFILETYPE = 'char',
	FIELDTERMINATOR = '|+|',
	KEEPNULLS
);
GO

BULK INSERT [SalesLT].[Product] FROM 'Product.csv'
WITH
(
	DATAFILETYPE = 'char',
	FIELDTERMINATOR = '|+|',
	ROWTERMINATOR = '0x0a',
	KEEPNULLS
);
GO

BULK INSERT [SalesLT].[ProductCategory] FROM 'ProductCategory.csv'
WITH
(
	DATAFILETYPE = 'char',
	FIELDTERMINATOR = '|+|',
	KEEPNULLS
);
GO

BULK INSERT [SalesLT].[ProductDescription] FROM 'ProductDescription.csv'
WITH
(
	CHECK_CONSTRAINTS,
	CODEPAGE='ACP',
	DATAFILETYPE = 'widechar',
	FIELDTERMINATOR = '|+|',
	KEEPIDENTITY,
	KEEPNULLS,
	TABLOCK
);
GO

BULK INSERT [SalesLT].[ProductModel] FROM 'ProductModel.csv'
WITH
(
	CODEPAGE='ACP',
	DATAFILETYPE = 'char',
	FIELDTERMINATOR = '|+|',
	ROWTERMINATOR = '$$$==$$$',
	KEEPNULLS
);
GO

BULK INSERT [SalesLT].[ProductModelProductDescription] FROM 'ProductModelProductDescription.csv'
WITH
(
	DATAFILETYPE = 'char',
	FIELDTERMINATOR = '|+|',
	KEEPNULLS
);
GO

BULK INSERT [SalesLT].[SalesOrderDetail] FROM 'SalesOrderDetail.csv'
WITH
(
	DATAFILETYPE = 'char',
	FIELDTERMINATOR = '|+|',
	KEEPNULLS
);
GO

BULK INSERT [SalesLT].[SalesOrderHeader] FROM 'SalesOrderHeader.csv'
WITH
(
	DATAFILETYPE = 'char',
	FIELDTERMINATOR = '|+|',
	KEEPNULLS
);
GO
