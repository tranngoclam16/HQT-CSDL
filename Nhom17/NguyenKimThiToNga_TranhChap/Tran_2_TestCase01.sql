--số lượng tồn sản phẩm '000001' đang là 50
USE HT_DHCH_ONLINE
GO
--DISABLE TRIGGER slt_dathang ON CT_DonHang
GO
DECLARE @error int
exec sp_ThemChiTietDonHang_TC '0000000002', '000001', 15, @error = @error output
GO
--ENABLE TRIGGER slt_dathang ON CT_DonHang
GO
--sau khi chạy tran 2 sẽ in ra số lượng tồn đáng ra nên có trong SanPham
--số lượng tồn được cập nhật trong SanPham
SELECT * FROM SanPham
