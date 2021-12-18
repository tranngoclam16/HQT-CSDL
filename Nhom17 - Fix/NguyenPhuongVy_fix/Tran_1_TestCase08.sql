USE HT_DHCH_ONLINE
GO
--TestCase08
--Transaction 1
declare @result int
exec sp_KiemTraSP '000001',N'Nước hoa',@result = @result output