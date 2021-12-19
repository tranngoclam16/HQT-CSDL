USE HT_DHCH_ONLINE
GO
--TestCase8
--Transaction 1
declare @result int
exec sp_KiemTraSP_TC '000001',N'Nước hoa',@result = @result output