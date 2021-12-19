use HT_DHCH_ONLINE
GO
DECLARE @error int

exec sp_ThemChiTietDonHang_TC '0000000001', '000001', 25, @error = @error output
GO