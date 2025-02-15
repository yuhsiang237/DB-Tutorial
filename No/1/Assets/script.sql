USE [SettlementDB]
GO
/****** Object:  Table [dbo].[Settlement]    Script Date: 7/25/2024 12:33:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Settlement](
	[SettlementId] [int] IDENTITY(1,1) NOT NULL,
	[SettlementAmount] [decimal](18, 2) NOT NULL,
	[SettlementDate] [datetime] NULL,
	[TransactionId] [int] NOT NULL,
	[SettlementMasterId] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SettlementMaster]    Script Date: 7/25/2024 12:33:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SettlementMaster](
	[SettlementMasterId] [int] IDENTITY(1,1) NOT NULL,
	[FeeAmount] [decimal](18, 2) NOT NULL,
	[SettlementMasterDate] [datetime] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Shop]    Script Date: 7/25/2024 12:33:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Shop](
	[ShopNo] [varchar](10) NULL,
	[ShopName] [nvarchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Transaction]    Script Date: 7/25/2024 12:33:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Transaction](
	[TransactionId] [int] IDENTITY(1,1) NOT NULL,
	[TransactionStatus] [int] NOT NULL,
	[TransactionDate] [datetime] NOT NULL,
	[ShopNo] [varchar](10) NULL
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Settlement] ON 

INSERT [dbo].[Settlement] ([SettlementId], [SettlementAmount], [SettlementDate], [TransactionId], [SettlementMasterId]) VALUES (1, CAST(500.00 AS Decimal(18, 2)), CAST(N'2024-07-24T00:00:00.000' AS DateTime), 1, 1)
INSERT [dbo].[Settlement] ([SettlementId], [SettlementAmount], [SettlementDate], [TransactionId], [SettlementMasterId]) VALUES (2, CAST(300.00 AS Decimal(18, 2)), CAST(N'2024-07-24T00:00:00.000' AS DateTime), 1, 1)
INSERT [dbo].[Settlement] ([SettlementId], [SettlementAmount], [SettlementDate], [TransactionId], [SettlementMasterId]) VALUES (3, CAST(700.00 AS Decimal(18, 2)), CAST(N'2024-07-24T00:00:00.000' AS DateTime), 1, 1)
INSERT [dbo].[Settlement] ([SettlementId], [SettlementAmount], [SettlementDate], [TransactionId], [SettlementMasterId]) VALUES (5, CAST(800.00 AS Decimal(18, 2)), CAST(N'2024-09-10T00:00:00.000' AS DateTime), 4, 2)
INSERT [dbo].[Settlement] ([SettlementId], [SettlementAmount], [SettlementDate], [TransactionId], [SettlementMasterId]) VALUES (6, CAST(500.00 AS Decimal(18, 2)), CAST(N'2024-09-10T00:00:00.000' AS DateTime), 4, 2)
SET IDENTITY_INSERT [dbo].[Settlement] OFF
GO
SET IDENTITY_INSERT [dbo].[SettlementMaster] ON 

INSERT [dbo].[SettlementMaster] ([SettlementMasterId], [FeeAmount], [SettlementMasterDate]) VALUES (1, CAST(50.00 AS Decimal(18, 2)), CAST(N'2024-08-01T00:00:00.000' AS DateTime))
INSERT [dbo].[SettlementMaster] ([SettlementMasterId], [FeeAmount], [SettlementMasterDate]) VALUES (2, CAST(80.00 AS Decimal(18, 2)), CAST(N'2024-09-15T00:00:00.000' AS DateTime))
SET IDENTITY_INSERT [dbo].[SettlementMaster] OFF
GO
INSERT [dbo].[Shop] ([ShopNo], [ShopName]) VALUES (N'10050', N'統一超商')
GO
SET IDENTITY_INSERT [dbo].[Transaction] ON 

INSERT [dbo].[Transaction] ([TransactionId], [TransactionStatus], [TransactionDate], [ShopNo]) VALUES (1, 50, CAST(N'2024-07-24T00:00:00.000' AS DateTime), N'10050')
INSERT [dbo].[Transaction] ([TransactionId], [TransactionStatus], [TransactionDate], [ShopNo]) VALUES (4, 50, CAST(N'2024-09-10T00:00:00.000' AS DateTime), N'10050')
SET IDENTITY_INSERT [dbo].[Transaction] OFF
GO
