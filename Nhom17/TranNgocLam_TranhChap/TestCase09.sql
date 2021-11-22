Use HT_DHCH_ONLINE
go

truncate table TinhTrangDH
truncate table ThuNhapTX
delete from TaiXe
truncate table CT_DonHang
delete from DonHang
delete from KhachHang
truncate table CN_SP
delete from SanPham
delete from ChiNhanh
truncate table HopDong
delete from DoiTac

--Insert data for TestCase09's testing
exec sp_ThemSanPham N'Sách', 170000, 10
exec sp_ThemSanPham N'Áo thun', 89000, 450
exec sp_ThemSanPham N'Bông cải', 20000, 28
exec sp_ThemSanPham N'Nước hoa', 700000, 8
exec sp_ThemSanPham N'Dép', 65000, 1100
exec sp_ThemSanPham N'Giày thể thao', 300000, 44