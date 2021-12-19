--TEST CASE 10
--TEST DATA
USE HT_DHCH_ONLINE
GO
TRUNCATE TABLE CT_TTDH
TRUNCATE TABLE CT_DonHang
TRUNCATE TABLE ThuNhapTX
DELETE FROM DonHang
DELETE FROM SanPham
DELETE FROM KhachHang
GO
INSERT KhachHang (MaKH, pword, HoTen, DiaChi, Email) VALUES 
	('0930123450', '123', N'Huỳnh Tuấn Khoa', N'366 Phan Văn Trị, Phường 5, Quận Gò Vấp, TP. HCM', 'htkhoa@email.com'),
	('0930123451', '123', N'Nguyễn Hồng Hạnh', N'637 Đường Số 10, Phường 10, Quận 3, TP.HCM', 'nhhanh@email.com'),
	('0930123452', '123', N'Lê Kim Hân', N'39 Trần Văn Mười, Xuân Thới Đông 2, Huyện Hóc Môn, TP.HCM', 'lkhan@email.com'),
	('0930123453', '123', N'La Bá Thuyên ', N'508 Lê Văn Sỹ, Quận 3, TP.HCM', 'lbthuyen@gmail.com');
GO
INSERT INTO DonHang(MaDH, MaKH,NgayLap) VALUES 
	('0000000001','0930123450','11/15/2021'), 
	('0000000002','0930123451','11/15/2021'), 
	('0000000003','0930123452','11/15/2021');
GO
INSERT INTO SanPham (MaSP, TenSP, GiaBan, SLTon) VALUES 
	('000001', N'Áo thun Mickey', 50000, 32),
	('000002', N'Áo thun Minnie', 45000, 4),
	('000003', N'Áo thun Donald', 46000, 7),
	('000004', N'Áo thun Goofy', 48000, 12);