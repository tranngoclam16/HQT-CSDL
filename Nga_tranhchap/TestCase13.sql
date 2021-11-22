--TEST CASE 13
----TEST DATA
USE HT_DHCH_ONLINE
GO
TRUNCATE TABLE TinhTrangDH
TRUNCATE TABLE CT_DonHang
TRUNCATE TABLE ThuNhapTX
DELETE FROM DonHang
DELETE FROM SanPham
DELETE FROM KhachHang
GO
INSERT KhachHang (MaKH, HoTen, SDT, DiaChi, Email) VALUES ('0930123450', N'Huỳnh Tuấn Khoa', '0930123451', N'366 Phan Văn Trị, Phường 5, Quận Gò Vấp, TP. HCM', 'htkhoa@email.com');
GO
INSERT INTO DonHang(MaDH, MaKH) VALUES ('0000000001','0930123450')
GO
INSERT INTO SanPham (MaSP, TenSP, GiaBan, SLTon) VALUES 
	('000001', N'Áo thun Mickey', 50000, 32),
	('000002', N'Áo thun Minnie', 45000, 4),
	('000003', N'Áo thun Donald', 46000, 7);