--TEST CASE 01 Tranh chấp
USE HT_DHCH_ONLINE
GO
CREATE PROCEDURE sp_ThemChiTietDonHang_TC
	(@MaDH varchar(10),
	@MaSP varchar(6),
	@SoLuong int,
	@error int output)
AS
BEGIN
	EXEC('DISABLE TRIGGER slt_dathang ON CT_DonHang');
	BEGIN TRAN
		BEGIN TRY
			if not exists (select * from DonHang where @MaDH= MaDH)
				begin
					print('1')
					raiserror(N'Không tồn tại đơn hàng',15,1)
				end

			waitfor delay '00:00:10'
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
						UPDATE SanPham
						SET SLTon = @sl - @SoLuong
						WHERE MaSP = @MaSP
					end
			end
			else
			begin
				print('2')
				set @error=2
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
	EXEC('ENABLE TRIGGER slt_dathang ON CT_DonHang');
END
GO
--
--drop procedure sp_ThemChiTietDonHang_TC
--DATA TEST


TRUNCATE TABLE CT_TTDH
TRUNCATE TABLE CT_DonHang
TRUNCATE TABLE ThuNhapTX
truncate table CN_SP
DELETE FROM DonHang
DELETE FROM SanPham
DELETE FROM KhachHang
GO
INSERT KhachHang (MaKH, pword, HoTen, DiaChi, Email) VALUES 
  ('0930123450', '1234', N'Huỳnh Tuấn Khoa', N'637 Đường Số 10, Phường 10, Quận 3, TP.HCM', 'nhhanh@email.com'),
  ('0930123451', '123', N'Nguyễn Hồng Hạnh', N'366 Phan Văn Trị, Phường 5, Quận Gò Vấp, TP. HCM', 'htkhoa@email.com');
GO
INSERT INTO DonHang(MaDH, MaKH) VALUES ('0000000001','0930123450'),('0000000002','0930123451')
GO
INSERT INTO SanPham (MaSP, TenSP, GiaBan, SLTon) VALUES ('000001', N'Áo thun Mickey', 50000, 50);
GO
