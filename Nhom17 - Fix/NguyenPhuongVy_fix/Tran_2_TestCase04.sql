﻿USE HT_DHCH_ONLINE
GO
--TestCase04
--Transaction 2
begin tran
	waitfor delay '00:00:09'
	select * from SanPham 
COMMIT