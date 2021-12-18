--số lượng tồn sản phẩm '000001' đang là 50
USE HT_DHCH_ONLINE
GO
DECLARE @error int

exec sp_ThemChiTietDonHang '0000000001', '000001', 20, @error = @error output
GO