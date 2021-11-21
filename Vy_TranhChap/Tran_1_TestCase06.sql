USE HT_DHCH_ONLINE
GO
--TestCase06
--Transaction 1
Begin tran
waitfor delay '00:00:08'
select * from SanPham with (nolock)
COMMIT