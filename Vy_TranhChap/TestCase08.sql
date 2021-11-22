--TestCase08
--Transaction 2
USE HT_DHCH_ONLINE
GO
CREATE PROCEDURE sp_ThemChiTietDonHang_TC
	(@MaDH varchar(10),
	@MaSP varchar(6),
	@SoLuong int)
AS
BEGIN 
	BEGIN TRAN
		BEGIN TRY
			if not exists (select * from DonHang where @MaDH= MaDH)
				begin
					print('1')
					raiserror(N'Không tồn tại đơn hàng',15,1)
				end

			waitfor delay '00:00:05'
			declare @sl int
			set @sl=(select SLTon from SanPham where MaSP=@MaSP)
			print(@sl)
			if (@sl-@SoLuong>=0)
			begin
				if EXISTS (select * from CT_DonHang where MaDH = @MaDH and MaSP = @MaSP)
					begin
						waitfor delay '00:00:02'
						update CT_DonHang
						set SoLuong = (SoLuong + @SoLuong)
						where MaDH = @MaDH and MaSP = @MaSP
					end
				else
					begin
						waitfor delay '00:00:02'
						INSERT INTO CT_DonHang(MaDH,MaSP,SoLuong) VALUES(@MaDH,@MaSP,@SoLuong)	
					end
			end
			else
			begin
				print('2')
				raiserror(N'Số lượng đặt vượt quá số lượng trong kho',15,1)
			end
		COMMIT TRAN
		END TRY
		BEGIN CATCH
			IF @@trancount>0
				BEGIN	
					print(N'Lỗi')
					ROLLBACK TRANSACTION 
				END
		END CATCH
END
GO
--
--drop procedure sp_ThemChiTietDonHang_TC
--=========================================
--DATATEST
TRUNCATE TABLE TinhTrangDH
TRUNCATE TABLE CT_DonHang
TRUNCATE TABLE ThuNhapTX
DELETE FROM DonHang
DELETE FROM SanPham
DELETE FROM KhachHang
GO
INSERT KhachHang (MaKH, HoTen, SDT, DiaChi, Email) VALUES ('0930123450', N'Huỳnh Tuấn Khoa', '0930123451', N'366 Phan Văn Trị, Phường 5, Quận Gò Vấp, TP. HCM', 'htkhoa@email.com');
GO
INSERT INTO SanPham (MaSP, TenSP, GiaBan, SLTon) VALUES 
	('000001', N'Áo thun Mickey', 50000, 32),
	('000002', N'Áo thun Minnie', 45000, 4),
	('000003', N'Áo thun Donald', 46000, 7);
GO
INSERT INTO DonHang(MaDH, MaKH) VALUES ('0000000001','0930123450')
GO
INSERT INTO CT_DonHang(MaDH, MaSP, SoLuong) VALUES ('0000000001','000002',1)
GO
