USE HT_DHCH_ONLINE
GO
--TestCase05
--Transaction 2
begin tran
	waitfor delay '00:00:09'
	select * from SanPham with (nolock)
COMMIT