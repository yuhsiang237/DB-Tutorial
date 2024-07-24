前景提要:
想查詢店家商家編號為"10050"的每個提領日提款「結算總金額」及「結算手續費」。
```
Shop - 店家資訊
Transaction - 交易資料
Settlement - 結算細項表
SettlementMaster- 結算總表 (提款時產生)
```

ER圖
<img src="https://github.com/yuhsiang237/DB-Tutorial/blob/master/No/1/Assets/ERDB.png?raw=true" width="100%"/>

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

```
1.首先先過濾出商家為10050的交易資料

SELECT [TransactionId]
      ,[TransactionStatus]
      ,[TransactionDate]
      ,[ShopNo]
FROM [SettlementDB].[dbo].[Transaction]
WHERE ShopNo = '10050'

OUTPUT:
TransactionId	TransactionStatus	TransactionDate	ShopNo
1	50	2024-07-24 00:00:00.000	10050
4	50	2024-09-10 00:00:00.000	10050


2.再來要取得總結算金額，為此必須用TransactionId關聯到Settlement表


SELECT *
FROM [SettlementDB].[dbo].[Transaction] T
JOIN Settlement S ON S.TransactionId = T.TransactionId 
WHERE T.ShopNo = '10050'


OUTPUT:
TransactionId	TransactionStatus	TransactionDate	ShopNo	SettlementId	SettlementAmount	SettlementDate	TransactionId	SettlementMasterId
1	50	2024-07-24 00:00:00.000	10050	1	500.00	2024-07-24 00:00:00.000	1	1
1	50	2024-07-24 00:00:00.000	10050	2	300.00	2024-07-24 00:00:00.000	1	1
1	50	2024-07-24 00:00:00.000	10050	3	700.00	2024-07-24 00:00:00.000	1	1
4	50	2024-09-10 00:00:00.000	10050	5	800.00	2024-09-10 00:00:00.000	4	2
4	50	2024-09-10 00:00:00.000	10050	6	500.00	2024-09-10 00:00:00.000	4	2

3.然後回到題目，要求為'每個提領日提款'，因此我們先去儲存提領日的SettlementMaster表查查
可發現每個提領日的'結算手續費'已經有了，差該日提領的'結算總金額'。

SELECT [SettlementMasterId]
      ,[FeeAmount]
      ,[SettlementMasterDate]
  FROM [SettlementDB].[dbo].[SettlementMaster]

OUTPUT:
SettlementMasterId	FeeAmount	SettlementMasterDate
1	50.00	2024-08-01 00:00:00.000
2	80.00	2024-09-15 00:00:00.000


4.由此，先把Settlement的SettlementMasterId做GroupBy，並SUM(SettlementAmount)，可取得該筆提領資料的結算總金額


SELECT S.SettlementMasterId,SUM(S.SettlementAmount) AS TotalAMT
FROM [SettlementDB].[dbo].[Transaction] T
JOIN Settlement S ON S.TransactionId = T.TransactionId 
WHERE T.ShopNo = '10050'
GROUP BY S.SettlementMasterId

OUTPUT:
SettlementMasterId	TotalAMT
1	1500.00
2	1300.00

5.再來只要把這個結果與SettlementMaster表作JOIN即可得到每日總結算金額、結算手續費的資料了

SELECT 
	   M.SettlementMasterId,
	   CONVERT(char(10),M.SettlementMasterDate,126) AS 'WithDrawDate',
	   M.FeeAmount,
	   TS.TotalAMT  	  
FROM [SettlementMaster] M
JOIN (
		SELECT S.SettlementMasterId,SUM(S.SettlementAmount) AS TotalAMT
		FROM [Transaction] T
		JOIN [Settlement] S ON S.TransactionId = T.TransactionId 
		WHERE T.ShopNo = '10050'
		GROUP BY S.SettlementMasterId
      ) TS
ON M.SettlementMasterId = TS.SettlementMasterId

OUTPUT:
SettlementMasterId	WithDrawDate	FeeAmount	TotalAMT
1	2024-08-01	50.00	1500.00
2	2024-09-15	80.00	1300.00


完成
```
