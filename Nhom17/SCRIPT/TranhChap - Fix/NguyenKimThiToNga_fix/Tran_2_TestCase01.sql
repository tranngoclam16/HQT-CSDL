--số lượng tồn sản phẩm '000001' đang là 50
USE HT_DHCH_ONLINE
GO
DECLARE @error int
exec sp_ThemChiTietDonHang '0000000002', '000001', 15, @error = @error output
GO
----sau khi chạy tran 2 sẽ in ra số lượng tồn đáng ra nên có trong SanPham
----số lượng tồn được cập nhật trong SanPham
SELECT * FROM CT_DonHang