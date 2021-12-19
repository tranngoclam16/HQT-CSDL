USE HT_DHCH_ONLINE
GO
--TestCase08
--Transaction 2
EXEC sp_CapNhatSanPham '000001',N'Áo hai dây',300,3
SELECT * from SanPham