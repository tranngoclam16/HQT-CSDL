﻿USE HT_DHCH_ONLINE
Go

begin tran
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
select * from CT_TTDH where MaDH='0000000001'
commit tran


