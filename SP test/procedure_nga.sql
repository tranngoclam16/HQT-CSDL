--PROCEDURE THÊM CHI TIẾT ĐƠN HÀNG
CREATE PROCEDURE ctdh_ThemChiTietDonHang
	(@MaDH varchar(10),
	@TenSP nvarchar(50),
	@SoLuong int)
AS
BEGIN 
	BEGIN TRAN
		BEGIN TRY
			waitfor delay '00:00:05'
			declare @MaSP varchar(6)
			set @MaSP = (SELECT MaSP from SanPham where TenSP = @TenSP)
			if NOT EXISTS (select * from DonHang where MaDH = @MaDH)
				begin
				print(N'Không tồn tại đơn hàng')
				commit tran
				end
			if EXISTS (select * from CT_DonHang where MaDH = @MaDH and MaSP = @MaSP)
				begin
					update CT_DonHang
					set SoLuong = (SoLuong + @SoLuong)
					where MaDH = @MaDH and MaSP = @MaSP
				end
			else
				INSERT INTO CT_DonHang(MaDH,MaSP,SoLuong) VALUES(@MaDH,@MaSP,@SoLuong)
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
drop procedure ctdh_ThemChiTietDonHang
--
--exec ctdh_ThemChiTietDonHang 'DH00001', N'Vina', 5
--GO
----
----
----PROCEDURE XÓA CHI TIẾT ĐƠN HÀNG
--CREATE PROCEDURE ctdh_XoaChiTietDonHang(@MaDH varchar(10), @MaSP varchar(6))
--AS
--BEGIN
-- DELETE FROM CT_DonHang
-- WHERE MaDH = @MaDH and MaSP = @MaSP
--END
--GO
----
--exec ctdh_XoaChiTietDonHang 'DH00001','SP002'
--GO
----PROCEDURE XÓA ĐƠN HÀNG
--CREATE PROCEDURE dh_XoaDonHang
--	(@MaDH varchar(10))
--AS
--BEGIN
-- DELETE FROM CT_DonHang WHERE MaDH = @MaDH
-- DELETE FROM DonHang
-- WHERE MaDH = @MaDH
--END

--drop procedure dh_XoaDonHang

--exec dh_XoaDonHang 'DH00001'
