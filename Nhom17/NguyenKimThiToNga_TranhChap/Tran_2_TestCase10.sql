DECLARE @error int

exec sp_ThemChiTietDonHang '0000000001', '000001', 25, @error = @error output
GO
