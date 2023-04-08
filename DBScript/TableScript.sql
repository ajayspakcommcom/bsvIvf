USE [BSV_IVF]
GO
/****** Object:  Table [BSV_IVF].[Persons]    Script Date: 08-04-2023 13:45:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [BSV_IVF].[Persons](
	[ID] [int] NOT NULL,
	[LastName] [varchar](255) NOT NULL,
	[FirstName] [varchar](255) NULL,
	[Age] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [BSV_IVF].[tblBrandcompetitorSKUs]    Script Date: 08-04-2023 13:45:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [BSV_IVF].[tblBrandcompetitorSKUs](
	[competitorId] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](100) NULL,
	[brandId] [int] NULL,
	[isDisabled] [bit] NULL,
	[CreatedDate] [smalldatetime] NULL,
 CONSTRAINT [PK_BrandcompetitorSKUs] PRIMARY KEY CLUSTERED 
(
	[competitorId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [BSV_IVF].[tblChainAccountType]    Script Date: 08-04-2023 13:45:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [BSV_IVF].[tblChainAccountType](
	[accountID] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](100) NULL,
	[contractDoc] [nvarchar](500) NULL,
	[expiryDate] [date] NULL,
	[isApproved] [bit] NULL,
	[approvedOn] [smalldatetime] NULL,
	[rbmId] [int] NULL,
	[customerAccountID] [int] NULL,
	[isDisabled] [int] NULL,
	[CreatedDate] [smalldatetime] NULL,
	[approvedBy] [int] NULL,
	[startDate] [date] NULL,
	[COMMENTS] [nvarchar](1000) NULL,
 CONSTRAINT [PK_tblChainAccountType] PRIMARY KEY CLUSTERED 
(
	[accountID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [BSV_IVF].[tblCompetitions]    Script Date: 08-04-2023 13:45:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [BSV_IVF].[tblCompetitions](
	[CompetitionId] [int] IDENTITY(1,1) NOT NULL,
	[empId] [int] NULL,
	[centerId] [int] NULL,
	[brandId] [int] NULL,
	[CompetitionSkuId] [int] NULL,
	[CreatedDate] [smalldatetime] NULL,
	[isApproved] [tinyint] NULL,
	[approvedBy] [int] NULL,
	[approvedOn] [smalldatetime] NULL,
	[competitionAddedFor] [date] NULL,
	[businessValue] [float] NULL,
	[comments] [ntext] NULL,
	[rejectComments] [ntext] NULL,
	[rejectedBy] [int] NULL,
	[rejectedOn] [smalldatetime] NULL,
	[IsZBMApproved] [tinyint] NULL,
	[ZBMId] [int] NULL,
	[ZBMApprovedOn] [smalldatetime] NULL,
	[status] [tinyint] NULL,
 CONSTRAINT [PK_tblCustomers] PRIMARY KEY CLUSTERED 
(
	[CompetitionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [BSV_IVF].[TblContractDetails]    Script Date: 08-04-2023 13:45:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [BSV_IVF].[TblContractDetails](
	[contractId] [int] IDENTITY(1,1) NOT NULL,
	[chainAccountTypeId] [int] NULL,
	[brandId] [int] NULL,
	[brandGroupId] [int] NULL,
	[medId] [int] NULL,
	[price] [float] NULL,
	[isDisabled] [int] NULL,
	[createdDate] [smalldatetime] NULL,
 CONSTRAINT [PK_TblContractDetails] PRIMARY KEY CLUSTERED 
(
	[contractId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [BSV_IVF].[tblDesignation]    Script Date: 08-04-2023 13:45:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [BSV_IVF].[tblDesignation](
	[DesignationID] [smallint] IDENTITY(1,1) NOT NULL,
	[name] [varchar](255) NULL,
	[Designation] [varchar](255) NULL,
	[isDisabled] [bit] NULL,
	[createdDate] [smalldatetime] NULL,
	[code] [nvarchar](20) NULL,
	[managerCode] [nvarchar](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[DesignationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [BSV_IVF].[tblEmpHospitals]    Script Date: 08-04-2023 13:45:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [BSV_IVF].[tblEmpHospitals](
	[id] [smallint] IDENTITY(1,1) NOT NULL,
	[hospitalId] [varchar](255) NULL,
	[EmpID] [varchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [BSV_IVF].[tblempHospitalsBKUP]    Script Date: 08-04-2023 13:45:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [BSV_IVF].[tblempHospitalsBKUP](
	[id] [smallint] IDENTITY(1,1) NOT NULL,
	[hospitalId] [varchar](255) NULL,
	[EmpID] [varchar](255) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [BSV_IVF].[tblemphospitalsbkup1_apri]    Script Date: 08-04-2023 13:45:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [BSV_IVF].[tblemphospitalsbkup1_apri](
	[id] [smallint] IDENTITY(1,1) NOT NULL,
	[hospitalId] [varchar](255) NULL,
	[EmpID] [varchar](255) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [BSV_IVF].[tblEmployees]    Script Date: 08-04-2023 13:45:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [BSV_IVF].[tblEmployees](
	[EmpID] [smallint] IDENTITY(1,1) NOT NULL,
	[firstName] [varchar](255) NULL,
	[lastName] [varchar](255) NULL,
	[MobileNumber] [varchar](255) NULL,
	[Email] [varchar](255) NULL,
	[Password] [varchar](255) NULL,
	[Designation] [varchar](50) NULL,
	[DesignationID] [smallint] NULL,
	[EmpNumber] [int] NULL,
	[HoCode] [varchar](255) NULL,
	[ZoneID] [smallint] NULL,
	[StateID] [smallint] NULL,
	[isMetro] [bit] NULL,
	[HQName] [varchar](255) NULL,
	[RegionName] [varchar](255) NULL,
	[DOJ] [varchar](50) NULL,
	[createdOn] [smalldatetime] NULL,
	[isDisabled] [bit] NULL,
	[comments] [nvarchar](4000) NULL,
	[username] [nvarchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[EmpID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [BSV_IVF].[tblemployeesbkup]    Script Date: 08-04-2023 13:45:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [BSV_IVF].[tblemployeesbkup](
	[EmpID] [smallint] IDENTITY(1,1) NOT NULL,
	[firstName] [varchar](255) NULL,
	[lastName] [varchar](255) NULL,
	[MobileNumber] [varchar](255) NULL,
	[Email] [varchar](255) NULL,
	[Password] [varchar](255) NULL,
	[Designation] [varchar](50) NULL,
	[DesignationID] [smallint] NULL,
	[EmpNumber] [int] NULL,
	[HoCode] [varchar](255) NULL,
	[ZoneID] [smallint] NULL,
	[StateID] [smallint] NULL,
	[isMetro] [bit] NULL,
	[HQName] [varchar](255) NULL,
	[RegionName] [varchar](255) NULL,
	[DOJ] [varchar](50) NULL,
	[createdOn] [smalldatetime] NULL,
	[isDisabled] [bit] NULL,
	[comments] [nvarchar](4000) NULL,
	[username] [nvarchar](100) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [BSV_IVF].[tblHierarchy]    Script Date: 08-04-2023 13:45:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [BSV_IVF].[tblHierarchy](
	[hierarchyID] [smallint] IDENTITY(1,1) NOT NULL,
	[EmpID] [smallint] NULL,
	[ParentID] [smallint] NULL,
	[isDisabled] [bit] NULL,
	[createdDate] [smalldatetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[hierarchyID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [BSV_IVF].[tblHospitals]    Script Date: 08-04-2023 13:45:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [BSV_IVF].[tblHospitals](
	[hospitalId] [smallint] IDENTITY(1,1) NOT NULL,
	[hospitalName] [varchar](255) NULL,
	[regionName] [varchar](255) NULL,
	[isDisabled] [bit] NULL,
	[CreatedOn] [smalldatetime] NULL,
	[bedNo] [int] NULL,
	[ICUbedNo] [int] NULL,
	[DrName] [nvarchar](255) NULL,
	[Embryologist] [nvarchar](255) NULL,
	[ChainStatus] [smallint] NULL,
PRIMARY KEY CLUSTERED 
(
	[hospitalId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [BSV_IVF].[tbljohnsonbkup]    Script Date: 08-04-2023 13:45:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [BSV_IVF].[tbljohnsonbkup](
	[Division] [nvarchar](500) NOT NULL,
	[_3rd_Level_Reporting_Region] [nvarchar](500) NOT NULL,
	[_2nd_Level_Reporting_Region] [nvarchar](500) NOT NULL,
	[_1st_Level_Reporting_Region] [nvarchar](500) NOT NULL,
	[State] [nvarchar](500) NOT NULL,
	[HQ_Name] [nvarchar](500) NOT NULL,
	[HQ_Code] [nvarchar](500) NOT NULL,
	[User_Name] [nvarchar](500) NOT NULL,
	[Employee_Name] [nvarchar](500) NOT NULL,
	[Employee_Number] [nvarchar](500) NOT NULL,
	[Designation] [nvarchar](500) NOT NULL,
	[Customer_Code] [nvarchar](500) NOT NULL,
	[Doctor_Name] [nvarchar](500) NOT NULL,
	[Visit_Category] [nvarchar](500) NOT NULL,
	[Specialty] [nvarchar](500) NOT NULL,
	[Business_Category] [nvarchar](500) NULL,
	[MDL_Number] [nvarchar](500) NULL,
	[Qualification] [nvarchar](500) NULL,
	[Doctor_Unique_Code] [nvarchar](500) NULL,
	[Primary_Mobile] [nvarchar](500) NULL,
	[Primary_Email_Id] [nvarchar](500) NULL,
	[Address1] [nvarchar](500) NULL,
	[Address2] [nvarchar](500) NULL,
	[Local_Area] [nvarchar](500) NULL,
	[City] [nvarchar](500) NULL,
	[State1] [nvarchar](500) NULL,
	[Pin_Code] [nvarchar](500) NULL,
	[Phone] [nvarchar](500) NULL,
	[Mobile] [nvarchar](500) NOT NULL,
	[Email] [nvarchar](500) NULL,
	[Date_of_Birth] [nvarchar](500) NULL,
	[Date_of_Anniversary] [nvarchar](500) NULL,
	[Hospital_Name] [nvarchar](500) NULL,
	[Hospital_Classification] [nvarchar](500) NULL,
	[Registration_Number] [nvarchar](500) NULL,
	[Reference_Key1] [nvarchar](500) NOT NULL,
	[Reference_Key2] [nvarchar](500) NOT NULL,
	[Doctor_Image_URL] [nvarchar](500) NULL,
	[Created_Date] [nvarchar](500) NOT NULL,
	[Ageing_of_Doctor_In_Days] [nvarchar](500) NOT NULL,
	[Updated_By] [nvarchar](500) NULL,
	[Updated_Date] [nvarchar](500) NULL,
	[Mapped_Marketing_Campaigns] [nvarchar](500) NULL,
	[Chemist_Mapped] [nvarchar](500) NULL,
	[Chemist_MCL_Numner] [nvarchar](500) NULL,
	[Stockist_Mapped] [nvarchar](500) NULL,
	[Stockist_Ref_Key] [nvarchar](500) NULL,
	[SFC_Category] [nvarchar](500) NULL,
	[From_Place] [nvarchar](500) NULL,
	[To_Place] [nvarchar](500) NULL,
	[Travel_Mode] [nvarchar](500) NULL,
	[Locaiton_Tagged_Status] [nvarchar](500) NOT NULL,
	[Locaiton_Tagged_Date] [nvarchar](500) NULL,
	[Locaiton_Tagged_By] [nvarchar](500) NULL,
	[Locaiton_Tagged_Designation] [nvarchar](500) NULL,
	[Tagged_Latitude] [nvarchar](500) NULL,
	[Tagged_Longitude] [nvarchar](500) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [BSV_IVF].[tblLastLoginDetails]    Script Date: 08-04-2023 13:45:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [BSV_IVF].[tblLastLoginDetails](
	[loginLogID] [smallint] IDENTITY(1,1) NOT NULL,
	[EmpID] [smallint] NULL,
	[lastLoginDate] [smalldatetime] NULL,
	[isLastLogin] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[loginLogID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [BSV_IVF].[tblSKUs]    Script Date: 08-04-2023 13:45:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [BSV_IVF].[tblSKUs](
	[medID] [smallint] IDENTITY(1,1) NOT NULL,
	[brandId] [int] NULL,
	[brandGroupId] [int] NULL,
	[medicineName] [varchar](255) NULL,
	[imageURL] [varchar](255) NULL,
	[descp] [varchar](255) NULL,
	[isDisabled] [bit] NULL,
	[createdDate] [smalldatetime] NULL,
	[SortOrder] [smallint] NULL,
	[Price] [float] NULL,
PRIMARY KEY CLUSTERED 
(
	[medID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [BSV_IVF].[tblSpecialtyTypeBkup]    Script Date: 08-04-2023 13:45:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [BSV_IVF].[tblSpecialtyTypeBkup](
	[specialtyId] [int] IDENTITY(1,1) NOT NULL,
	[isDisabled] [int] NULL,
	[CreatedDate] [smalldatetime] NULL,
	[name] [nvarchar](50) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [BSV_IVF].[tblState]    Script Date: 08-04-2023 13:45:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [BSV_IVF].[tblState](
	[stateID] [smallint] IDENTITY(1,1) NOT NULL,
	[StateName] [varchar](255) NULL,
	[isDisabled] [bit] NULL,
	[createdDate] [smalldatetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[stateID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [BSV_IVF].[tblZone]    Script Date: 08-04-2023 13:45:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [BSV_IVF].[tblZone](
	[zoneID] [smallint] IDENTITY(1,1) NOT NULL,
	[name] [varchar](255) NULL,
	[isDisable] [bit] NULL,
	[createdDate] [smalldatetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[zoneID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblAccount]    Script Date: 08-04-2023 13:45:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblAccount](
	[accountID] [int] IDENTITY(1000,1) NOT NULL,
	[accountName] [nvarchar](500) NULL,
	[createdDate] [date] NULL,
	[isActive] [bit] NULL,
 CONSTRAINT [PK_tblAccount] PRIMARY KEY CLUSTERED 
(
	[accountID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblActuals]    Script Date: 08-04-2023 13:45:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblActuals](
	[actualId] [int] IDENTITY(1,1) NOT NULL,
	[empId] [int] NULL,
	[hospitalId] [int] NULL,
	[brandId] [int] NULL,
	[unit] [int] NULL,
	[price] [float] NULL,
	[actualEnteredFor] [smalldatetime] NULL,
	[contractRate] [bit] NULL,
	[ContractEndDate] [smalldatetime] NULL,
	[isDisabled] [bit] NULL,
	[createdDate] [smalldatetime] NULL,
 CONSTRAINT [PK_tblActuals] PRIMARY KEY CLUSTERED 
(
	[actualId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblarun]    Script Date: 08-04-2023 13:45:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblarun](
	[Division] [nvarchar](500) NOT NULL,
	[_3rd_Level_Reporting_Region] [nvarchar](500) NOT NULL,
	[_2nd_Level_Reporting_Region] [nvarchar](500) NOT NULL,
	[_1st_Level_Reporting_Region] [nvarchar](500) NOT NULL,
	[State] [nvarchar](500) NOT NULL,
	[HQ_Name] [nvarchar](500) NOT NULL,
	[HQ_Code] [nvarchar](500) NOT NULL,
	[User_Name] [nvarchar](500) NOT NULL,
	[Employee_Name] [nvarchar](500) NOT NULL,
	[Employee_Number] [nvarchar](500) NOT NULL,
	[Designation] [nvarchar](500) NOT NULL,
	[Customer_Code] [nvarchar](500) NOT NULL,
	[Doctor_Name] [nvarchar](500) NOT NULL,
	[Visit_Category] [nvarchar](500) NOT NULL,
	[Specialty] [nvarchar](500) NOT NULL,
	[Business_Category] [nvarchar](500) NULL,
	[MDL_Number] [nvarchar](500) NOT NULL,
	[Qualification] [nvarchar](500) NULL,
	[Doctor_Unique_Code] [nvarchar](500) NOT NULL,
	[Primary_Mobile] [nvarchar](500) NULL,
	[Primary_Email_Id] [nvarchar](500) NULL,
	[Address1] [nvarchar](500) NULL,
	[Address2] [nvarchar](500) NULL,
	[Local_Area] [nvarchar](500) NULL,
	[City] [nvarchar](500) NULL,
	[State1] [nvarchar](500) NULL,
	[Pin_Code] [nvarchar](500) NULL,
	[Phone] [nvarchar](500) NULL,
	[Mobile] [nvarchar](500) NOT NULL,
	[Email] [nvarchar](500) NULL,
	[Date_of_Birth] [nvarchar](500) NULL,
	[Date_of_Anniversary] [nvarchar](500) NULL,
	[centre_name] [nvarchar](500) NULL,
	[account_name] [nvarchar](500) NULL,
	[Registration_Number] [nvarchar](500) NULL,
	[Reference_Key1] [nvarchar](500) NOT NULL,
	[Reference_Key2] [nvarchar](500) NOT NULL,
	[Doctor_Image_URL] [nvarchar](500) NULL,
	[Created_Date] [nvarchar](500) NOT NULL,
	[Ageing_of_Doctor_In_Days] [nvarchar](500) NOT NULL,
	[Updated_By] [nvarchar](500) NULL,
	[Updated_Date] [nvarchar](500) NULL,
	[Mapped_Marketing_Campaigns] [nvarchar](500) NULL,
	[Chemist_Mapped] [nvarchar](500) NULL,
	[Chemist_MCL_Numner] [nvarchar](500) NULL,
	[Stockist_Mapped] [nvarchar](500) NULL,
	[Stockist_Ref_Key] [nvarchar](500) NULL,
	[SFC_Category] [nvarchar](500) NULL,
	[From_Place] [nvarchar](500) NULL,
	[To_Place] [nvarchar](500) NULL,
	[Travel_Mode] [nvarchar](500) NULL,
	[Locaiton_Tagged_Status] [nvarchar](500) NOT NULL,
	[Locaiton_Tagged_Date] [nvarchar](500) NULL,
	[Locaiton_Tagged_By] [nvarchar](500) NULL,
	[Locaiton_Tagged_Designation] [nvarchar](500) NULL,
	[Tagged_Latitude] [nvarchar](500) NULL,
	[Tagged_Longitude] [nvarchar](500) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblBASANT]    Script Date: 08-04-2023 13:45:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblBASANT](
	[Division] [nvarchar](500) NULL,
	[_3rd_Level_Reporting_Region] [nvarchar](500) NULL,
	[_2nd_Level_Reporting_Region] [nvarchar](500) NULL,
	[_1st_Level_Reporting_Region] [nvarchar](500) NULL,
	[State] [nvarchar](500) NULL,
	[HQ_Name] [nvarchar](500) NULL,
	[HQ_Code] [nvarchar](500) NULL,
	[User_Name] [nvarchar](500) NULL,
	[Employee_Name] [nvarchar](500) NULL,
	[Employee_Number] [nvarchar](500) NULL,
	[Designation] [nvarchar](500) NULL,
	[Customer_Code] [nvarchar](500) NULL,
	[Doctor_Name] [nvarchar](500) NULL,
	[Visit_Category] [nvarchar](500) NULL,
	[Specialty] [nvarchar](500) NULL,
	[Business_Category] [nvarchar](500) NULL,
	[MDL_Number] [nvarchar](500) NULL,
	[Qualification] [nvarchar](500) NULL,
	[Doctor_Unique_Code] [nvarchar](500) NULL,
	[Primary_Mobile] [nvarchar](500) NULL,
	[Primary_Email_Id] [nvarchar](500) NULL,
	[Address1] [nvarchar](500) NULL,
	[Address2] [nvarchar](500) NULL,
	[Local_Area] [nvarchar](500) NULL,
	[City] [nvarchar](500) NULL,
	[State1] [nvarchar](500) NULL,
	[Pin_Code] [nvarchar](500) NULL,
	[Phone] [nvarchar](500) NULL,
	[Mobile] [nvarchar](500) NULL,
	[Email] [nvarchar](500) NULL,
	[Date_of_Birth] [nvarchar](500) NULL,
	[Date_of_Anniversary] [nvarchar](500) NULL,
	[CENTRE_NAME] [nvarchar](500) NULL,
	[ACCOUNT_NAME] [nvarchar](500) NULL,
	[Registration_Number] [nvarchar](500) NULL,
	[Reference_Key1] [nvarchar](500) NULL,
	[Reference_Key2] [nvarchar](500) NULL,
	[Doctor_Image_URL] [nvarchar](500) NULL,
	[Created_Date] [nvarchar](500) NULL,
	[Ageing_of_Doctor_In_Days] [nvarchar](500) NULL,
	[Updated_By] [nvarchar](500) NULL,
	[Updated_Date] [nvarchar](500) NULL,
	[Mapped_Marketing_Campaigns] [nvarchar](500) NULL,
	[Chemist_Mapped] [nvarchar](500) NULL,
	[Chemist_MCL_Numner] [nvarchar](500) NULL,
	[Stockist_Mapped] [nvarchar](500) NULL,
	[Stockist_Ref_Key] [nvarchar](500) NULL,
	[SFC_Category] [nvarchar](500) NULL,
	[From_Place] [nvarchar](500) NULL,
	[To_Place] [nvarchar](500) NULL,
	[Travel_Mode] [nvarchar](500) NULL,
	[Locaiton_Tagged_Status] [nvarchar](500) NULL,
	[Locaiton_Tagged_Date] [nvarchar](500) NULL,
	[Locaiton_Tagged_By] [nvarchar](500) NULL,
	[Locaiton_Tagged_Designation] [nvarchar](500) NULL,
	[Tagged_Latitude] [nvarchar](500) NULL,
	[Tagged_Longitude] [nvarchar](500) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblBrandGroups]    Script Date: 08-04-2023 13:45:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblBrandGroups](
	[brandGroupId] [int] IDENTITY(1,1) NOT NULL,
	[brandId] [int] NULL,
	[groupName] [nvarchar](200) NULL,
	[imageUrl] [nvarchar](200) NULL,
	[isDisabled] [bit] NULL,
	[createdDate] [smalldatetime] NULL,
 CONSTRAINT [PK_tblBrandGroups] PRIMARY KEY CLUSTERED 
(
	[brandGroupId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblChainStatus]    Script Date: 08-04-2023 13:45:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblChainStatus](
	[chainId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](10) NULL,
	[isDisabled] [int] NULL,
	[CreatedDate] [smalldatetime] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblCustomers]    Script Date: 08-04-2023 13:45:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblCustomers](
	[customerId] [int] IDENTITY(1,1) NOT NULL,
	[code] [nvarchar](10) NULL,
	[DoctorName] [nvarchar](100) NULL,
	[mobile] [nvarchar](50) NULL,
	[email] [nvarchar](50) NULL,
	[CENTRENAME] [nvarchar](100) NULL,
	[Address1] [nvarchar](500) NULL,
	[Address2] [nvarchar](200) NULL,
	[LocalArea] [nvarchar](200) NULL,
	[City] [nvarchar](200) NULL,
	[StateID] [int] NULL,
	[PinCode] [nvarchar](20) NULL,
	[ChemistMapped] [nvarchar](200) NULL,
	[CreatedDate] [smalldatetime] NULL,
	[isdisabled] [bit] NULL,
	[DoctorUniqueCode] [nvarchar](100) NULL,
	[chainID] [tinyint] NULL,
	[visitId] [tinyint] NULL,
	[SpecialtyId] [tinyint] NULL,
	[chainAccountTypeId] [int] NULL,
	[isApproved] [bit] NULL,
	[approvedBy] [int] NULL,
	[approvedOn] [smalldatetime] NULL,
	[accountID] [int] NULL,
 CONSTRAINT [PK_tblCustomers] PRIMARY KEY CLUSTERED 
(
	[customerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblDataDump]    Script Date: 08-04-2023 13:45:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblDataDump](
	[id] [smallint] NULL,
	[Month] [nvarchar](50) NULL,
	[ZBM] [nvarchar](50) NULL,
	[RBM] [nvarchar](50) NULL,
	[KAM] [nvarchar](50) NULL,
	[Customer_Code] [nvarchar](1) NULL,
	[Name_of_Dr] [nvarchar](50) NULL,
	[Centre_Name] [nvarchar](50) NULL,
	[Name_of_Embryologist] [nvarchar](50) NULL,
	[No_of_fresh_cycles_JUNE] [float] NULL,
	[Foligraf_vials_PFS_MD] [nvarchar](50) NULL,
	[Foligraf_Pens] [float] NULL,
	[FOLIGRAF_TOTAL] [float] NULL,
	[Gonal_F_vials_PFS_MD] [float] NULL,
	[Gonal_F_Pens] [float] NULL,
	[Folisurge_vials_PFS_MD] [nvarchar](50) NULL,
	[Folisurge_Pens] [float] NULL,
	[Other_r_FSH_vials_PFS_MD] [float] NULL,
	[Other_r_FSH_Pens] [float] NULL,
	[Humog_Group] [float] NULL,
	[Menotas_XP_liq_MD_pfs] [float] NULL,
	[Menotas_Menotas_HP_lyo_vials] [float] NULL,
	[Menopur] [float] NULL,
	[Diva_HMG] [float] NULL,
	[Materna_vials_PFS_MD] [float] NULL,
	[Other_HMG] [float] NULL,
	[Asporelix] [float] NULL,
	[Other_Cetrorelix_acetate_LYO] [nvarchar](50) NULL,
	[Other_Cetrorelix_PFS] [nvarchar](50) NULL,
	[R_Hucog] [nvarchar](50) NULL,
	[No_of_cycles_with_Agonist_trigger] [nvarchar](50) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblDelhi]    Script Date: 08-04-2023 13:45:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblDelhi](
	[Division] [nvarchar](500) NULL,
	[_3rd_Level_Reporting_Region] [nvarchar](500) NULL,
	[_2nd_Level_Reporting_Region] [nvarchar](500) NULL,
	[_1st_Level_Reporting_Region] [nvarchar](500) NULL,
	[State] [nvarchar](500) NULL,
	[HQ_Name] [nvarchar](500) NULL,
	[HQ_Code] [nvarchar](500) NULL,
	[User_Name] [nvarchar](500) NULL,
	[Employee_Name] [nvarchar](500) NULL,
	[Employee_Number] [nvarchar](500) NULL,
	[Designation] [nvarchar](500) NULL,
	[Customer_Code] [nvarchar](500) NULL,
	[Doctor_Name] [nvarchar](500) NULL,
	[Visit_Category] [nvarchar](500) NULL,
	[Specialty] [nvarchar](500) NULL,
	[Business_Category] [nvarchar](500) NULL,
	[MDL_Number] [nvarchar](500) NULL,
	[Qualification] [nvarchar](500) NULL,
	[Doctor_Unique_Code] [nvarchar](500) NULL,
	[Primary_Mobile] [nvarchar](500) NULL,
	[Primary_Email_Id] [nvarchar](500) NULL,
	[Address1] [nvarchar](500) NULL,
	[Address2] [nvarchar](500) NULL,
	[Local_Area] [nvarchar](500) NULL,
	[City] [nvarchar](500) NULL,
	[State1] [nvarchar](500) NULL,
	[Pin_Code] [nvarchar](500) NULL,
	[Phone] [nvarchar](500) NULL,
	[Mobile] [nvarchar](500) NULL,
	[Email] [nvarchar](500) NULL,
	[Date_of_Birth] [nvarchar](500) NULL,
	[Date_of_Anniversary] [nvarchar](500) NULL,
	[CENTRE_NAME] [nvarchar](500) NULL,
	[ACCOUNT_NAME] [nvarchar](500) NULL,
	[Registration_Number] [nvarchar](500) NULL,
	[Reference_Key1] [nvarchar](500) NULL,
	[Reference_Key2] [nvarchar](500) NULL,
	[Doctor_Image_URL] [nvarchar](500) NULL,
	[Created_Date] [nvarchar](500) NULL,
	[Ageing_of_Doctor_In_Days] [nvarchar](500) NULL,
	[Updated_By] [nvarchar](500) NULL,
	[Updated_Date] [nvarchar](500) NULL,
	[Mapped_Marketing_Campaigns] [nvarchar](500) NULL,
	[Chemist_Mapped] [nvarchar](500) NULL,
	[Chemist_MCL_Numner] [nvarchar](500) NULL,
	[Stockist_Mapped] [nvarchar](500) NULL,
	[Stockist_Ref_Key] [nvarchar](500) NULL,
	[SFC_Category] [nvarchar](500) NULL,
	[From_Place] [nvarchar](500) NULL,
	[To_Place] [nvarchar](500) NULL,
	[Travel_Mode] [nvarchar](500) NULL,
	[Locaiton_Tagged_Status] [nvarchar](500) NULL,
	[Locaiton_Tagged_Date] [nvarchar](500) NULL,
	[Locaiton_Tagged_By] [nvarchar](500) NULL,
	[Locaiton_Tagged_Designation] [nvarchar](500) NULL,
	[Tagged_Latitude] [nvarchar](500) NULL,
	[Tagged_Longitude] [nvarchar](500) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblHITESH]    Script Date: 08-04-2023 13:45:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblHITESH](
	[Division] [nvarchar](500) NULL,
	[_3rd_Level_Reporting_Region] [nvarchar](500) NULL,
	[_2nd_Level_Reporting_Region] [nvarchar](500) NULL,
	[_1st_Level_Reporting_Region] [nvarchar](500) NULL,
	[State] [nvarchar](500) NULL,
	[HQ_Name] [nvarchar](500) NULL,
	[HQ_Code] [nvarchar](500) NULL,
	[User_Name] [nvarchar](500) NULL,
	[Employee_Name] [nvarchar](500) NULL,
	[Employee_Number] [nvarchar](500) NULL,
	[Designation] [nvarchar](500) NULL,
	[Customer_Code] [nvarchar](500) NULL,
	[Doctor_Name] [nvarchar](500) NULL,
	[Visit_Category] [nvarchar](500) NULL,
	[Specialty] [nvarchar](500) NULL,
	[Business_Category] [nvarchar](500) NULL,
	[MDL_Number] [nvarchar](500) NULL,
	[Qualification] [nvarchar](500) NULL,
	[Doctor_Unique_Code] [nvarchar](500) NULL,
	[Primary_Mobile] [nvarchar](500) NULL,
	[Primary_Email_Id] [nvarchar](500) NULL,
	[Address1] [nvarchar](500) NULL,
	[Address2] [nvarchar](500) NULL,
	[Local_Area] [nvarchar](500) NULL,
	[City] [nvarchar](500) NULL,
	[State1] [nvarchar](500) NULL,
	[Pin_Code] [nvarchar](500) NULL,
	[Phone] [nvarchar](500) NULL,
	[Mobile] [nvarchar](500) NULL,
	[Email] [nvarchar](500) NULL,
	[Date_of_Birth] [nvarchar](500) NULL,
	[Date_of_Anniversary] [nvarchar](500) NULL,
	[Centre_name] [nvarchar](500) NULL,
	[Account_name] [nvarchar](500) NULL,
	[Registration_Number] [nvarchar](500) NULL,
	[Reference_Key1] [nvarchar](500) NULL,
	[Reference_Key2] [nvarchar](500) NULL,
	[Doctor_Image_URL] [nvarchar](500) NULL,
	[Created_Date] [nvarchar](500) NULL,
	[Ageing_of_Doctor_In_Days] [nvarchar](500) NULL,
	[Updated_By] [nvarchar](500) NULL,
	[Updated_Date] [nvarchar](500) NULL,
	[Mapped_Marketing_Campaigns] [nvarchar](500) NULL,
	[Chemist_Mapped] [nvarchar](500) NULL,
	[Chemist_MCL_Numner] [nvarchar](500) NULL,
	[Stockist_Mapped] [nvarchar](500) NULL,
	[Stockist_Ref_Key] [nvarchar](500) NULL,
	[SFC_Category] [nvarchar](500) NULL,
	[From_Place] [nvarchar](500) NULL,
	[To_Place] [nvarchar](500) NULL,
	[Travel_Mode] [nvarchar](500) NULL,
	[Locaiton_Tagged_Status] [nvarchar](500) NULL,
	[Locaiton_Tagged_Date] [nvarchar](500) NULL,
	[Locaiton_Tagged_By] [nvarchar](500) NULL,
	[Locaiton_Tagged_Designation] [nvarchar](500) NULL,
	[Tagged_Latitude] [nvarchar](500) NULL,
	[Tagged_Longitude] [nvarchar](500) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblhospitalActuals]    Script Date: 08-04-2023 13:45:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblhospitalActuals](
	[actualId] [int] IDENTITY(1,1) NOT NULL,
	[empId] [int] NULL,
	[hospitalId] [int] NULL,
	[ActualEnteredFor] [date] NULL,
	[brandId] [int] NULL,
	[brandGroupId] [int] NULL,
	[skuId] [int] NULL,
	[rate] [float] NULL,
	[qty] [int] NULL,
	[isContractApplicable] [bit] NULL,
	[isDisabled] [bit] NULL,
	[createdDate] [smalldatetime] NULL,
	[contractEndDate] [nvarchar](20) NULL,
	[isApproved] [tinyint] NULL,
	[approvedBy] [int] NULL,
	[approvedOn] [smalldatetime] NULL,
	[comments] [nvarchar](1000) NULL,
	[rejectedBy] [int] NULL,
	[rejectedOn] [smalldatetime] NULL,
	[rejectComments] [ntext] NULL,
	[ZBMApproved] [tinyint] NULL,
	[ZBMId] [int] NULL,
	[ZBMApprovedOn] [smalldatetime] NULL,
	[finalStatus] [tinyint] NULL,
 CONSTRAINT [PK_tblhospitalActuals] PRIMARY KEY CLUSTERED 
(
	[actualId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TblHospitalsContracts]    Script Date: 08-04-2023 13:45:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblHospitalsContracts](
	[contractId] [int] IDENTITY(1,1) NOT NULL,
	[hospitalId] [int] NULL,
	[contractEndDate] [smalldatetime] NULL,
	[isContractSubmitted] [bit] NULL,
	[CreatedDate] [smalldatetime] NULL,
	[isApproved] [bit] NULL,
	[approvedBy] [int] NULL,
	[approvedOn] [smalldatetime] NULL,
 CONSTRAINT [PK_TblHospitalsContracts] PRIMARY KEY CLUSTERED 
(
	[contractId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TblHospitalsPotentials]    Script Date: 08-04-2023 13:45:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblHospitalsPotentials](
	[potentialId] [int] IDENTITY(1,1) NOT NULL,
	[empId] [int] NULL,
	[hospitalId] [int] NULL,
	[IUICycle] [nvarchar](20) NULL,
	[IVFCycle] [nvarchar](20) NULL,
	[FreshPickUps] [int] NULL,
	[SelftCycle] [int] NULL,
	[DonorCycles] [int] NULL,
	[AgonistCycles] [int] NULL,
	[IsActive] [bit] NULL,
	[PotentialEnteredFor] [smalldatetime] NULL,
	[CreatedDate] [smalldatetime] NULL,
	[frozenTransfers] [int] NULL,
	[Antagonistcycles] [int] NULL,
	[isApproved] [tinyint] NULL,
	[approvedBy] [int] NULL,
	[approvedOn] [smalldatetime] NULL,
	[rejectedBy] [int] NULL,
	[rejectedOn] [smalldatetime] NULL,
	[rejectComments] [ntext] NULL,
	[visitID] [tinyint] NULL,
	[ZBMApproved] [tinyint] NULL,
	[ZBMId] [int] NULL,
	[ZBMApprovedOn] [smalldatetime] NULL,
	[finalStatus] [tinyint] NULL,
 CONSTRAINT [PK_TblHospitalsPotentials] PRIMARY KEY CLUSTERED 
(
	[potentialId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblJAYANTA]    Script Date: 08-04-2023 13:45:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblJAYANTA](
	[Division] [nvarchar](500) NULL,
	[_3rd_Level_Reporting_Region] [nvarchar](500) NULL,
	[_2nd_Level_Reporting_Region] [nvarchar](500) NULL,
	[_1st_Level_Reporting_Region] [nvarchar](500) NULL,
	[State] [nvarchar](500) NULL,
	[HQ_Name] [nvarchar](500) NULL,
	[HQ_Code] [nvarchar](500) NULL,
	[User_Name] [nvarchar](500) NULL,
	[Employee_Name] [nvarchar](500) NULL,
	[Employee_Number] [nvarchar](500) NULL,
	[Designation] [nvarchar](500) NULL,
	[Customer_Code] [nvarchar](500) NULL,
	[Doctor_Name] [nvarchar](500) NULL,
	[Visit_Category] [nvarchar](500) NULL,
	[Specialty] [nvarchar](500) NULL,
	[Business_Category] [nvarchar](500) NULL,
	[MDL_Number] [nvarchar](500) NULL,
	[Qualification] [nvarchar](500) NULL,
	[Doctor_Unique_Code] [nvarchar](500) NULL,
	[Primary_Mobile] [nvarchar](500) NULL,
	[Primary_Email_Id] [nvarchar](500) NULL,
	[Address1] [nvarchar](500) NULL,
	[Address2] [nvarchar](500) NULL,
	[Local_Area] [nvarchar](500) NULL,
	[City] [nvarchar](500) NULL,
	[State1] [nvarchar](500) NULL,
	[Pin_Code] [nvarchar](500) NULL,
	[Phone] [nvarchar](500) NULL,
	[Mobile] [nvarchar](500) NULL,
	[Email] [nvarchar](500) NULL,
	[Date_of_Birth] [nvarchar](500) NULL,
	[Date_of_Anniversary] [nvarchar](500) NULL,
	[CENTRE_NAME] [nvarchar](500) NULL,
	[ACCOUNT_NAME] [nvarchar](500) NULL,
	[Registration_Number] [nvarchar](500) NULL,
	[Reference_Key1] [nvarchar](500) NULL,
	[Reference_Key2] [nvarchar](500) NULL,
	[Doctor_Image_URL] [nvarchar](500) NULL,
	[Created_Date] [nvarchar](500) NULL,
	[Ageing_of_Doctor_In_Days] [nvarchar](500) NULL,
	[Updated_By] [nvarchar](500) NULL,
	[Updated_Date] [nvarchar](500) NULL,
	[Mapped_Marketing_Campaigns] [nvarchar](500) NULL,
	[Chemist_Mapped] [nvarchar](500) NULL,
	[Chemist_MCL_Numner] [nvarchar](500) NULL,
	[Stockist_Mapped] [nvarchar](500) NULL,
	[Stockist_Ref_Key] [nvarchar](500) NULL,
	[SFC_Category] [nvarchar](500) NULL,
	[From_Place] [nvarchar](500) NULL,
	[To_Place] [nvarchar](500) NULL,
	[Travel_Mode] [nvarchar](500) NULL,
	[Locaiton_Tagged_Status] [nvarchar](500) NULL,
	[Locaiton_Tagged_Date] [nvarchar](500) NULL,
	[Locaiton_Tagged_By] [nvarchar](500) NULL,
	[Locaiton_Tagged_Designation] [nvarchar](500) NULL,
	[Tagged_Latitude] [nvarchar](500) NULL,
	[Tagged_Longitude] [nvarchar](500) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblJohnson]    Script Date: 08-04-2023 13:45:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblJohnson](
	[Division] [nvarchar](500) NOT NULL,
	[_3rd_Level_Reporting_Region] [nvarchar](500) NOT NULL,
	[_2nd_Level_Reporting_Region] [nvarchar](500) NOT NULL,
	[_1st_Level_Reporting_Region] [nvarchar](500) NOT NULL,
	[State] [nvarchar](500) NOT NULL,
	[HQ_Name] [nvarchar](500) NOT NULL,
	[HQ_Code] [nvarchar](500) NOT NULL,
	[User_Name] [nvarchar](500) NOT NULL,
	[Employee_Name] [nvarchar](500) NOT NULL,
	[Employee_Number] [nvarchar](500) NOT NULL,
	[Designation] [nvarchar](500) NOT NULL,
	[Customer_Code] [nvarchar](500) NOT NULL,
	[Doctor_Name] [nvarchar](500) NOT NULL,
	[Visit_Category] [nvarchar](500) NOT NULL,
	[Specialty] [nvarchar](500) NOT NULL,
	[Business_Category] [nvarchar](500) NULL,
	[MDL_Number] [nvarchar](500) NULL,
	[Qualification] [nvarchar](500) NULL,
	[Doctor_Unique_Code] [nvarchar](500) NULL,
	[Primary_Mobile] [nvarchar](500) NULL,
	[Primary_Email_Id] [nvarchar](500) NULL,
	[Address1] [nvarchar](500) NULL,
	[Address2] [nvarchar](500) NULL,
	[Local_Area] [nvarchar](500) NULL,
	[City] [nvarchar](500) NULL,
	[State1] [nvarchar](500) NULL,
	[Pin_Code] [nvarchar](500) NULL,
	[Phone] [nvarchar](500) NULL,
	[Mobile] [nvarchar](500) NOT NULL,
	[Email] [nvarchar](500) NULL,
	[Date_of_Birth] [nvarchar](500) NULL,
	[Date_of_Anniversary] [nvarchar](500) NULL,
	[Hospital_Name] [nvarchar](500) NULL,
	[Hospital_Classification] [nvarchar](500) NULL,
	[Registration_Number] [nvarchar](500) NULL,
	[Reference_Key1] [nvarchar](500) NOT NULL,
	[Reference_Key2] [nvarchar](500) NOT NULL,
	[Doctor_Image_URL] [nvarchar](500) NULL,
	[Created_Date] [nvarchar](500) NOT NULL,
	[Ageing_of_Doctor_In_Days] [nvarchar](500) NOT NULL,
	[Updated_By] [nvarchar](500) NULL,
	[Updated_Date] [nvarchar](500) NULL,
	[Mapped_Marketing_Campaigns] [nvarchar](500) NULL,
	[Chemist_Mapped] [nvarchar](500) NULL,
	[Chemist_MCL_Numner] [nvarchar](500) NULL,
	[Stockist_Mapped] [nvarchar](500) NULL,
	[Stockist_Ref_Key] [nvarchar](500) NULL,
	[SFC_Category] [nvarchar](500) NULL,
	[From_Place] [nvarchar](500) NULL,
	[To_Place] [nvarchar](500) NULL,
	[Travel_Mode] [nvarchar](500) NULL,
	[Locaiton_Tagged_Status] [nvarchar](500) NOT NULL,
	[Locaiton_Tagged_Date] [nvarchar](500) NULL,
	[Locaiton_Tagged_By] [nvarchar](500) NULL,
	[Locaiton_Tagged_Designation] [nvarchar](500) NULL,
	[Tagged_Latitude] [nvarchar](500) NULL,
	[Tagged_Longitude] [nvarchar](500) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblKarthik]    Script Date: 08-04-2023 13:45:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblKarthik](
	[Division] [nvarchar](500) NULL,
	[_3rd_Level_Reporting_Region] [nvarchar](500) NULL,
	[_2nd_Level_Reporting_Region] [nvarchar](500) NULL,
	[_1st_Level_Reporting_Region] [nvarchar](500) NULL,
	[State] [nvarchar](500) NULL,
	[HQ_Name] [nvarchar](500) NULL,
	[HQ_Code] [nvarchar](500) NULL,
	[User_Name] [nvarchar](500) NULL,
	[Employee_Name] [nvarchar](500) NULL,
	[Employee_Number] [nvarchar](500) NULL,
	[Designation] [nvarchar](500) NULL,
	[Customer_Code] [nvarchar](500) NULL,
	[Doctor_Name] [nvarchar](500) NULL,
	[Visit_Category] [nvarchar](500) NULL,
	[Specialty] [nvarchar](500) NULL,
	[Business_Category] [nvarchar](500) NULL,
	[MDL_Number] [nvarchar](500) NULL,
	[Qualification] [nvarchar](500) NULL,
	[Doctor_Unique_Code] [nvarchar](500) NULL,
	[Primary_Mobile] [nvarchar](500) NULL,
	[Primary_Email_Id] [nvarchar](500) NULL,
	[Address1] [nvarchar](500) NULL,
	[Address2] [nvarchar](500) NULL,
	[Local_Area] [nvarchar](500) NULL,
	[City] [nvarchar](500) NULL,
	[State1] [nvarchar](500) NULL,
	[Pin_Code] [nvarchar](500) NULL,
	[Phone] [nvarchar](500) NULL,
	[Mobile] [nvarchar](500) NULL,
	[Email] [nvarchar](500) NULL,
	[Date_of_Birth] [nvarchar](500) NULL,
	[Date_of_Anniversary] [nvarchar](500) NULL,
	[Hospital_Name] [nvarchar](500) NULL,
	[Hospital_Classification] [nvarchar](500) NULL,
	[Registration_Number] [nvarchar](500) NULL,
	[Reference_Key1] [nvarchar](500) NULL,
	[Reference_Key2] [nvarchar](500) NULL,
	[Doctor_Image_URL] [nvarchar](500) NULL,
	[Created_Date] [nvarchar](500) NULL,
	[Ageing_of_Doctor_In_Days] [nvarchar](500) NULL,
	[Updated_By] [nvarchar](500) NULL,
	[Updated_Date] [nvarchar](500) NULL,
	[Mapped_Marketing_Campaigns] [nvarchar](500) NULL,
	[Chemist_Mapped] [nvarchar](500) NULL,
	[Chemist_MCL_Numner] [nvarchar](500) NULL,
	[Stockist_Mapped] [nvarchar](500) NULL,
	[Stockist_Ref_Key] [nvarchar](500) NULL,
	[SFC_Category] [nvarchar](500) NULL,
	[From_Place] [nvarchar](500) NULL,
	[To_Place] [nvarchar](500) NULL,
	[Travel_Mode] [nvarchar](500) NULL,
	[Locaiton_Tagged_Status] [nvarchar](500) NULL,
	[Locaiton_Tagged_Date] [nvarchar](500) NULL,
	[Locaiton_Tagged_By] [nvarchar](500) NULL,
	[Locaiton_Tagged_Designation] [nvarchar](500) NULL,
	[Tagged_Latitude] [nvarchar](500) NULL,
	[Tagged_Longitude] [nvarchar](500) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblKERALA]    Script Date: 08-04-2023 13:45:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblKERALA](
	[Division] [nvarchar](500) NULL,
	[_3rd_Level_Reporting_Region] [nvarchar](500) NULL,
	[_2nd_Level_Reporting_Region] [nvarchar](500) NULL,
	[_1st_Level_Reporting_Region] [nvarchar](500) NULL,
	[State] [nvarchar](500) NULL,
	[HQ_Name] [nvarchar](500) NULL,
	[HQ_Code] [nvarchar](500) NULL,
	[User_Name] [nvarchar](500) NULL,
	[Employee_Name] [nvarchar](500) NULL,
	[Employee_Number] [nvarchar](500) NULL,
	[Designation] [nvarchar](500) NULL,
	[Customer_Code] [nvarchar](500) NULL,
	[Doctor_Name] [nvarchar](500) NULL,
	[Visit_Category] [nvarchar](500) NULL,
	[Specialty] [nvarchar](500) NULL,
	[Business_Category] [nvarchar](500) NULL,
	[MDL_Number] [nvarchar](500) NULL,
	[Qualification] [nvarchar](500) NULL,
	[Doctor_Unique_Code] [nvarchar](500) NULL,
	[Primary_Mobile] [nvarchar](500) NULL,
	[Primary_Email_Id] [nvarchar](500) NULL,
	[Address1] [nvarchar](500) NULL,
	[Address2] [nvarchar](500) NULL,
	[Local_Area] [nvarchar](500) NULL,
	[City] [nvarchar](500) NULL,
	[State1] [nvarchar](500) NULL,
	[Pin_Code] [nvarchar](500) NULL,
	[Phone] [nvarchar](500) NULL,
	[Mobile] [nvarchar](500) NULL,
	[Email] [nvarchar](500) NULL,
	[Date_of_Birth] [nvarchar](500) NULL,
	[Date_of_Anniversary] [nvarchar](500) NULL,
	[CENTRE_NAME] [nvarchar](500) NULL,
	[ACCOUNT_NAME] [nvarchar](500) NULL,
	[Registration_Number] [nvarchar](500) NULL,
	[Reference_Key1] [nvarchar](500) NULL,
	[Reference_Key2] [nvarchar](500) NULL,
	[Doctor_Image_URL] [nvarchar](500) NULL,
	[Created_Date] [nvarchar](500) NULL,
	[Ageing_of_Doctor_In_Days] [nvarchar](500) NULL,
	[Updated_By] [nvarchar](500) NULL,
	[Updated_Date] [nvarchar](500) NULL,
	[Mapped_Marketing_Campaigns] [nvarchar](500) NULL,
	[Chemist_Mapped] [nvarchar](500) NULL,
	[Chemist_MCL_Numner] [nvarchar](500) NULL,
	[Stockist_Mapped] [nvarchar](500) NULL,
	[Stockist_Ref_Key] [nvarchar](500) NULL,
	[SFC_Category] [nvarchar](500) NULL,
	[From_Place] [nvarchar](500) NULL,
	[To_Place] [nvarchar](500) NULL,
	[Travel_Mode] [nvarchar](500) NULL,
	[Locaiton_Tagged_Status] [nvarchar](500) NULL,
	[Locaiton_Tagged_Date] [nvarchar](500) NULL,
	[Locaiton_Tagged_By] [nvarchar](500) NULL,
	[Locaiton_Tagged_Designation] [nvarchar](500) NULL,
	[Tagged_Latitude] [nvarchar](500) NULL,
	[Tagged_Longitude] [nvarchar](500) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblMadhu]    Script Date: 08-04-2023 13:45:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblMadhu](
	[Division] [nvarchar](500) NULL,
	[_3rd_Level_Reporting_Region] [nvarchar](500) NULL,
	[_2nd_Level_Reporting_Region] [nvarchar](500) NULL,
	[_1st_Level_Reporting_Region] [nvarchar](500) NULL,
	[State] [nvarchar](500) NULL,
	[HQ_Name] [nvarchar](500) NULL,
	[HQ_Code] [nvarchar](500) NULL,
	[User_Name] [nvarchar](500) NULL,
	[Employee_Name] [nvarchar](500) NULL,
	[Employee_Number] [nvarchar](500) NULL,
	[Designation] [nvarchar](500) NULL,
	[Customer_Code] [nvarchar](500) NULL,
	[Doctor_Name] [nvarchar](500) NULL,
	[Visit_Category] [nvarchar](500) NULL,
	[Specialty] [nvarchar](500) NULL,
	[Business_Category] [nvarchar](500) NULL,
	[MDL_Number] [nvarchar](500) NULL,
	[Qualification] [nvarchar](500) NULL,
	[Doctor_Unique_Code] [nvarchar](500) NULL,
	[Primary_Mobile] [nvarchar](500) NULL,
	[Primary_Email_Id] [nvarchar](500) NULL,
	[Address1] [nvarchar](500) NULL,
	[Address2] [nvarchar](500) NULL,
	[Local_Area] [nvarchar](500) NULL,
	[City] [nvarchar](500) NULL,
	[State1] [nvarchar](500) NULL,
	[Pin_Code] [nvarchar](500) NULL,
	[Phone] [nvarchar](500) NULL,
	[Mobile] [nvarchar](500) NULL,
	[Email] [nvarchar](500) NULL,
	[Date_of_Birth] [nvarchar](500) NULL,
	[Date_of_Anniversary] [nvarchar](500) NULL,
	[CENTRE_NAME] [nvarchar](500) NULL,
	[ACCOUNT_NAME] [nvarchar](500) NULL,
	[Registration_Number] [nvarchar](500) NULL,
	[Reference_Key1] [nvarchar](500) NULL,
	[Reference_Key2] [nvarchar](500) NULL,
	[Doctor_Image_URL] [nvarchar](500) NULL,
	[Created_Date] [nvarchar](500) NULL,
	[Ageing_of_Doctor_In_Days] [nvarchar](500) NULL,
	[Updated_By] [nvarchar](500) NULL,
	[Updated_Date] [nvarchar](500) NULL,
	[Mapped_Marketing_Campaigns] [nvarchar](500) NULL,
	[Chemist_Mapped] [nvarchar](500) NULL,
	[Chemist_MCL_Numner] [nvarchar](500) NULL,
	[Stockist_Mapped] [nvarchar](500) NULL,
	[Stockist_Ref_Key] [nvarchar](500) NULL,
	[SFC_Category] [nvarchar](500) NULL,
	[From_Place] [nvarchar](500) NULL,
	[To_Place] [nvarchar](500) NULL,
	[Travel_Mode] [nvarchar](500) NULL,
	[Locaiton_Tagged_Status] [nvarchar](500) NULL,
	[Locaiton_Tagged_Date] [nvarchar](500) NULL,
	[Locaiton_Tagged_By] [nvarchar](500) NULL,
	[Locaiton_Tagged_Designation] [nvarchar](500) NULL,
	[Tagged_Latitude] [nvarchar](500) NULL,
	[Tagged_Longitude] [nvarchar](500) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblMarketInsights]    Script Date: 08-04-2023 13:45:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblMarketInsights](
	[insightId] [int] IDENTITY(1000,1) NOT NULL,
	[empId] [int] NULL,
	[centreId] [int] NULL,
	[addedFor] [date] NULL,
	[answerOne] [bit] NULL,
	[AnswerTwo] [nvarchar](max) NULL,
	[answerThreeRFSH] [nvarchar](50) NULL,
	[answerThreeHMG] [nvarchar](50) NULL,
	[answerFourRHCG] [nvarchar](50) NULL,
	[answerFourAgonistL] [nvarchar](50) NULL,
	[answerFourAgonistT] [nvarchar](50) NULL,
	[answerFourRHCGTriptorelin] [nvarchar](50) NULL,
	[answerFourRHCGLeuprolide] [nvarchar](50) NULL,
	[answerProgesterone] [nvarchar](50) NULL,
	[answerFiveDydrogesterone] [nvarchar](50) NULL,
	[answerFiveCombination] [nvarchar](50) NULL,
	[createdDate] [smalldatetime] NULL,
	[isActive] [bit] NULL,
	[isApproved] [tinyint] NULL,
	[ApprovedBy] [int] NULL,
	[ApprovedOn] [smalldatetime] NULL,
	[RejectedBy] [int] NULL,
	[RejectedOn] [smalldatetime] NULL,
	[ZBMApproved] [tinyint] NULL,
	[ZBMId] [int] NULL,
	[ZBMApprovedOn] [smalldatetime] NULL,
	[rejectComments] [nvarchar](max) NULL,
	[answerFourUHCG] [nvarchar](100) NULL,
	[finalStatus] [tinyint] NULL,
 CONSTRAINT [PK_tblMarketInsights] PRIMARY KEY CLUSTERED 
(
	[insightId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblMinakshi]    Script Date: 08-04-2023 13:45:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblMinakshi](
	[Division] [nvarchar](500) NULL,
	[_3rd_Level_Reporting_Region] [nvarchar](500) NULL,
	[_2nd_Level_Reporting_Region] [nvarchar](500) NULL,
	[_1st_Level_Reporting_Region] [nvarchar](500) NULL,
	[State] [nvarchar](500) NULL,
	[HQ_Name] [nvarchar](500) NULL,
	[HQ_Code] [nvarchar](500) NULL,
	[User_Name] [nvarchar](500) NULL,
	[Employee_Name] [nvarchar](500) NULL,
	[Employee_Number] [nvarchar](500) NULL,
	[Designation] [nvarchar](500) NULL,
	[Customer_Code] [nvarchar](500) NULL,
	[Doctor_Name] [nvarchar](500) NULL,
	[Visit_Category] [nvarchar](500) NULL,
	[Specialty] [nvarchar](500) NULL,
	[Business_Category] [nvarchar](500) NULL,
	[MDL_Number] [nvarchar](500) NULL,
	[Qualification] [nvarchar](500) NULL,
	[Doctor_Unique_Code] [nvarchar](500) NULL,
	[Primary_Mobile] [nvarchar](500) NULL,
	[Primary_Email_Id] [nvarchar](500) NULL,
	[Address1] [nvarchar](500) NULL,
	[Address2] [nvarchar](500) NULL,
	[Local_Area] [nvarchar](500) NULL,
	[City] [nvarchar](500) NULL,
	[State1] [nvarchar](500) NULL,
	[Pin_Code] [nvarchar](500) NULL,
	[Phone] [nvarchar](500) NULL,
	[Mobile] [nvarchar](500) NULL,
	[Email] [nvarchar](500) NULL,
	[Date_of_Birth] [nvarchar](500) NULL,
	[Date_of_Anniversary] [nvarchar](500) NULL,
	[CENTRE_NAME] [nvarchar](500) NULL,
	[ACCOUNT_NAME] [nvarchar](500) NULL,
	[Registration_Number] [nvarchar](500) NULL,
	[Reference_Key1] [nvarchar](500) NULL,
	[Reference_Key2] [nvarchar](500) NULL,
	[Doctor_Image_URL] [nvarchar](500) NULL,
	[Created_Date] [nvarchar](500) NULL,
	[Ageing_of_Doctor_In_Days] [nvarchar](500) NULL,
	[Updated_By] [nvarchar](500) NULL,
	[Updated_Date] [nvarchar](500) NULL,
	[Mapped_Marketing_Campaigns] [nvarchar](500) NULL,
	[Chemist_Mapped] [nvarchar](500) NULL,
	[Chemist_MCL_Numner] [nvarchar](500) NULL,
	[Stockist_Mapped] [nvarchar](500) NULL,
	[Stockist_Ref_Key] [nvarchar](500) NULL,
	[SFC_Category] [nvarchar](500) NULL,
	[From_Place] [nvarchar](500) NULL,
	[To_Place] [nvarchar](500) NULL,
	[Travel_Mode] [nvarchar](500) NULL,
	[Locaiton_Tagged_Status] [nvarchar](500) NULL,
	[Locaiton_Tagged_Date] [nvarchar](500) NULL,
	[Locaiton_Tagged_By] [nvarchar](500) NULL,
	[Locaiton_Tagged_Designation] [nvarchar](500) NULL,
	[Tagged_Latitude] [nvarchar](500) NULL,
	[Tagged_Longitude] [nvarchar](500) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblMSL]    Script Date: 08-04-2023 13:45:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblMSL](
	[Division] [nvarchar](500) NULL,
	[_3rd_Level_Reporting_Region] [nvarchar](500) NULL,
	[_2nd_Level_Reporting_Region] [nvarchar](500) NULL,
	[_1st_Level_Reporting_Region] [nvarchar](500) NULL,
	[State] [nvarchar](500) NULL,
	[HQ_Name] [nvarchar](500) NULL,
	[HQ_Code] [nvarchar](500) NULL,
	[User_Name] [nvarchar](500) NULL,
	[Employee_Name] [nvarchar](500) NULL,
	[Employee_Number] [nvarchar](500) NULL,
	[Designation] [nvarchar](500) NULL,
	[Customer_Code] [nvarchar](500) NULL,
	[Doctor_Name] [nvarchar](500) NULL,
	[Visit_Category] [nvarchar](500) NULL,
	[Specialty] [nvarchar](500) NULL,
	[Business_Category] [nvarchar](500) NULL,
	[MDL_Number] [nvarchar](500) NULL,
	[Qualification] [nvarchar](500) NULL,
	[Doctor_Unique_Code] [nvarchar](500) NULL,
	[Primary_Mobile] [nvarchar](500) NULL,
	[Primary_Email_Id] [nvarchar](500) NULL,
	[Address1] [nvarchar](500) NULL,
	[Address2] [nvarchar](500) NULL,
	[Local_Area] [nvarchar](500) NULL,
	[City] [nvarchar](500) NULL,
	[State1] [nvarchar](500) NULL,
	[Pin_Code] [nvarchar](500) NULL,
	[Phone] [nvarchar](500) NULL,
	[Mobile] [nvarchar](500) NULL,
	[Email] [nvarchar](500) NULL,
	[Date_of_Birth] [nvarchar](500) NULL,
	[Date_of_Anniversary] [nvarchar](500) NULL,
	[CENTRE_NAME] [nvarchar](500) NULL,
	[ACCOUNT_NAME] [nvarchar](500) NULL,
	[Registration_Number] [nvarchar](500) NULL,
	[Reference_Key1] [nvarchar](500) NULL,
	[Reference_Key2] [nvarchar](500) NULL,
	[Doctor_Image_URL] [nvarchar](500) NULL,
	[Created_Date] [nvarchar](500) NULL,
	[Ageing_of_Doctor_In_Days] [nvarchar](500) NULL,
	[Updated_By] [nvarchar](500) NULL,
	[Updated_Date] [nvarchar](500) NULL,
	[Mapped_Marketing_Campaigns] [nvarchar](500) NULL,
	[Chemist_Mapped] [nvarchar](500) NULL,
	[Chemist_MCL_Numner] [nvarchar](500) NULL,
	[Stockist_Mapped] [nvarchar](500) NULL,
	[Stockist_Ref_Key] [nvarchar](500) NULL,
	[SFC_Category] [nvarchar](500) NULL,
	[From_Place] [nvarchar](500) NULL,
	[To_Place] [nvarchar](500) NULL,
	[Travel_Mode] [nvarchar](500) NULL,
	[Locaiton_Tagged_Status] [nvarchar](500) NULL,
	[Locaiton_Tagged_Date] [nvarchar](500) NULL,
	[Locaiton_Tagged_By] [nvarchar](500) NULL,
	[Locaiton_Tagged_Designation] [nvarchar](500) NULL,
	[Tagged_Latitude] [nvarchar](500) NULL,
	[Tagged_Longitude] [nvarchar](500) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblnelson]    Script Date: 08-04-2023 13:45:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblnelson](
	[Division] [nvarchar](500) NULL,
	[_3rd_Level_Reporting_Region] [nvarchar](500) NULL,
	[_2nd_Level_Reporting_Region] [nvarchar](500) NULL,
	[_1st_Level_Reporting_Region] [nvarchar](500) NULL,
	[State] [nvarchar](500) NULL,
	[HQ_Name] [nvarchar](500) NULL,
	[HQ_Code] [nvarchar](500) NULL,
	[User_Name] [nvarchar](500) NULL,
	[Employee_Name] [nvarchar](500) NULL,
	[Employee_Number] [nvarchar](500) NULL,
	[Designation] [nvarchar](500) NULL,
	[Customer_Code] [nvarchar](500) NULL,
	[Doctor_Name] [nvarchar](500) NULL,
	[Visit_Category] [nvarchar](500) NULL,
	[Specialty] [nvarchar](500) NULL,
	[Business_Category] [nvarchar](500) NULL,
	[MDL_Number] [nvarchar](500) NULL,
	[Qualification] [nvarchar](500) NULL,
	[Doctor_Unique_Code] [nvarchar](500) NULL,
	[Primary_Mobile] [nvarchar](500) NULL,
	[Primary_Email_Id] [nvarchar](500) NULL,
	[Address1] [nvarchar](500) NULL,
	[Address2] [nvarchar](500) NULL,
	[Local_Area] [nvarchar](500) NULL,
	[City] [nvarchar](500) NULL,
	[State1] [nvarchar](500) NULL,
	[Pin_Code] [nvarchar](500) NULL,
	[Phone] [nvarchar](500) NULL,
	[Mobile] [nvarchar](500) NULL,
	[Email] [nvarchar](50) NULL,
	[Date_of_Birth] [nvarchar](500) NULL,
	[Date_of_Anniversary] [nvarchar](500) NULL,
	[Hospital_Name] [nvarchar](500) NULL,
	[Hospital_Classification] [nvarchar](500) NULL,
	[Registration_Number] [nvarchar](500) NULL,
	[Reference_Key1] [nvarchar](500) NULL,
	[Reference_Key2] [nvarchar](500) NULL,
	[Doctor_Image_URL] [nvarchar](500) NULL,
	[Created_Date] [nvarchar](500) NULL,
	[Ageing_of_Doctor_In_Days] [nvarchar](500) NULL,
	[Updated_By] [nvarchar](500) NULL,
	[Updated_Date] [nvarchar](500) NULL,
	[Mapped_Marketing_Campaigns] [nvarchar](500) NULL,
	[Chemist_Mapped] [nvarchar](500) NULL,
	[Chemist_MCL_Numner] [nvarchar](500) NULL,
	[Stockist_Mapped] [nvarchar](500) NULL,
	[Stockist_Ref_Key] [nvarchar](500) NULL,
	[SFC_Category] [nvarchar](500) NULL,
	[From_Place] [nvarchar](500) NULL,
	[To_Place] [nvarchar](500) NULL,
	[Travel_Mode] [nvarchar](500) NULL,
	[Locaiton_Tagged_Status] [nvarchar](500) NULL,
	[Locaiton_Tagged_Date] [nvarchar](500) NULL,
	[Locaiton_Tagged_By] [nvarchar](500) NULL,
	[Locaiton_Tagged_Designation] [nvarchar](500) NULL,
	[Tagged_Latitude] [nvarchar](500) NULL,
	[Tagged_Longitude] [nvarchar](500) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbloldData]    Script Date: 08-04-2023 13:45:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbloldData](
	[MONTH] [nvarchar](500) NULL,
	[ZBM] [nvarchar](500) NULL,
	[RBM] [nvarchar](500) NULL,
	[KAM] [nvarchar](500) NULL,
	[Customer_Code] [nvarchar](500) NULL,
	[Name_of_Dr] [nvarchar](500) NULL,
	[Centre_Name] [nvarchar](500) NULL,
	[Name_of_Embryologist] [nvarchar](500) NULL,
	[chain] [nvarchar](500) NULL,
	[city] [nvarchar](500) NULL,
	[KOL_STATUS] [nvarchar](500) NULL,
	[No_of_fresh_cycles] [nvarchar](500) NULL,
	[Foligraf_vials_PFS_MD] [nvarchar](500) NULL,
	[Foligraf_Pens] [nvarchar](500) NULL,
	[Foligraf_all] [nvarchar](500) NULL,
	[Gonal_F_vials_PFS_MD] [nvarchar](500) NULL,
	[Gonal_F_Pens] [nvarchar](500) NULL,
	[Folisurge_vials_PFS_MD] [nvarchar](500) NULL,
	[Folisurge_Pens] [nvarchar](500) NULL,
	[Other_r_FSH_vials_PFS_MD] [nvarchar](500) NULL,
	[Other_r_FSH_Pens] [nvarchar](500) NULL,
	[Humog_Group] [nvarchar](500) NULL,
	[Menotas_XP_liq_MD_pfs] [nvarchar](500) NULL,
	[Menotas_Menotas_HP_lyo_vials] [nvarchar](500) NULL,
	[Menopur] [nvarchar](500) NULL,
	[Diva_HMG] [nvarchar](500) NULL,
	[Materna_vials_PFS_MD] [nvarchar](500) NULL,
	[Other_HMG] [nvarchar](500) NULL,
	[Asporelix] [nvarchar](500) NULL,
	[Other_Cetrorelix_acetate_LYO] [nvarchar](500) NULL,
	[Other_Cetrorelix_PFS] [nvarchar](500) NULL,
	[R_Hucog] [nvarchar](500) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbloldDataNotPorted]    Script Date: 08-04-2023 13:45:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbloldDataNotPorted](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[DoctorName] [nvarchar](100) NULL,
	[CENTRENAME] [nvarchar](100) NULL,
	[businessValue] [nvarchar](500) NULL,
	[BRAND] [nvarchar](1000) NULL,
 CONSTRAINT [PK_tbloldDataNotPorted] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblpartha]    Script Date: 08-04-2023 13:45:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblpartha](
	[Division] [nvarchar](500) NULL,
	[_3rd_Level_Reporting_Region] [nvarchar](500) NULL,
	[_2nd_Level_Reporting_Region] [nvarchar](500) NULL,
	[_1st_Level_Reporting_Region] [nvarchar](500) NULL,
	[State] [nvarchar](500) NULL,
	[HQ_Name] [nvarchar](500) NULL,
	[HQ_Code] [nvarchar](500) NULL,
	[User_Name] [nvarchar](500) NULL,
	[Employee_Name] [nvarchar](500) NULL,
	[Employee_Number] [nvarchar](500) NULL,
	[Designation] [nvarchar](500) NULL,
	[Customer_Code] [nvarchar](500) NULL,
	[Doctor_Name] [nvarchar](500) NULL,
	[Visit_Category] [nvarchar](500) NULL,
	[Specialty] [nvarchar](500) NULL,
	[Business_Category] [nvarchar](500) NULL,
	[MDL_Number] [nvarchar](500) NULL,
	[Qualification] [nvarchar](500) NULL,
	[Doctor_Unique_Code] [nvarchar](500) NULL,
	[Primary_Mobile] [nvarchar](500) NULL,
	[Primary_Email_Id] [nvarchar](500) NULL,
	[Address1] [nvarchar](500) NULL,
	[Address2] [nvarchar](500) NULL,
	[Local_Area] [nvarchar](500) NULL,
	[City] [nvarchar](500) NULL,
	[State1] [nvarchar](500) NULL,
	[Pin_Code] [nvarchar](500) NULL,
	[Phone] [nvarchar](500) NULL,
	[Mobile] [nvarchar](500) NULL,
	[Email] [nvarchar](500) NULL,
	[Date_of_Birth] [nvarchar](500) NULL,
	[Date_of_Anniversary] [nvarchar](500) NULL,
	[CENTRE_NAME] [nvarchar](500) NULL,
	[ACCOUNT_NAME] [nvarchar](500) NULL,
	[Registration_Number] [nvarchar](500) NULL,
	[Reference_Key1] [nvarchar](500) NULL,
	[Reference_Key2] [nvarchar](500) NULL,
	[Doctor_Image_URL] [nvarchar](500) NULL,
	[Created_Date] [nvarchar](500) NULL,
	[Ageing_of_Doctor_In_Days] [nvarchar](500) NULL,
	[Updated_By] [nvarchar](500) NULL,
	[Updated_Date] [nvarchar](500) NULL,
	[Mapped_Marketing_Campaigns] [nvarchar](500) NULL,
	[Chemist_Mapped] [nvarchar](500) NULL,
	[Chemist_MCL_Numner] [nvarchar](500) NULL,
	[Stockist_Mapped] [nvarchar](500) NULL,
	[Stockist_Ref_Key] [nvarchar](500) NULL,
	[SFC_Category] [nvarchar](500) NULL,
	[From_Place] [nvarchar](500) NULL,
	[To_Place] [nvarchar](500) NULL,
	[Travel_Mode] [nvarchar](500) NULL,
	[Locaiton_Tagged_Status] [nvarchar](500) NULL,
	[Locaiton_Tagged_Date] [nvarchar](500) NULL,
	[Locaiton_Tagged_By] [nvarchar](500) NULL,
	[Locaiton_Tagged_Designation] [nvarchar](500) NULL,
	[Tagged_Latitude] [nvarchar](500) NULL,
	[Tagged_Longitude] [nvarchar](500) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblpooja]    Script Date: 08-04-2023 13:45:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblpooja](
	[Division] [nvarchar](500) NULL,
	[_3rd_Level_Reporting_Region] [nvarchar](500) NULL,
	[_2nd_Level_Reporting_Region] [nvarchar](500) NULL,
	[_1st_Level_Reporting_Region] [nvarchar](500) NULL,
	[State] [nvarchar](500) NULL,
	[HQ_Name] [nvarchar](500) NULL,
	[HQ_Code] [nvarchar](500) NULL,
	[User_Name] [nvarchar](500) NULL,
	[Employee_Name] [nvarchar](500) NULL,
	[Employee_Number] [nvarchar](500) NULL,
	[Designation] [nvarchar](500) NULL,
	[Customer_Code] [nvarchar](500) NULL,
	[Doctor_Name] [nvarchar](500) NULL,
	[Visit_Category] [nvarchar](500) NULL,
	[Specialty] [nvarchar](500) NULL,
	[Business_Category] [nvarchar](500) NULL,
	[MDL_Number] [nvarchar](500) NULL,
	[Qualification] [nvarchar](500) NULL,
	[Doctor_Unique_Code] [nvarchar](500) NULL,
	[Primary_Mobile] [nvarchar](500) NULL,
	[Primary_Email_Id] [nvarchar](500) NULL,
	[Address1] [nvarchar](500) NULL,
	[Address2] [nvarchar](500) NULL,
	[Local_Area] [nvarchar](500) NULL,
	[City] [nvarchar](500) NULL,
	[State1] [nvarchar](500) NULL,
	[Pin_Code] [nvarchar](500) NULL,
	[Phone] [nvarchar](500) NULL,
	[Mobile] [nvarchar](500) NULL,
	[Email] [nvarchar](500) NULL,
	[Date_of_Birth] [nvarchar](500) NULL,
	[Date_of_Anniversary] [nvarchar](500) NULL,
	[CENTRE_NAME] [nvarchar](500) NULL,
	[ACCOUNT_NAME] [nvarchar](500) NULL,
	[Registration_Number] [nvarchar](500) NULL,
	[Reference_Key1] [nvarchar](500) NULL,
	[Reference_Key2] [nvarchar](500) NULL,
	[Doctor_Image_URL] [nvarchar](500) NULL,
	[Created_Date] [nvarchar](500) NULL,
	[Ageing_of_Doctor_In_Days] [nvarchar](500) NULL,
	[Updated_By] [nvarchar](500) NULL,
	[Updated_Date] [nvarchar](500) NULL,
	[Mapped_Marketing_Campaigns] [nvarchar](500) NULL,
	[Chemist_Mapped] [nvarchar](500) NULL,
	[Chemist_MCL_Numner] [nvarchar](500) NULL,
	[Stockist_Mapped] [nvarchar](500) NULL,
	[Stockist_Ref_Key] [nvarchar](500) NULL,
	[SFC_Category] [nvarchar](500) NULL,
	[From_Place] [nvarchar](500) NULL,
	[To_Place] [nvarchar](500) NULL,
	[Travel_Mode] [nvarchar](500) NULL,
	[Locaiton_Tagged_Status] [nvarchar](500) NULL,
	[Locaiton_Tagged_Date] [nvarchar](500) NULL,
	[Locaiton_Tagged_By] [nvarchar](500) NULL,
	[Locaiton_Tagged_Designation] [nvarchar](500) NULL,
	[Tagged_Latitude] [nvarchar](500) NULL,
	[Tagged_Longitude] [nvarchar](500) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblPRAHLAD]    Script Date: 08-04-2023 13:45:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblPRAHLAD](
	[Division] [nvarchar](500) NULL,
	[_3rd_Level_Reporting_Region] [nvarchar](500) NULL,
	[_2nd_Level_Reporting_Region] [nvarchar](500) NULL,
	[_1st_Level_Reporting_Region] [nvarchar](500) NULL,
	[State] [nvarchar](500) NULL,
	[HQ_Name] [nvarchar](500) NULL,
	[HQ_Code] [nvarchar](500) NULL,
	[User_Name] [nvarchar](500) NULL,
	[Employee_Name] [nvarchar](500) NULL,
	[Employee_Number] [nvarchar](500) NULL,
	[Designation] [nvarchar](500) NULL,
	[Customer_Code] [nvarchar](500) NULL,
	[Doctor_Name] [nvarchar](500) NULL,
	[Visit_Category] [nvarchar](500) NULL,
	[Specialty] [nvarchar](500) NULL,
	[Business_Category] [nvarchar](500) NULL,
	[MDL_Number] [nvarchar](500) NULL,
	[Qualification] [nvarchar](500) NULL,
	[Doctor_Unique_Code] [nvarchar](500) NULL,
	[Primary_Mobile] [nvarchar](500) NULL,
	[Primary_Email_Id] [nvarchar](500) NULL,
	[Address1] [nvarchar](500) NULL,
	[Address2] [nvarchar](500) NULL,
	[Local_Area] [nvarchar](500) NULL,
	[City] [nvarchar](500) NULL,
	[State1] [nvarchar](500) NULL,
	[Pin_Code] [nvarchar](500) NULL,
	[Phone] [nvarchar](500) NULL,
	[Mobile] [nvarchar](500) NULL,
	[Email] [nvarchar](500) NULL,
	[Date_of_Birth] [nvarchar](500) NULL,
	[Date_of_Anniversary] [nvarchar](500) NULL,
	[CENTRE_NAME] [nvarchar](500) NULL,
	[ACCOUNT_NAME] [nvarchar](500) NULL,
	[Registration_Number] [nvarchar](500) NULL,
	[Reference_Key1] [nvarchar](500) NULL,
	[Reference_Key2] [nvarchar](500) NULL,
	[Doctor_Image_URL] [nvarchar](500) NULL,
	[Created_Date] [nvarchar](500) NULL,
	[Ageing_of_Doctor_In_Days] [nvarchar](500) NULL,
	[Updated_By] [nvarchar](500) NULL,
	[Updated_Date] [nvarchar](500) NULL,
	[Mapped_Marketing_Campaigns] [nvarchar](500) NULL,
	[Chemist_Mapped] [nvarchar](500) NULL,
	[Chemist_MCL_Numner] [nvarchar](500) NULL,
	[Stockist_Mapped] [nvarchar](500) NULL,
	[Stockist_Ref_Key] [nvarchar](500) NULL,
	[SFC_Category] [nvarchar](500) NULL,
	[From_Place] [nvarchar](500) NULL,
	[To_Place] [nvarchar](500) NULL,
	[Travel_Mode] [nvarchar](500) NULL,
	[Locaiton_Tagged_Status] [nvarchar](500) NULL,
	[Locaiton_Tagged_Date] [nvarchar](500) NULL,
	[Locaiton_Tagged_By] [nvarchar](500) NULL,
	[Locaiton_Tagged_Designation] [nvarchar](500) NULL,
	[Tagged_Latitude] [nvarchar](500) NULL,
	[Tagged_Longitude] [nvarchar](500) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblramesh]    Script Date: 08-04-2023 13:45:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblramesh](
	[Division] [nvarchar](500) NOT NULL,
	[_3rd_Level_Reporting_Region] [nvarchar](500) NOT NULL,
	[_2nd_Level_Reporting_Region] [nvarchar](500) NOT NULL,
	[_1st_Level_Reporting_Region] [nvarchar](500) NOT NULL,
	[State] [nvarchar](500) NOT NULL,
	[HQ_Name] [nvarchar](500) NOT NULL,
	[HQ_Code] [nvarchar](500) NOT NULL,
	[User_Name] [nvarchar](500) NOT NULL,
	[Employee_Name] [nvarchar](500) NOT NULL,
	[Employee_Number] [nvarchar](500) NOT NULL,
	[Designation] [nvarchar](500) NOT NULL,
	[Customer_Code] [nvarchar](500) NOT NULL,
	[Doctor_Name] [nvarchar](500) NOT NULL,
	[Visit_Category] [nvarchar](500) NOT NULL,
	[Specialty] [nvarchar](500) NOT NULL,
	[Business_Category] [nvarchar](500) NULL,
	[MDL_Number] [nvarchar](500) NOT NULL,
	[Qualification] [nvarchar](500) NULL,
	[Doctor_Unique_Code] [nvarchar](500) NOT NULL,
	[Primary_Mobile] [nvarchar](500) NULL,
	[Primary_Email_Id] [nvarchar](500) NULL,
	[Address1] [nvarchar](500) NULL,
	[Address2] [nvarchar](500) NULL,
	[Local_Area] [nvarchar](500) NULL,
	[City] [nvarchar](500) NULL,
	[State1] [nvarchar](500) NULL,
	[Pin_Code] [nvarchar](500) NULL,
	[Phone] [nvarchar](500) NULL,
	[Mobile] [nvarchar](500) NOT NULL,
	[Email] [nvarchar](500) NULL,
	[Date_of_Birth] [nvarchar](500) NULL,
	[Date_of_Anniversary] [nvarchar](500) NULL,
	[centre_name] [nvarchar](500) NULL,
	[account_name] [nvarchar](500) NULL,
	[Registration_Number] [nvarchar](500) NULL,
	[Reference_Key1] [nvarchar](500) NOT NULL,
	[Reference_Key2] [nvarchar](500) NOT NULL,
	[Doctor_Image_URL] [nvarchar](500) NULL,
	[Created_Date] [nvarchar](500) NOT NULL,
	[Ageing_of_Doctor_In_Days] [nvarchar](500) NOT NULL,
	[Updated_By] [nvarchar](500) NULL,
	[Updated_Date] [nvarchar](500) NULL,
	[Mapped_Marketing_Campaigns] [nvarchar](500) NULL,
	[Chemist_Mapped] [nvarchar](500) NULL,
	[Chemist_MCL_Numner] [nvarchar](500) NULL,
	[Stockist_Mapped] [nvarchar](500) NULL,
	[Stockist_Ref_Key] [nvarchar](500) NULL,
	[SFC_Category] [nvarchar](500) NULL,
	[From_Place] [nvarchar](500) NULL,
	[To_Place] [nvarchar](500) NULL,
	[Travel_Mode] [nvarchar](500) NULL,
	[Locaiton_Tagged_Status] [nvarchar](500) NOT NULL,
	[Locaiton_Tagged_Date] [nvarchar](500) NULL,
	[Locaiton_Tagged_By] [nvarchar](500) NULL,
	[Locaiton_Tagged_Designation] [nvarchar](500) NULL,
	[Tagged_Latitude] [nvarchar](500) NULL,
	[Tagged_Longitude] [nvarchar](500) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblRCData]    Script Date: 08-04-2023 13:45:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblRCData](
	[RC_Ref_No] [smallint] NULL,
	[RC_Number] [smallint] NULL,
	[RC_Date] [nvarchar](500) NULL,
	[Customer_No] [int] NULL,
	[column5] [smallint] NULL,
	[Customer_Name] [nvarchar](500) NULL,
	[Customer_Acc_Group] [nvarchar](500) NULL,
	[Customer_Acc_Grp_Name] [nvarchar](500) NULL,
	[Material_Code] [int] NULL,
	[Material_Name] [nvarchar](500) NULL,
	[Division_Code] [tinyint] NULL,
	[Division_Name] [nvarchar](500) NULL,
	[Valid_Date_From] [nvarchar](500) NULL,
	[Valid_Date_To] [nvarchar](500) NULL,
	[RC_QTY] [float] NULL,
	[RC_Rate] [float] NULL,
	[STK_Margin] [nvarchar](500) NULL,
	[Status] [nvarchar](500) NULL,
	[RC_Ref_Date] [nvarchar](500) NULL,
	[RbmId] [int] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblrcdataNotPorted]    Script Date: 08-04-2023 13:45:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblrcdataNotPorted](
	[customerId] [int] IDENTITY(1,1) NOT NULL,
	[centername] [nvarchar](500) NULL,
	[grpname] [nvarchar](500) NULL,
	[medname] [nvarchar](500) NULL,
	[price] [nvarchar](500) NULL,
	[STARTDATE] [nvarchar](500) NULL,
	[enddate] [nvarchar](500) NULL,
	[email] [nvarchar](500) NULL,
	[rbmid] [nvarchar](500) NULL,
 CONSTRAINT [PK_tblrcdataNotPorted] PRIMARY KEY CLUSTERED 
(
	[customerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblRCdump]    Script Date: 08-04-2023 13:45:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblRCdump](
	[RC_Ref_No] [nvarchar](500) NULL,
	[RC_Number] [nvarchar](500) NULL,
	[RC_Date] [nvarchar](500) NULL,
	[Customer_No] [nvarchar](500) NULL,
	[Customer_Name] [nvarchar](500) NULL,
	[Customer_Acc_Group] [nvarchar](500) NULL,
	[Customer_Acc_Grp_Name] [nvarchar](500) NULL,
	[Material_Code] [nvarchar](500) NULL,
	[Material_Name] [nvarchar](500) NULL,
	[Division_Code] [nvarchar](500) NULL,
	[Division_Name] [nvarchar](500) NULL,
	[Valid_Date_From] [nvarchar](500) NULL,
	[Valid_Date_To] [nvarchar](500) NULL,
	[RC_QTY] [nvarchar](500) NULL,
	[RC_Rate] [nvarchar](500) NULL,
	[STK_Margin] [nvarchar](500) NULL,
	[Status] [nvarchar](500) NULL,
	[RC_Ref_Date] [nvarchar](500) NULL,
	[accountID] [nvarchar](100) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TblRIYSAT]    Script Date: 08-04-2023 13:45:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblRIYSAT](
	[Division] [nvarchar](500) NULL,
	[_3rd_Level_Reporting_Region] [nvarchar](500) NULL,
	[_2nd_Level_Reporting_Region] [nvarchar](500) NULL,
	[_1st_Level_Reporting_Region] [nvarchar](500) NULL,
	[State] [nvarchar](500) NULL,
	[HQ_Name] [nvarchar](500) NULL,
	[HQ_Code] [nvarchar](500) NULL,
	[User_Name] [nvarchar](500) NULL,
	[Employee_Name] [nvarchar](500) NULL,
	[Employee_Number] [nvarchar](500) NULL,
	[Designation] [nvarchar](500) NULL,
	[Customer_Code] [nvarchar](500) NULL,
	[Doctor_Name] [nvarchar](500) NULL,
	[Visit_Category] [nvarchar](500) NULL,
	[Specialty] [nvarchar](500) NULL,
	[Business_Category] [nvarchar](500) NULL,
	[MDL_Number] [nvarchar](500) NULL,
	[Qualification] [nvarchar](500) NULL,
	[Doctor_Unique_Code] [nvarchar](500) NULL,
	[Primary_Mobile] [nvarchar](500) NULL,
	[Primary_Email_Id] [nvarchar](500) NULL,
	[Address1] [nvarchar](500) NULL,
	[Address2] [nvarchar](500) NULL,
	[Local_Area] [nvarchar](500) NULL,
	[City] [nvarchar](500) NULL,
	[State1] [nvarchar](500) NULL,
	[Pin_Code] [nvarchar](500) NULL,
	[Phone] [nvarchar](500) NULL,
	[Mobile] [nvarchar](500) NULL,
	[Email] [nvarchar](500) NULL,
	[Date_of_Birth] [nvarchar](500) NULL,
	[Date_of_Anniversary] [nvarchar](500) NULL,
	[CENTRE_NAME] [nvarchar](500) NULL,
	[ACCOUNT_NAME] [nvarchar](500) NULL,
	[Registration_Number] [nvarchar](500) NULL,
	[Reference_Key1] [nvarchar](500) NULL,
	[Reference_Key2] [nvarchar](500) NULL,
	[Doctor_Image_URL] [nvarchar](500) NULL,
	[Created_Date] [nvarchar](500) NULL,
	[Ageing_of_Doctor_In_Days] [nvarchar](500) NULL,
	[Updated_By] [nvarchar](500) NULL,
	[Updated_Date] [nvarchar](500) NULL,
	[Mapped_Marketing_Campaigns] [nvarchar](500) NULL,
	[Chemist_Mapped] [nvarchar](500) NULL,
	[Chemist_MCL_Numner] [nvarchar](500) NULL,
	[Stockist_Mapped] [nvarchar](500) NULL,
	[Stockist_Ref_Key] [nvarchar](500) NULL,
	[SFC_Category] [nvarchar](500) NULL,
	[From_Place] [nvarchar](500) NULL,
	[To_Place] [nvarchar](1) NULL,
	[Travel_Mode] [nvarchar](1) NULL,
	[Locaiton_Tagged_Status] [nvarchar](50) NULL,
	[Locaiton_Tagged_Date] [nvarchar](500) NULL,
	[Locaiton_Tagged_By] [nvarchar](500) NULL,
	[Locaiton_Tagged_Designation] [nvarchar](500) NULL,
	[Tagged_Latitude] [nvarchar](500) NULL,
	[Tagged_Longitude] [nvarchar](500) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblRom2]    Script Date: 08-04-2023 13:45:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblRom2](
	[Division] [nvarchar](500) NULL,
	[_3rd_Level_Reporting_Region] [nvarchar](500) NULL,
	[_2nd_Level_Reporting_Region] [nvarchar](500) NULL,
	[_1st_Level_Reporting_Region] [nvarchar](500) NULL,
	[State] [nvarchar](500) NULL,
	[HQ_Name] [nvarchar](500) NULL,
	[HQ_Code] [nvarchar](500) NULL,
	[User_Name] [nvarchar](500) NULL,
	[Employee_Name] [nvarchar](500) NULL,
	[Employee_Number] [nvarchar](500) NULL,
	[Designation] [nvarchar](500) NULL,
	[Customer_Code] [nvarchar](500) NULL,
	[Doctor_Name] [nvarchar](500) NULL,
	[Visit_Category] [nvarchar](500) NULL,
	[Specialty] [nvarchar](500) NULL,
	[Business_Category] [nvarchar](500) NULL,
	[MDL_Number] [nvarchar](500) NULL,
	[Qualification] [nvarchar](500) NULL,
	[Doctor_Unique_Code] [nvarchar](500) NULL,
	[Primary_Mobile] [nvarchar](500) NULL,
	[Primary_Email_Id] [nvarchar](500) NULL,
	[Address1] [nvarchar](500) NULL,
	[Address2] [nvarchar](500) NULL,
	[Local_Area] [nvarchar](500) NULL,
	[City] [nvarchar](500) NULL,
	[State1] [nvarchar](500) NULL,
	[Pin_Code] [nvarchar](500) NULL,
	[Phone] [nvarchar](500) NULL,
	[Mobile] [nvarchar](500) NULL,
	[Email] [nvarchar](500) NULL,
	[Date_of_Birth] [nvarchar](500) NULL,
	[Date_of_Anniversary] [nvarchar](500) NULL,
	[Centre_Name] [nvarchar](500) NULL,
	[Account_Name] [nvarchar](500) NULL,
	[Registration_Number] [nvarchar](500) NULL,
	[Reference_Key1] [nvarchar](500) NULL,
	[Reference_Key2] [nvarchar](500) NULL,
	[Doctor_Image_URL] [nvarchar](500) NULL,
	[Created_Date] [nvarchar](500) NULL,
	[Ageing_of_Doctor_In_Days] [nvarchar](500) NULL,
	[Updated_By] [nvarchar](500) NULL,
	[Updated_Date] [nvarchar](500) NULL,
	[Mapped_Marketing_Campaigns] [nvarchar](500) NULL,
	[Chemist_Mapped] [nvarchar](500) NULL,
	[Chemist_MCL_Numner] [nvarchar](500) NULL,
	[Stockist_Mapped] [nvarchar](500) NULL,
	[Stockist_Ref_Key] [nvarchar](500) NULL,
	[SFC_Category] [nvarchar](500) NULL,
	[From_Place] [nvarchar](500) NULL,
	[To_Place] [nvarchar](500) NULL,
	[Travel_Mode] [nvarchar](500) NULL,
	[Locaiton_Tagged_Status] [nvarchar](500) NULL,
	[Locaiton_Tagged_Date] [nvarchar](500) NULL,
	[Locaiton_Tagged_By] [nvarchar](500) NULL,
	[Locaiton_Tagged_Designation] [nvarchar](500) NULL,
	[Tagged_Latitude] [nvarchar](500) NULL,
	[Tagged_Longitude] [nvarchar](500) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblsajal]    Script Date: 08-04-2023 13:45:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblsajal](
	[Division] [nvarchar](500) NULL,
	[_3rd_Level_Reporting_Region] [nvarchar](500) NULL,
	[_2nd_Level_Reporting_Region] [nvarchar](500) NULL,
	[_1st_Level_Reporting_Region] [nvarchar](500) NULL,
	[State] [nvarchar](500) NULL,
	[HQ_Name] [nvarchar](500) NULL,
	[HQ_Code] [nvarchar](500) NULL,
	[User_Name] [nvarchar](500) NULL,
	[Employee_Name] [nvarchar](500) NULL,
	[Employee_Number] [nvarchar](500) NULL,
	[Designation] [nvarchar](500) NULL,
	[Customer_Code] [nvarchar](500) NULL,
	[Doctor_Name] [nvarchar](500) NULL,
	[Visit_Category] [nvarchar](500) NULL,
	[Specialty] [nvarchar](500) NULL,
	[Business_Category] [nvarchar](500) NULL,
	[MDL_Number] [nvarchar](500) NULL,
	[Qualification] [nvarchar](500) NULL,
	[Doctor_Unique_Code] [nvarchar](500) NULL,
	[Primary_Mobile] [nvarchar](500) NULL,
	[Primary_Email_Id] [nvarchar](500) NULL,
	[Address1] [nvarchar](500) NULL,
	[Address2] [nvarchar](500) NULL,
	[Local_Area] [nvarchar](500) NULL,
	[City] [nvarchar](500) NULL,
	[State1] [nvarchar](500) NULL,
	[Pin_Code] [nvarchar](500) NULL,
	[Phone] [nvarchar](500) NULL,
	[Mobile] [nvarchar](500) NULL,
	[Email] [nvarchar](500) NULL,
	[Date_of_Birth] [nvarchar](500) NULL,
	[Date_of_Anniversary] [nvarchar](500) NULL,
	[CENTRE_NAME] [nvarchar](500) NULL,
	[ACCOUNT_NAME] [nvarchar](500) NULL,
	[Registration_Number] [nvarchar](500) NULL,
	[Reference_Key1] [nvarchar](500) NULL,
	[Reference_Key2] [nvarchar](500) NULL,
	[Doctor_Image_URL] [nvarchar](500) NULL,
	[Created_Date] [nvarchar](500) NULL,
	[Ageing_of_Doctor_In_Days] [nvarchar](500) NULL,
	[Updated_By] [nvarchar](500) NULL,
	[Updated_Date] [nvarchar](500) NULL,
	[Mapped_Marketing_Campaigns] [nvarchar](500) NULL,
	[Chemist_Mapped] [nvarchar](500) NULL,
	[Chemist_MCL_Numner] [nvarchar](500) NULL,
	[Stockist_Mapped] [nvarchar](500) NULL,
	[Stockist_Ref_Key] [nvarchar](500) NULL,
	[SFC_Category] [nvarchar](500) NULL,
	[From_Place] [nvarchar](500) NULL,
	[To_Place] [nvarchar](500) NULL,
	[Travel_Mode] [nvarchar](500) NULL,
	[Locaiton_Tagged_Status] [nvarchar](500) NULL,
	[Locaiton_Tagged_Date] [nvarchar](500) NULL,
	[Locaiton_Tagged_By] [nvarchar](500) NULL,
	[Locaiton_Tagged_Designation] [nvarchar](500) NULL,
	[Tagged_Latitude] [nvarchar](500) NULL,
	[Tagged_Longitude] [nvarchar](500) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblsanjeev]    Script Date: 08-04-2023 13:45:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblsanjeev](
	[Division] [nvarchar](500) NOT NULL,
	[_3rd_Level_Reporting_Region] [nvarchar](500) NOT NULL,
	[_2nd_Level_Reporting_Region] [nvarchar](500) NOT NULL,
	[_1st_Level_Reporting_Region] [nvarchar](500) NOT NULL,
	[State] [nvarchar](500) NOT NULL,
	[HQ_Name] [nvarchar](500) NOT NULL,
	[HQ_Code] [nvarchar](500) NOT NULL,
	[User_Name] [nvarchar](500) NOT NULL,
	[Employee_Name] [nvarchar](500) NOT NULL,
	[Employee_Number] [nvarchar](500) NOT NULL,
	[Designation] [nvarchar](500) NOT NULL,
	[Customer_Code] [nvarchar](500) NULL,
	[Doctor_Name] [nvarchar](500) NOT NULL,
	[Visit_Category] [nvarchar](500) NOT NULL,
	[Specialty] [nvarchar](500) NOT NULL,
	[Business_Category] [nvarchar](500) NULL,
	[MDL_Number] [nvarchar](500) NOT NULL,
	[Qualification] [nvarchar](500) NULL,
	[Doctor_Unique_Code] [nvarchar](500) NULL,
	[Primary_Mobile] [nvarchar](500) NULL,
	[Primary_Email_Id] [nvarchar](500) NULL,
	[Address1] [nvarchar](500) NOT NULL,
	[Address2] [nvarchar](500) NOT NULL,
	[Local_Area] [nvarchar](500) NOT NULL,
	[City] [nvarchar](500) NOT NULL,
	[State1] [nvarchar](500) NOT NULL,
	[Pin_Code] [nvarchar](500) NOT NULL,
	[Phone] [nvarchar](500) NULL,
	[Mobile] [nvarchar](500) NOT NULL,
	[Email] [nvarchar](500) NULL,
	[Date_of_Birth] [nvarchar](500) NULL,
	[Date_of_Anniversary] [nvarchar](500) NULL,
	[CENTRE_NAME] [nvarchar](500) NOT NULL,
	[ACCOUNT_NAME] [nvarchar](500) NOT NULL,
	[Registration_Number] [nvarchar](500) NULL,
	[Reference_Key1] [nvarchar](500) NULL,
	[Reference_Key2] [nvarchar](500) NULL,
	[Doctor_Image_URL] [nvarchar](500) NULL,
	[Created_Date] [nvarchar](500) NOT NULL,
	[Ageing_of_Doctor_In_Days] [nvarchar](500) NULL,
	[Updated_By] [nvarchar](500) NULL,
	[Updated_Date] [nvarchar](500) NULL,
	[Mapped_Marketing_Campaigns] [nvarchar](500) NULL,
	[Chemist_Mapped] [nvarchar](500) NULL,
	[Chemist_MCL_Numner] [nvarchar](500) NULL,
	[Stockist_Mapped] [nvarchar](500) NULL,
	[Stockist_Ref_Key] [nvarchar](500) NULL,
	[SFC_Category] [nvarchar](500) NULL,
	[From_Place] [nvarchar](500) NULL,
	[To_Place] [nvarchar](500) NULL,
	[Travel_Mode] [nvarchar](500) NULL,
	[Locaiton_Tagged_Status] [nvarchar](500) NULL,
	[Locaiton_Tagged_Date] [nvarchar](500) NULL,
	[Locaiton_Tagged_By] [nvarchar](500) NULL,
	[Locaiton_Tagged_Designation] [nvarchar](500) NULL,
	[Tagged_Latitude] [nvarchar](500) NULL,
	[Tagged_Longitude] [nvarchar](500) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblSkuGroup]    Script Date: 08-04-2023 13:45:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblSkuGroup](
	[brandId] [int] IDENTITY(1,1) NOT NULL,
	[brandName] [nvarchar](200) NULL,
	[imageUrl] [nvarchar](200) NULL,
	[IsDisabled] [bit] NULL,
	[createdDate] [smalldatetime] NULL,
	[sortOrder] [tinyint] NULL,
 CONSTRAINT [PK_tblSkuGroup] PRIMARY KEY CLUSTERED 
(
	[brandId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblSpecialtyType]    Script Date: 08-04-2023 13:45:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblSpecialtyType](
	[specialtyId] [int] IDENTITY(1,1) NOT NULL,
	[isDisabled] [int] NULL,
	[CreatedDate] [smalldatetime] NULL,
	[name] [nvarchar](50) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblsubhankar]    Script Date: 08-04-2023 13:45:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblsubhankar](
	[Division] [nvarchar](500) NULL,
	[_3rd_Level_Reporting_Region] [nvarchar](500) NULL,
	[_2nd_Level_Reporting_Region] [nvarchar](500) NULL,
	[_1st_Level_Reporting_Region] [nvarchar](500) NULL,
	[State] [nvarchar](500) NULL,
	[HQ_Name] [nvarchar](500) NULL,
	[HQ_Code] [nvarchar](500) NULL,
	[User_Name] [nvarchar](500) NULL,
	[Employee_Name] [nvarchar](500) NULL,
	[Employee_Number] [nvarchar](500) NULL,
	[Designation] [nvarchar](500) NULL,
	[Customer_Code] [nvarchar](500) NULL,
	[Doctor_Name] [nvarchar](500) NULL,
	[Visit_Category] [nvarchar](500) NULL,
	[Specialty] [nvarchar](500) NULL,
	[Business_Category] [nvarchar](500) NULL,
	[MDL_Number] [nvarchar](500) NULL,
	[Qualification] [nvarchar](500) NULL,
	[Doctor_Unique_Code] [nvarchar](500) NULL,
	[Primary_Mobile] [nvarchar](500) NULL,
	[Primary_Email_Id] [nvarchar](500) NULL,
	[Address1] [nvarchar](500) NULL,
	[Address2] [nvarchar](500) NULL,
	[Local_Area] [nvarchar](500) NULL,
	[City] [nvarchar](500) NULL,
	[State1] [nvarchar](500) NULL,
	[Pin_Code] [nvarchar](500) NULL,
	[Phone] [nvarchar](500) NULL,
	[Mobile] [nvarchar](500) NULL,
	[Email] [nvarchar](500) NULL,
	[Date_of_Birth] [nvarchar](500) NULL,
	[Date_of_Anniversary] [nvarchar](500) NULL,
	[CENTRE_NAME] [nvarchar](500) NULL,
	[ACCOUNT_NAME] [nvarchar](500) NULL,
	[Registration_Number] [nvarchar](500) NULL,
	[Reference_Key1] [nvarchar](500) NULL,
	[Reference_Key2] [nvarchar](500) NULL,
	[Doctor_Image_URL] [nvarchar](500) NULL,
	[Created_Date] [nvarchar](500) NULL,
	[Ageing_of_Doctor_In_Days] [nvarchar](500) NULL,
	[Updated_By] [nvarchar](500) NULL,
	[Updated_Date] [nvarchar](500) NULL,
	[Mapped_Marketing_Campaigns] [nvarchar](500) NULL,
	[Chemist_Mapped] [nvarchar](500) NULL,
	[Chemist_MCL_Numner] [nvarchar](500) NULL,
	[Stockist_Mapped] [nvarchar](500) NULL,
	[Stockist_Ref_Key] [nvarchar](500) NULL,
	[SFC_Category] [nvarchar](500) NULL,
	[From_Place] [nvarchar](500) NULL,
	[To_Place] [nvarchar](500) NULL,
	[Travel_Mode] [nvarchar](500) NULL,
	[Locaiton_Tagged_Status] [nvarchar](500) NULL,
	[Locaiton_Tagged_Date] [nvarchar](500) NULL,
	[Locaiton_Tagged_By] [nvarchar](500) NULL,
	[Locaiton_Tagged_Designation] [nvarchar](500) NULL,
	[Tagged_Latitude] [nvarchar](500) NULL,
	[Tagged_Longitude] [nvarchar](500) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblSubramanian]    Script Date: 08-04-2023 13:45:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblSubramanian](
	[Division] [nvarchar](500) NULL,
	[_3rd_Level_Reporting_Region] [nvarchar](500) NULL,
	[_2nd_Level_Reporting_Region] [nvarchar](500) NULL,
	[_1st_Level_Reporting_Region] [nvarchar](500) NULL,
	[State] [nvarchar](500) NULL,
	[HQ_Name] [nvarchar](500) NULL,
	[HQ_Code] [nvarchar](500) NULL,
	[User_Name] [nvarchar](500) NULL,
	[Employee_Name] [nvarchar](500) NULL,
	[Employee_Number] [nvarchar](500) NULL,
	[Designation] [nvarchar](500) NULL,
	[Customer_Code] [nvarchar](500) NULL,
	[Doctor_Name] [nvarchar](500) NULL,
	[Visit_Category] [nvarchar](500) NULL,
	[Specialty] [nvarchar](500) NULL,
	[Business_Category] [nvarchar](500) NULL,
	[MDL_Number] [nvarchar](500) NULL,
	[Qualification] [nvarchar](500) NULL,
	[Doctor_Unique_Code] [nvarchar](500) NULL,
	[Primary_Mobile] [nvarchar](500) NULL,
	[Primary_Email_Id] [nvarchar](500) NULL,
	[Address1] [nvarchar](500) NULL,
	[Address2] [nvarchar](500) NULL,
	[Local_Area] [nvarchar](50) NULL,
	[City] [nvarchar](50) NULL,
	[State1] [nvarchar](50) NULL,
	[Pin_Code] [nvarchar](500) NULL,
	[Phone] [nvarchar](500) NULL,
	[Mobile] [nvarchar](500) NULL,
	[Email] [nvarchar](500) NULL,
	[Date_of_Birth] [nvarchar](500) NULL,
	[Date_of_Anniversary] [nvarchar](500) NULL,
	[Hospital_Name] [nvarchar](500) NULL,
	[Hospital_Classification] [nvarchar](500) NULL,
	[Registration_Number] [nvarchar](500) NULL,
	[Reference_Key1] [nvarchar](500) NULL,
	[Reference_Key2] [nvarchar](500) NULL,
	[Doctor_Image_URL] [nvarchar](500) NULL,
	[Created_Date] [nvarchar](500) NULL,
	[Ageing_of_Doctor_In_Days] [nvarchar](500) NULL,
	[Updated_By] [nvarchar](500) NULL,
	[Updated_Date] [nvarchar](500) NULL,
	[Mapped_Marketing_Campaigns] [nvarchar](500) NULL,
	[Chemist_Mapped] [nvarchar](500) NULL,
	[Chemist_MCL_Numner] [nvarchar](500) NULL,
	[Stockist_Mapped] [nvarchar](500) NULL,
	[Stockist_Ref_Key] [nvarchar](500) NULL,
	[SFC_Category] [nvarchar](500) NULL,
	[From_Place] [nvarchar](500) NULL,
	[To_Place] [nvarchar](500) NULL,
	[Travel_Mode] [nvarchar](500) NULL,
	[Locaiton_Tagged_Status] [nvarchar](500) NULL,
	[Locaiton_Tagged_Date] [nvarchar](500) NULL,
	[Locaiton_Tagged_By] [nvarchar](500) NULL,
	[Locaiton_Tagged_Designation] [nvarchar](500) NULL,
	[Tagged_Latitude] [nvarchar](500) NULL,
	[Tagged_Longitude] [nvarchar](500) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbltempcustomer]    Script Date: 08-04-2023 13:45:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbltempcustomer](
	[SrNo] [smallint] NOT NULL,
	[ZBM] [nvarchar](500) NULL,
	[RBM] [nvarchar](500) NULL,
	[KAM] [nvarchar](500) NULL,
	[Customer_Code] [nvarchar](500) NULL,
	[Name_of_Dr] [nvarchar](500) NULL,
	[Centre_Name] [nvarchar](500) NULL,
	[Name_of_Embryologist] [nvarchar](500) NULL,
 CONSTRAINT [PK_tbltempcustomer] PRIMARY KEY CLUSTERED 
(
	[SrNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblTempData]    Script Date: 08-04-2023 13:45:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblTempData](
	[ZBM] [nvarchar](500) NULL,
	[RBM] [nvarchar](500) NULL,
	[KAM] [nvarchar](500) NULL,
	[State] [nvarchar](500) NULL,
	[Zone] [nvarchar](500) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbltempDatav1]    Script Date: 08-04-2023 13:45:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbltempDatav1](
	[Division] [nvarchar](500) NULL,
	[_2nd_Level_Reporting_Region] [nvarchar](500) NULL,
	[_1st_Level_Reporting_Region] [nvarchar](500) NULL,
	[State] [nvarchar](500) NULL,
	[HQ_Name] [nvarchar](500) NULL,
	[Employee_Name] [nvarchar](500) NULL,
	[Designation] [nvarchar](500) NULL,
	[Customer_Code] [nvarchar](500) NULL,
	[Doctor_Name] [nvarchar](500) NULL,
	[Visit_Category] [nvarchar](500) NULL,
	[Specialty] [nvarchar](500) NULL,
	[Business_Category] [nvarchar](500) NULL,
	[MDL_Number] [nvarchar](50) NULL,
	[Qualification] [nvarchar](50) NULL,
	[Doctor_Unique_Code] [nvarchar](500) NULL,
	[Primary_Mobile] [nvarchar](500) NULL,
	[Primary_Email_Id] [nvarchar](500) NULL,
	[REGISTERED_CENTRE_NAME] [nvarchar](50) NULL,
	[Centre_address] [nvarchar](100) NULL,
	[ASSOCIATED_HOSPITAL_NAME] [nvarchar](50) NULL,
	[Address1] [nvarchar](100) NULL,
	[Address2] [nvarchar](50) NULL,
	[Local_Area] [nvarchar](50) NULL,
	[City] [nvarchar](50) NULL,
	[State1] [nvarchar](50) NULL,
	[Pin_Code] [nvarchar](500) NULL,
	[Phone] [nvarchar](500) NULL,
	[Mobile] [nvarchar](500) NULL,
	[Email] [nvarchar](50) NULL,
	[Date_of_Birth] [nvarchar](500) NULL,
	[Date_of_Anniversary] [nvarchar](500) NULL,
	[Registration_Number] [nvarchar](500) NULL,
	[Reference_Key1] [nvarchar](50) NULL,
	[Reference_Key2] [nvarchar](50) NULL,
	[Doctor_Image_URL] [nvarchar](500) NULL,
	[Created_Date] [nvarchar](500) NULL,
	[Ageing_of_Doctor_In_Days] [nvarchar](500) NULL,
	[Updated_By] [nvarchar](500) NULL,
	[Updated_Date] [nvarchar](500) NULL,
	[Mapped_Marketing_Campaigns] [nvarchar](500) NULL,
	[Chemist_Mapped] [nvarchar](500) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblTempHospital]    Script Date: 08-04-2023 13:45:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblTempHospital](
	[Name_of_Dr] [nvarchar](500) NULL,
	[Centre_Name] [nvarchar](500) NULL,
	[Name_of_Embryologist] [nvarchar](500) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TblThiyagarajan]    Script Date: 08-04-2023 13:45:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblThiyagarajan](
	[Division] [nvarchar](500) NULL,
	[_3rd_Level_Reporting_Region] [nvarchar](500) NULL,
	[_2nd_Level_Reporting_Region] [nvarchar](500) NULL,
	[_1st_Level_Reporting_Region] [nvarchar](500) NULL,
	[State] [nvarchar](500) NULL,
	[HQ_Name] [nvarchar](500) NULL,
	[HQ_Code] [nvarchar](500) NULL,
	[User_Name] [nvarchar](500) NULL,
	[Employee_Name] [nvarchar](500) NULL,
	[Employee_Number] [nvarchar](500) NULL,
	[Designation] [nvarchar](500) NULL,
	[Customer_Code] [nvarchar](500) NULL,
	[Doctor_Name] [nvarchar](500) NULL,
	[Visit_Category] [nvarchar](500) NULL,
	[Specialty] [nvarchar](500) NULL,
	[Business_Category] [nvarchar](500) NULL,
	[MDL_Number] [nvarchar](500) NULL,
	[Qualification] [nvarchar](500) NULL,
	[Doctor_Unique_Code] [nvarchar](500) NULL,
	[Primary_Mobile] [nvarchar](500) NULL,
	[Primary_Email_Id] [nvarchar](500) NULL,
	[Address1] [nvarchar](500) NULL,
	[Address2] [nvarchar](500) NULL,
	[Local_Area] [nvarchar](500) NULL,
	[City] [nvarchar](500) NULL,
	[State1] [nvarchar](500) NULL,
	[Pin_Code] [nvarchar](500) NULL,
	[Phone] [nvarchar](500) NULL,
	[Mobile] [nvarchar](500) NULL,
	[Email] [nvarchar](500) NULL,
	[Date_of_Birth] [nvarchar](500) NULL,
	[Date_of_Anniversary] [nvarchar](500) NULL,
	[Centre_name] [nvarchar](500) NULL,
	[Account_name] [nvarchar](500) NULL,
	[Registration_Number] [nvarchar](500) NULL,
	[Reference_Key1] [nvarchar](500) NULL,
	[Reference_Key2] [nvarchar](500) NULL,
	[Doctor_Image_URL] [nvarchar](500) NULL,
	[Created_Date] [nvarchar](500) NULL,
	[Ageing_of_Doctor_In_Days] [nvarchar](500) NULL,
	[Updated_By] [nvarchar](500) NULL,
	[Updated_Date] [nvarchar](500) NULL,
	[Mapped_Marketing_Campaigns] [nvarchar](500) NULL,
	[Chemist_Mapped] [nvarchar](500) NULL,
	[Chemist_MCL_Numner] [nvarchar](500) NULL,
	[Stockist_Mapped] [nvarchar](500) NULL,
	[Stockist_Ref_Key] [nvarchar](500) NULL,
	[SFC_Category] [nvarchar](500) NULL,
	[From_Place] [nvarchar](500) NULL,
	[To_Place] [nvarchar](500) NULL,
	[Travel_Mode] [nvarchar](500) NULL,
	[Locaiton_Tagged_Status] [nvarchar](500) NULL,
	[Locaiton_Tagged_Date] [nvarchar](500) NULL,
	[Locaiton_Tagged_By] [nvarchar](500) NULL,
	[Locaiton_Tagged_Designation] [nvarchar](500) NULL,
	[Tagged_Latitude] [nvarchar](500) NULL,
	[Tagged_Longitude] [nvarchar](500) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbltmpsanjay]    Script Date: 08-04-2023 13:45:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbltmpsanjay](
	[Division] [nvarchar](500) NULL,
	[_3rd_Level_Reporting_Region] [nvarchar](500) NULL,
	[_2nd_Level_Reporting_Region] [nvarchar](500) NULL,
	[_1st_Level_Reporting_Region] [nvarchar](500) NULL,
	[State] [nvarchar](500) NULL,
	[HQ_Name] [nvarchar](500) NULL,
	[HQ_Code] [nvarchar](500) NULL,
	[User_Name] [nvarchar](500) NULL,
	[Employee_Name] [nvarchar](500) NULL,
	[Employee_Number] [nvarchar](500) NULL,
	[Designation] [nvarchar](500) NULL,
	[Customer_Code] [nvarchar](500) NULL,
	[Doctor_Name] [nvarchar](500) NULL,
	[Visit_Category] [nvarchar](500) NULL,
	[Specialty] [nvarchar](500) NULL,
	[Business_Category] [nvarchar](500) NULL,
	[MDL_Number] [nvarchar](500) NULL,
	[Qualification] [nvarchar](500) NULL,
	[Doctor_Unique_Code] [nvarchar](500) NULL,
	[Primary_Mobile] [nvarchar](500) NULL,
	[Primary_Email_Id] [nvarchar](500) NULL,
	[Address1] [nvarchar](500) NULL,
	[Address2] [nvarchar](500) NULL,
	[Local_Area] [nvarchar](500) NULL,
	[City] [nvarchar](500) NULL,
	[State1] [nvarchar](500) NULL,
	[Pin_Code] [nvarchar](500) NULL,
	[Phone] [nvarchar](500) NULL,
	[Mobile] [nvarchar](500) NULL,
	[Email] [nvarchar](500) NULL,
	[Date_of_Birth] [nvarchar](500) NULL,
	[Date_of_Anniversary] [nvarchar](500) NULL,
	[CENTRE_NAME] [nvarchar](500) NULL,
	[ACCOUNT_NAME] [nvarchar](500) NULL,
	[Registration_Number] [nvarchar](500) NULL,
	[Reference_Key1] [nvarchar](500) NULL,
	[Reference_Key2] [nvarchar](500) NULL,
	[Doctor_Image_URL] [nvarchar](500) NULL,
	[Created_Date] [nvarchar](500) NULL,
	[Ageing_of_Doctor_In_Days] [nvarchar](500) NULL,
	[Updated_By] [nvarchar](500) NULL,
	[Updated_Date] [nvarchar](500) NULL,
	[Mapped_Marketing_Campaigns] [nvarchar](500) NULL,
	[Chemist_Mapped] [nvarchar](500) NULL,
	[Chemist_MCL_Numner] [nvarchar](500) NULL,
	[Stockist_Mapped] [nvarchar](500) NULL,
	[Stockist_Ref_Key] [nvarchar](500) NULL,
	[SFC_Category] [nvarchar](500) NULL,
	[From_Place] [nvarchar](500) NULL,
	[To_Place] [nvarchar](500) NULL,
	[Travel_Mode] [nvarchar](500) NULL,
	[Locaiton_Tagged_Status] [nvarchar](500) NULL,
	[Locaiton_Tagged_Date] [nvarchar](500) NULL,
	[Locaiton_Tagged_By] [nvarchar](500) NULL,
	[Locaiton_Tagged_Designation] [nvarchar](500) NULL,
	[Tagged_Latitude] [nvarchar](500) NULL,
	[Tagged_Longitude] [nvarchar](500) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblVACANT]    Script Date: 08-04-2023 13:45:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblVACANT](
	[Division] [nvarchar](500) NULL,
	[_3rd_Level_Reporting_Region] [nvarchar](500) NULL,
	[_2nd_Level_Reporting_Region] [nvarchar](500) NULL,
	[_1st_Level_Reporting_Region] [nvarchar](500) NULL,
	[State] [nvarchar](500) NULL,
	[HQ_Name] [nvarchar](500) NULL,
	[HQ_Code] [nvarchar](500) NULL,
	[User_Name] [nvarchar](500) NULL,
	[Employee_Name] [nvarchar](500) NULL,
	[Employee_Number] [nvarchar](500) NULL,
	[Designation] [nvarchar](500) NULL,
	[Customer_Code] [nvarchar](500) NULL,
	[Doctor_Name] [nvarchar](500) NULL,
	[Visit_Category] [nvarchar](500) NULL,
	[Specialty] [nvarchar](500) NULL,
	[Business_Category] [nvarchar](500) NULL,
	[MDL_Number] [nvarchar](500) NULL,
	[Qualification] [nvarchar](500) NULL,
	[Doctor_Unique_Code] [nvarchar](500) NULL,
	[Primary_Mobile] [nvarchar](500) NULL,
	[Primary_Email_Id] [nvarchar](500) NULL,
	[Address1] [nvarchar](500) NULL,
	[Address2] [nvarchar](500) NULL,
	[Local_Area] [nvarchar](500) NULL,
	[City] [nvarchar](500) NULL,
	[State1] [nvarchar](500) NULL,
	[Pin_Code] [nvarchar](500) NULL,
	[Phone] [nvarchar](500) NULL,
	[Mobile] [nvarchar](500) NULL,
	[Email] [nvarchar](500) NULL,
	[Date_of_Birth] [nvarchar](500) NULL,
	[Date_of_Anniversary] [nvarchar](500) NULL,
	[CENTRE_NAME] [nvarchar](500) NULL,
	[ACCOUNT_NAME] [nvarchar](500) NULL,
	[Registration_Number] [nvarchar](500) NULL,
	[Reference_Key1] [nvarchar](500) NULL,
	[Reference_Key2] [nvarchar](500) NULL,
	[Doctor_Image_URL] [nvarchar](500) NULL,
	[Created_Date] [nvarchar](500) NULL,
	[Ageing_of_Doctor_In_Days] [nvarchar](500) NULL,
	[Updated_By] [nvarchar](500) NULL,
	[Updated_Date] [nvarchar](500) NULL,
	[Mapped_Marketing_Campaigns] [nvarchar](500) NULL,
	[Chemist_Mapped] [nvarchar](500) NULL,
	[Chemist_MCL_Numner] [nvarchar](500) NULL,
	[Stockist_Mapped] [nvarchar](500) NULL,
	[Stockist_Ref_Key] [nvarchar](500) NULL,
	[SFC_Category] [nvarchar](500) NULL,
	[From_Place] [nvarchar](500) NULL,
	[To_Place] [nvarchar](500) NULL,
	[Travel_Mode] [nvarchar](500) NULL,
	[Locaiton_Tagged_Status] [nvarchar](500) NULL,
	[Locaiton_Tagged_Date] [nvarchar](500) NULL,
	[Locaiton_Tagged_By] [nvarchar](500) NULL,
	[Locaiton_Tagged_Designation] [nvarchar](500) NULL,
	[Tagged_Latitude] [nvarchar](500) NULL,
	[Tagged_Longitude] [nvarchar](500) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblvictor]    Script Date: 08-04-2023 13:45:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblvictor](
	[Division] [nvarchar](500) NULL,
	[_3rd_Level_Reporting_Region] [nvarchar](500) NULL,
	[_2nd_Level_Reporting_Region] [nvarchar](500) NULL,
	[_1st_Level_Reporting_Region] [nvarchar](500) NULL,
	[State] [nvarchar](500) NULL,
	[HQ_Name] [nvarchar](500) NULL,
	[HQ_Code] [nvarchar](500) NULL,
	[User_Name] [nvarchar](500) NULL,
	[Employee_Name] [nvarchar](500) NULL,
	[Employee_Number] [nvarchar](500) NULL,
	[Designation] [nvarchar](500) NULL,
	[Customer_Code] [nvarchar](500) NULL,
	[Doctor_Name] [nvarchar](500) NULL,
	[Visit_Category] [nvarchar](500) NULL,
	[Specialty] [nvarchar](500) NULL,
	[Business_Category] [nvarchar](500) NULL,
	[MDL_Number] [nvarchar](500) NULL,
	[Qualification] [nvarchar](500) NULL,
	[Doctor_Unique_Code] [nvarchar](500) NULL,
	[Primary_Mobile] [nvarchar](500) NULL,
	[Primary_Email_Id] [nvarchar](500) NULL,
	[Address1] [nvarchar](500) NULL,
	[Address2] [nvarchar](500) NULL,
	[Local_Area] [nvarchar](50) NULL,
	[City] [nvarchar](500) NULL,
	[State1] [nvarchar](500) NULL,
	[Pin_Code] [nvarchar](500) NULL,
	[Phone] [nvarchar](500) NULL,
	[Mobile] [nvarchar](500) NULL,
	[Email] [nvarchar](500) NULL,
	[Date_of_Birth] [nvarchar](500) NULL,
	[Date_of_Anniversary] [nvarchar](500) NULL,
	[Centre_Name] [nvarchar](500) NULL,
	[Account_Name] [nvarchar](500) NULL,
	[Registration_Number] [nvarchar](500) NULL,
	[Reference_Key1] [nvarchar](500) NULL,
	[Reference_Key2] [nvarchar](500) NULL,
	[Doctor_Image_URL] [nvarchar](500) NULL,
	[Created_Date] [nvarchar](500) NULL,
	[Ageing_of_Doctor_In_Days] [nvarchar](500) NULL,
	[Updated_By] [nvarchar](500) NULL,
	[Updated_Date] [nvarchar](500) NULL,
	[Mapped_Marketing_Campaigns] [nvarchar](500) NULL,
	[Chemist_Mapped] [nvarchar](500) NULL,
	[Chemist_MCL_Numner] [nvarchar](500) NULL,
	[Stockist_Mapped] [nvarchar](500) NULL,
	[Stockist_Ref_Key] [nvarchar](500) NULL,
	[SFC_Category] [nvarchar](500) NULL,
	[From_Place] [nvarchar](500) NULL,
	[To_Place] [nvarchar](500) NULL,
	[Travel_Mode] [nvarchar](500) NULL,
	[Locaiton_Tagged_Status] [nvarchar](500) NULL,
	[Locaiton_Tagged_Date] [nvarchar](500) NULL,
	[Locaiton_Tagged_By] [nvarchar](500) NULL,
	[Locaiton_Tagged_Designation] [nvarchar](500) NULL,
	[Tagged_Latitude] [nvarchar](500) NULL,
	[Tagged_Longitude] [nvarchar](500) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblVIKAS]    Script Date: 08-04-2023 13:45:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblVIKAS](
	[Division] [nvarchar](500) NULL,
	[_3rd_Level_Reporting_Region] [nvarchar](500) NULL,
	[_2nd_Level_Reporting_Region] [nvarchar](500) NULL,
	[_1st_Level_Reporting_Region] [nvarchar](500) NULL,
	[State] [nvarchar](500) NULL,
	[HQ_Name] [nvarchar](500) NULL,
	[HQ_Code] [nvarchar](500) NULL,
	[User_Name] [nvarchar](500) NULL,
	[Employee_Name] [nvarchar](500) NULL,
	[Employee_Number] [nvarchar](500) NULL,
	[Designation] [nvarchar](500) NULL,
	[Customer_Code] [nvarchar](500) NULL,
	[Doctor_Name] [nvarchar](500) NULL,
	[Visit_Category] [nvarchar](500) NULL,
	[Specialty] [nvarchar](500) NULL,
	[Business_Category] [nvarchar](500) NULL,
	[MDL_Number] [nvarchar](500) NULL,
	[Qualification] [nvarchar](500) NULL,
	[Doctor_Unique_Code] [nvarchar](500) NULL,
	[Primary_Mobile] [nvarchar](500) NULL,
	[Primary_Email_Id] [nvarchar](500) NULL,
	[Address1] [nvarchar](500) NULL,
	[Address2] [nvarchar](500) NULL,
	[Local_Area] [nvarchar](500) NULL,
	[City] [nvarchar](500) NULL,
	[State1] [nvarchar](500) NULL,
	[Pin_Code] [nvarchar](500) NULL,
	[Phone] [nvarchar](500) NULL,
	[Mobile] [nvarchar](500) NULL,
	[Email] [nvarchar](500) NULL,
	[Date_of_Birth] [nvarchar](500) NULL,
	[Date_of_Anniversary] [nvarchar](500) NULL,
	[Hospital_Name] [nvarchar](500) NULL,
	[Hospital_Classification] [nvarchar](500) NULL,
	[Registration_Number] [nvarchar](500) NULL,
	[Reference_Key1] [nvarchar](500) NULL,
	[Reference_Key2] [nvarchar](500) NULL,
	[Doctor_Image_URL] [nvarchar](500) NULL,
	[Created_Date] [nvarchar](500) NULL,
	[Ageing_of_Doctor_In_Days] [nvarchar](500) NULL,
	[Updated_By] [nvarchar](500) NULL,
	[Updated_Date] [nvarchar](500) NULL,
	[Mapped_Marketing_Campaigns] [nvarchar](500) NULL,
	[Chemist_Mapped] [nvarchar](500) NULL,
	[Chemist_MCL_Numner] [nvarchar](500) NULL,
	[Stockist_Mapped] [nvarchar](500) NULL,
	[Stockist_Ref_Key] [nvarchar](500) NULL,
	[SFC_Category] [nvarchar](500) NULL,
	[From_Place] [nvarchar](500) NULL,
	[To_Place] [nvarchar](500) NULL,
	[Travel_Mode] [nvarchar](500) NULL,
	[Locaiton_Tagged_Status] [nvarchar](500) NULL,
	[Locaiton_Tagged_Date] [nvarchar](500) NULL,
	[Locaiton_Tagged_By] [nvarchar](500) NULL,
	[Locaiton_Tagged_Designation] [nvarchar](500) NULL,
	[Tagged_Latitude] [nvarchar](500) NULL,
	[Tagged_Longitude] [nvarchar](500) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblVisitType]    Script Date: 08-04-2023 13:45:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblVisitType](
	[visitId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](10) NULL,
	[isDisabled] [int] NULL,
	[CreatedDate] [smalldatetime] NULL
) ON [PRIMARY]

GO
ALTER TABLE [BSV_IVF].[tblBrandcompetitorSKUs] ADD  DEFAULT ((0)) FOR [isDisabled]
GO
ALTER TABLE [BSV_IVF].[tblBrandcompetitorSKUs] ADD  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [BSV_IVF].[tblChainAccountType] ADD  CONSTRAINT [DEFAULT_tblChainAccountType_isApproved]  DEFAULT ((1)) FOR [isApproved]
GO
ALTER TABLE [BSV_IVF].[tblChainAccountType] ADD  DEFAULT ((0)) FOR [isDisabled]
GO
ALTER TABLE [BSV_IVF].[tblChainAccountType] ADD  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [BSV_IVF].[tblCompetitions] ADD  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [BSV_IVF].[tblCompetitions] ADD  CONSTRAINT [DEFAULT_tblCompetitions_isApproved]  DEFAULT ((1)) FOR [isApproved]
GO
ALTER TABLE [BSV_IVF].[TblContractDetails] ADD  DEFAULT ((0)) FOR [isDisabled]
GO
ALTER TABLE [BSV_IVF].[TblContractDetails] ADD  DEFAULT (getdate()) FOR [createdDate]
GO
ALTER TABLE [BSV_IVF].[tblDesignation] ADD  DEFAULT ((0)) FOR [isDisabled]
GO
ALTER TABLE [BSV_IVF].[tblDesignation] ADD  DEFAULT (getdate()) FOR [createdDate]
GO
ALTER TABLE [BSV_IVF].[tblEmployees] ADD  DEFAULT (getdate()) FOR [createdOn]
GO
ALTER TABLE [BSV_IVF].[tblEmployees] ADD  DEFAULT ((0)) FOR [isDisabled]
GO
ALTER TABLE [BSV_IVF].[tblHierarchy] ADD  DEFAULT ((0)) FOR [isDisabled]
GO
ALTER TABLE [BSV_IVF].[tblHierarchy] ADD  DEFAULT (getdate()) FOR [createdDate]
GO
ALTER TABLE [BSV_IVF].[tblHospitals] ADD  DEFAULT ((0)) FOR [isDisabled]
GO
ALTER TABLE [BSV_IVF].[tblHospitals] ADD  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [BSV_IVF].[tblLastLoginDetails] ADD  DEFAULT (getdate()) FOR [lastLoginDate]
GO
ALTER TABLE [BSV_IVF].[tblLastLoginDetails] ADD  DEFAULT ((0)) FOR [isLastLogin]
GO
ALTER TABLE [BSV_IVF].[tblSKUs] ADD  DEFAULT ((0)) FOR [isDisabled]
GO
ALTER TABLE [BSV_IVF].[tblSKUs] ADD  DEFAULT (getdate()) FOR [createdDate]
GO
ALTER TABLE [BSV_IVF].[tblState] ADD  DEFAULT ((0)) FOR [isDisabled]
GO
ALTER TABLE [BSV_IVF].[tblState] ADD  DEFAULT (getdate()) FOR [createdDate]
GO
ALTER TABLE [BSV_IVF].[tblZone] ADD  DEFAULT (getdate()) FOR [createdDate]
GO
ALTER TABLE [dbo].[tblAccount] ADD  CONSTRAINT [DEFAULT_tblAccount_createdDate]  DEFAULT (getdate()) FOR [createdDate]
GO
ALTER TABLE [dbo].[tblAccount] ADD  CONSTRAINT [DEFAULT_tblAccount_isActive]  DEFAULT ((0)) FOR [isActive]
GO
ALTER TABLE [dbo].[tblActuals] ADD  DEFAULT ((1)) FOR [contractRate]
GO
ALTER TABLE [dbo].[tblActuals] ADD  DEFAULT ((0)) FOR [isDisabled]
GO
ALTER TABLE [dbo].[tblActuals] ADD  DEFAULT (getdate()) FOR [createdDate]
GO
ALTER TABLE [dbo].[tblBrandGroups] ADD  DEFAULT ((0)) FOR [isDisabled]
GO
ALTER TABLE [dbo].[tblBrandGroups] ADD  DEFAULT (getdate()) FOR [createdDate]
GO
ALTER TABLE [dbo].[tblChainStatus] ADD  DEFAULT ((0)) FOR [isDisabled]
GO
ALTER TABLE [dbo].[tblChainStatus] ADD  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[tblCustomers] ADD  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[tblCustomers] ADD  DEFAULT ((0)) FOR [isdisabled]
GO
ALTER TABLE [dbo].[tblCustomers] ADD  CONSTRAINT [DEFAULT_tblCustomers_isApproved]  DEFAULT ((1)) FOR [isApproved]
GO
ALTER TABLE [dbo].[tblhospitalActuals] ADD  DEFAULT ((1)) FOR [isContractApplicable]
GO
ALTER TABLE [dbo].[tblhospitalActuals] ADD  DEFAULT ((0)) FOR [isDisabled]
GO
ALTER TABLE [dbo].[tblhospitalActuals] ADD  DEFAULT (getdate()) FOR [createdDate]
GO
ALTER TABLE [dbo].[tblhospitalActuals] ADD  CONSTRAINT [DEFAULT_tblhospitalActuals_isApproved]  DEFAULT ((1)) FOR [isApproved]
GO
ALTER TABLE [dbo].[TblHospitalsContracts] ADD  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[TblHospitalsContracts] ADD  CONSTRAINT [DEFAULT_TblHospitalsContracts_isApproved]  DEFAULT ((1)) FOR [isApproved]
GO
ALTER TABLE [dbo].[TblHospitalsPotentials] ADD  DEFAULT ((0)) FOR [IsActive]
GO
ALTER TABLE [dbo].[TblHospitalsPotentials] ADD  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[TblHospitalsPotentials] ADD  CONSTRAINT [DEFAULT_TblHospitalsPotentials_isApproved]  DEFAULT ((1)) FOR [isApproved]
GO
ALTER TABLE [dbo].[tblMarketInsights] ADD  CONSTRAINT [DEFAULT_tblMarketInsights_isActive]  DEFAULT ((0)) FOR [isActive]
GO
ALTER TABLE [dbo].[tblMarketInsights] ADD  CONSTRAINT [DEFAULT_tblMarketInsights_isApproved]  DEFAULT ((1)) FOR [isApproved]
GO
ALTER TABLE [dbo].[tblSkuGroup] ADD  DEFAULT ((0)) FOR [IsDisabled]
GO
ALTER TABLE [dbo].[tblSkuGroup] ADD  DEFAULT (getdate()) FOR [createdDate]
GO
ALTER TABLE [dbo].[tblSpecialtyType] ADD  DEFAULT ((0)) FOR [isDisabled]
GO
ALTER TABLE [dbo].[tblSpecialtyType] ADD  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[tblVisitType] ADD  DEFAULT ((0)) FOR [isDisabled]
GO
ALTER TABLE [dbo].[tblVisitType] ADD  DEFAULT (getdate()) FOR [CreatedDate]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'1= pending, 0=approve 2=rejected (reject comments is mandatory)' , @level0type=N'SCHEMA',@level0name=N'BSV_IVF', @level1type=N'TABLE',@level1name=N'tblCompetitions', @level2type=N'COLUMN',@level2name=N'isApproved'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Center name' , @level0type=N'SCHEMA',@level0name=N'BSV_IVF', @level1type=N'TABLE',@level1name=N'tblHospitals', @level2type=N'COLUMN',@level2name=N'hospitalName'
GO
