--PROCEDURE THÊM CHI TIẾT ĐƠN HÀNG
USE HT_DHCH_ONLINE
GO
CREATE PROCEDURE sp_ThemChiTietDonHang
	(@MaDH varchar(10),
	@MaSP varchar(6),
	@TenSP nvarchar(50),
	@SoLuong int)
AS
BEGIN 
	BEGIN TRAN
		BEGIN TRY
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
					waitfor delay '00:00:02'
					INSERT INTO CT_DonHang(MaDH,MaSP,SoLuong) VALUES(@MaDH,@MaSP,@SoLuong)	
			end
			else
			BEGIN
				print('2')
				raiserror(N'Số lượng đặt vượt quá số lượng trong kho',15,1)
				rollback TRAN
			END
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
--drop procedure sp_ThemChiTietDonHang