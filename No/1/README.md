前景提要:
想查詢店家商家編號為"10050"的每個提領日提款「結算總金額」及「結算手續費」。
```
Shop - 店家資訊
Transaction - 交易資料
Settlement - 結算細項表
SettlementMaster- 結算總表 (提款時產生)
```

DBScript.sql
```
CREATE TABLE [dbo].[Settlement](
	[SettlementId] [int] IDENTITY(1,1) NOT NULL,
	[SettlementAmount] [decimal](18, 2) NOT NULL,
	[SettlementDate] [datetime] NULL,
	[TransactionId] [int] NOT NULL,
	[SettlementMasterId] [int] NOT NULL
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[SettlementMaster](
	[SettlementMasterId] [int] IDENTITY(1,1) NOT NULL,
	[FeeAmount] [decimal](18, 2) NOT NULL,
	[SettlementMasterDate] [datetime] NOT NULL
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[Shop](
	[ShopNo] [varchar](10) NULL,
	[ShopName] [nvarchar](50) NULL
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[Transaction](
	[TransactionId] [int] IDENTITY(1,1) NOT NULL,
	[TransactionStatus] [int] NOT NULL,
	[TransactionDate] [datetime] NOT NULL,
	[ShopNo] [varchar](10) NULL
) ON [PRIMARY]
GO

INSERT [dbo].[Settlement] ([SettlementId], [SettlementAmount], [SettlementDate], [TransactionId], [SettlementMasterId]) VALUES (1, CAST(500.00 AS Decimal(18, 2)), CAST(N'2024-07-24T00:00:00.000' AS DateTime), 1, 1)
INSERT [dbo].[Settlement] ([SettlementId], [SettlementAmount], [SettlementDate], [TransactionId], [SettlementMasterId]) VALUES (2, CAST(300.00 AS Decimal(18, 2)), CAST(N'2024-07-24T00:00:00.000' AS DateTime), 1, 1)
INSERT [dbo].[Settlement] ([SettlementId], [SettlementAmount], [SettlementDate], [TransactionId], [SettlementMasterId]) VALUES (3, CAST(700.00 AS Decimal(18, 2)), CAST(N'2024-07-24T00:00:00.000' AS DateTime), 1, 1)
INSERT [dbo].[Settlement] ([SettlementId], [SettlementAmount], [SettlementDate], [TransactionId], [SettlementMasterId]) VALUES (5, CAST(800.00 AS Decimal(18, 2)), CAST(N'2024-09-10T00:00:00.000' AS DateTime), 4, 2)
INSERT [dbo].[Settlement] ([SettlementId], [SettlementAmount], [SettlementDate], [TransactionId], [SettlementMasterId]) VALUES (6, CAST(500.00 AS Decimal(18, 2)), CAST(N'2024-09-10T00:00:00.000' AS DateTime), 4, 2)

INSERT [dbo].[SettlementMaster] ([SettlementMasterId], [FeeAmount], [SettlementMasterDate]) VALUES (1, CAST(50.00 AS Decimal(18, 2)), CAST(N'2024-08-01T00:00:00.000' AS DateTime))
INSERT [dbo].[SettlementMaster] ([SettlementMasterId], [FeeAmount], [SettlementMasterDate]) VALUES (2, CAST(80.00 AS Decimal(18, 2)), CAST(N'2024-09-15T00:00:00.000' AS DateTime))

INSERT [dbo].[Shop] ([ShopNo], [ShopName]) VALUES (N'10050', N'統一超商')

INSERT [dbo].[Transaction] ([TransactionId], [TransactionStatus], [TransactionDate], [ShopNo]) VALUES (1, 50, CAST(N'2024-07-24T00:00:00.000' AS DateTime), N'10050')
INSERT [dbo].[Transaction] ([TransactionId], [TransactionStatus], [TransactionDate], [ShopNo]) VALUES (4, 50, CAST(N'2024-09-10T00:00:00.000' AS DateTime), N'10050')
```
