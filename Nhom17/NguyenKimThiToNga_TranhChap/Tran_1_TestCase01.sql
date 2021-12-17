--số lượng tồn sản phẩm '000001' đang là 50
USE HT_DHCH_ONLINE
GO
SELECT * FROM SanPham
GO
DECLARE @error int

exec sp_ThemChiTietDonHang_TC '0000000001', '000001', 20, @error = @error output
GO
SELECT * FROM SanPham
GO