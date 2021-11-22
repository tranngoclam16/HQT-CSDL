--số lượng tồn sản phẩm '000001' đang là 50
USE HT_DHCH_ONLINE
GO
DISABLE TRIGGER slt_dathang ON CT_DonHang
GO
exec sp_ThemChiTietDonHang_TC '0000000001', '000001', 20
GO
ENABLE TRIGGER slt_dathang ON CT_DonHang
GO