--TEST CASE 10
create procedure sp_KiemTraSLTon_TC
	@slt int,
	@Tong int output
as
begin
	--set transaction isolation level serializable
	begin tran
		begin try
			select @Tong= count(MaSP) from SanPham WITH (TABLOCK, HOLDLOCK) where SanPham.SLTon<@slt
			waitfor delay '00:00:10'
			SELECT ROW_NUMBER() OVER (ORDER BY MaSP) AS ROWNUMBER, MaSP,TenSP,GiaBan,SLTon FROM SanPham WHERE SLTon<@slt
			
		commit tran
		end try
	BEGIN CATCH
		IF @@trancount>0
				BEGIN	
					print(N'Lỗi')
					ROLLBACK TRANSACTION 
				END
		END CATCH
end
go
--
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

			declare @sl int
			set @sl=(select SLTon from SanPham where MaSP=@MaSP)
			print(@sl)
			if (@sl-@SoLuong>=0)
			begin
				if EXISTS (select * from CT_DonHang where MaDH = @MaDH and MaSP = @MaSP)
					begin
						update CT_DonHang
						set SoLuong = (SoLuong + @SoLuong)
						where MaDH = @MaDH and MaSP = @MaSP
					end
				else
					begin
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
--DROP PROCEDURE sp_ThemChiTietDonHang_TC
--TEST DATA
TRUNCATE TABLE CT_TTDH
TRUNCATE TABLE CT_DonHang
TRUNCATE TABLE ThuNhapTX
DELETE FROM DonHang
DELETE FROM SanPham
DELETE FROM KhachHang
GO
INSERT KhachHang (MaKH, pword, HoTen, DiaChi, Email) VALUES ('0930123450', '12345', N'Huỳnh Tuấn Khoa', N'366 Phan Văn Trị, Phường 5, Quận Gò Vấp, TP. HCM', 'htkhoa@email.com');
GO
INSERT INTO DonHang(MaDH, MaKH) VALUES ('0000000001','0930123450')
GO
INSERT INTO SanPham (MaSP, TenSP, GiaBan, SLTon) VALUES 
	('000001', N'Áo thun Mickey', 50000, 32),
	('000002', N'Áo thun Minnie', 45000, 4),
	('000003', N'Áo thun Donald', 46000, 7);