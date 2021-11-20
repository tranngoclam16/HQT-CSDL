-- TẠO TÀI KHOẢN ĐỐI TÁC, TÀI XẾ, KHÁCH HÀNG, NHÂN VIÊN
--
CREATE PROC sp_CreateAccount_DT
	--@MaDT varchar(10),
	@MSThue varchar(10),
	@TenDT nvarchar(100),
	@TenNgDaiDien nvarchar(100),
	@ThanhPho nvarchar(50),
	@Quan nvarchar(30),
	@SoChiNhanh int,
	@SoLuongDH int,
	@LoaiHang nvarchar(100),
	@DiaChi nvarchar(200),
	@SDT varchar(10),
	@Email varchar(30),
	@PASS varchar(50),
	@ROLE varchar(50),
	@err int output
AS
BEGIN
	BEGIN TRANSACTION
		BEGIN TRY
			declare @ma_count bigint,@MaDT varchar(10)
		
			set @MaDT=(select TOP 1 (MaDT) from DoiTac  order by MaDT DESC)
			
			if (isnull(@MaDT,'false')<>'false')
			begin
				set @ma_count=cast (@MaDT as bigint)+1
			end
			else
			begin
				set @ma_count=1 
			end
			set @MaDT = RIGHT('000000000'+CAST(@ma_count AS VARCHAR(10)), 10)
			
			print @MaDT

			DECLARE @SQL NVARCHAR(4000);
			DECLARE @LGNAME VARCHAR(10)=@MaDT;
			SET @SQL=('CREATE LOGIN ' + QUOTENAME(@LGNAME) + ' WITH PASSWORD = ' + quotename(@PASS, '''')+', DEFAULT_DATABASE=[HT_DHCH_ONLINE], CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF;')
			EXEC(@SQL);

			SET @SQL=('CREATE USER ' + QUOTENAME(@LGNAME) + ' FOR LOGIN ' + quotename(@LGNAME)+' WITH DEFAULT_SCHEMA=[dbo];')
			EXEC(@SQL)

			SET @SQL='ALTER ROLE ' + QUOTENAME(@ROLE)+ ' ADD MEMBER '+QUOTENAME(@LGNAME);
			EXECUTE sp_executesql @SQL;

			INSERT INTO DoiTac VALUES (@MaDT, @MSThue, @TenDT, @TenNgDaiDien, @ThanhPho, @Quan, @SoChiNhanh, @SoLuongDH, @LoaiHang, @DiaChi, @SDT, @Email); 
		COMMIT TRANSACTION
		END TRY
		BEGIN CATCH
		IF @@trancount>0
			BEGIN	
				set @err=@@trancount
				print('loi')
				ROLLBACK TRANSACTION 
			END
	END CATCH
END;
GO
--DROP PROC sp_CreateAccount_DT

CREATE PROC sp_CreateAccount_TX
	@CMND varchar(12),
	@HoTen nvarchar(100),
	@SDT varchar (10),
	@DiaChi nvarchar(100),
	@BienSoXe nvarchar(12),
	@KVHoatDong nvarchar(30),
	@Email varchar(30),
	@STK varchar(15),
	@NganHang nvarchar(30),
	@ChiNhanh nvarchar(30),
	@PASS varchar(50),
	@ROLE varchar(50),
	@err int output
AS
BEGIN
	BEGIN TRANSACTION
		BEGIN TRY
			DECLARE @SQL NVARCHAR(4000);
			DECLARE @LGNAME VARCHAR(10)=@CMND;
			SET @SQL=('CREATE LOGIN ' + QUOTENAME(@LGNAME) + ' WITH PASSWORD = ' + quotename(@PASS, '''')+', DEFAULT_DATABASE=[HT_DHCH_ONLINE], CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF;')
			EXEC(@SQL);

			SET @SQL=('CREATE USER ' + QUOTENAME(@LGNAME) + ' FOR LOGIN ' + quotename(@LGNAME)+' WITH DEFAULT_SCHEMA=[dbo];')
			EXEC(@SQL)

			SET @SQL='ALTER ROLE ' + QUOTENAME(@ROLE)+ ' ADD MEMBER '+QUOTENAME(@LGNAME);
			EXECUTE sp_executesql @SQL;

			INSERT INTO TaiXe VALUES (@CMND, @HoTen, @SDT, @DiaChi, @BienSoXe, @KVHoatDong, @Email, @STK, @NganHang, @ChiNhanh); 
		COMMIT TRANSACTION
		END TRY
		BEGIN CATCH
		IF @@trancount>0
			BEGIN	
				set @err=@@trancount
				print('loi')
				ROLLBACK TRANSACTION 
			END
	END CATCH
END;
GO
--DROP PROC sp_CreateAccount_TX

CREATE PROC sp_CreateAccount_KH
	@MaKH varchar(10),
	@HoTen nvarchar(50),
	@SDT varchar (10),
	@DiaChi nvarchar(100),
	@Email varchar(30),
	@PASS varchar(50),
	@ROLE varchar(50),
	@err int output
AS
BEGIN
	BEGIN TRANSACTION
		BEGIN TRY
			DECLARE @SQL NVARCHAR(4000);
			DECLARE @LGNAME VARCHAR(10)=@MaKH;
			SET @SQL=('CREATE LOGIN ' + QUOTENAME(@LGNAME) + ' WITH PASSWORD = ' + quotename(@PASS, '''')+', DEFAULT_DATABASE=[HT_DHCH_ONLINE], CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF;')
			EXEC(@SQL);

			SET @SQL=('CREATE USER ' + QUOTENAME(@LGNAME) + ' FOR LOGIN ' + quotename(@LGNAME)+' WITH DEFAULT_SCHEMA=[dbo];')
			EXEC(@SQL)

			SET @SQL='ALTER ROLE ' + QUOTENAME(@ROLE)+ ' ADD MEMBER '+QUOTENAME(@LGNAME);
			EXECUTE sp_executesql @SQL;

			INSERT INTO KhachHang VALUES (@MaKH, @HoTen, @SDT, @DiaChi, @Email); 
		COMMIT TRANSACTION
		END TRY
		BEGIN CATCH
		IF @@trancount>0
			BEGIN	
				set @err=@@trancount
				print('loi')
				ROLLBACK TRANSACTION 
			END
	END CATCH
END;
GO
--DROP PROC sp_CreateAccount_KH

CREATE PROC sp_CreateAccount_NV
	@MaNV varchar(10),
	@PASS varchar(50),
	@ROLE varchar(50),
	@err int output
AS
BEGIN
	BEGIN TRANSACTION
		BEGIN TRY
			DECLARE @SQL NVARCHAR(4000);
			DECLARE @LGNAME VARCHAR(13)='NV'+@MaNV;
			SET @SQL=('CREATE LOGIN ' + QUOTENAME(@LGNAME) + ' WITH PASSWORD = ' + quotename(@PASS, '''')+', DEFAULT_DATABASE=[HT_DHCH_ONLINE], CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF;')
			EXEC(@SQL);

			SET @SQL=('CREATE USER ' + QUOTENAME(@LGNAME) + ' FOR LOGIN ' + quotename(@LGNAME)+' WITH DEFAULT_SCHEMA=[dbo];')
			EXEC(@SQL)

			SET @SQL='ALTER ROLE ' + QUOTENAME(@ROLE)+ ' ADD MEMBER '+QUOTENAME(@LGNAME);
			EXECUTE sp_executesql @SQL;

		COMMIT TRANSACTION
		END TRY
		BEGIN CATCH
		IF @@trancount>0
			BEGIN	
				set @err=@@trancount
				print('loi')
				ROLLBACK TRANSACTION 
			END
	END CATCH
END;
GO
--DROP PROC sp_CreateAccount_NV
--
--CẬP NHẬT TÀI KHOẢN KHÁCH HÀNG
--
create procedure sp_CapNhatTKKhachHang
	(@MaKH varchar(10), 
	@HoTen nvarchar(100),
	@SDT varchar(10),
	@DiaChi nvarchar(100),
	@Email varchar(30))
as
begin
	begin tran
		begin try
			if (@HoTen != '')
			begin
				update KhachHang
				set HoTen = @HoTen
				where MaKH = @MaKH
			end
			if (@SDT != '')
			begin
				update KhachHang
				set SDT = @SDT
				where MaKH = @MaKH
			end
			if (@DiaChi != '')
			begin
				update KhachHang
				set DiaChi = @DiaChi
				where MaKH = @MaKH
			end
			if (@Email != '')
			begin
				update KhachHang
				set Email = @Email
				where MaKH = @MaKH
			end
		commit tran
		end try
		begin catch
			IF @@trancount>0
				BEGIN	
					print(N'Lỗi')
					ROLLBACK TRANSACTION 
				END
		end catch
END
GO
--DROP procedure sp_CapNhatTKKhachHang
--=======================================================================================================================
--THÊM ĐƠN HÀNG
--
CREATE PROCEDURE sp_ThemDonHang
	@MaKH varchar(10),
	@DiaChi nvarchar(30),
	@Phuong nvarchar(30),
	@Quan nvarchar(30),
	@Tinh nvarchar(30),
	@TenNguoiNhan nvarchar(100),
	@SDT varchar(10),
	@NgayLap datetime
AS
BEGIN
	BEGIN TRAN
		BEGIN TRY
			declare @ma_count bigint,@MaDH varchar(10)
		
			set @MaDH=(select TOP 1 (MaDH) from DonHang  order by MaDH DESC)
			
			if (isnull(@MaDH,'false')<>'false')
			begin
				set @ma_count=cast (@MaDH as bigint)+1
			end
			else
			begin
				set @ma_count=1 
			end
			set @MaDH = RIGHT('000000000'+CAST(@ma_count AS VARCHAR(10)), 10)

			print @MaDH
			INSERT INTO DonHang (MaDH, MaKH, DiaChi, Phuong, Quan,Tinh, TenNguoiNhan, SDT, NgayLap) 
			VALUES (@MaDH, @MaKH, @DiaChi, @Phuong, @Quan,@Tinh,  @TenNguoiNhan, @SDT, @NgayLap)
		COMMIT TRAN
		END TRY
		BEGIN CATCH
			IF @@trancount>0
				BEGIN	
					print('loi')
					ROLLBACK TRANSACTION 
				END
		END CATCH
END
GO
--DROP PROCEDURE sp_ThemDonHang
--
--THÊM CHI NHÁNH
--

--
--THÊM HỢP ĐỒNG
--
CREATE PROCEDURE sp_ThemHopDong
	@MSThue varchar(10),
	@TenNgDaiDien nvarchar (100),
	@SoChiNhanh int,
	@TGHieuLuc date,
	@HoaHong int
AS
BEGIN
	BEGIN TRAN
		BEGIN TRY
			declare @ma_count bigint,@MaHD varchar(10)
		
			set @MaHD=(select TOP 1 (MaHD) from HopDong  order by MaHD DESC)
			
			if (isnull(@MaHD,'false')<>'false')
			begin
				set @ma_count=cast (@MaHD as bigint)+1
			end
			else
			begin
				set @ma_count=1 
			end
			set @MaHD = RIGHT('000000000'+CAST(@ma_count AS VARCHAR(10)), 10)

			print @MaHD

			INSERT INTO HopDong values (@MaHD, @MSThue, @TenNgDaiDien, @SoChiNhanh, @TGHieuLuc, @HoaHong)
		COMMIT TRAN
		END TRY
		BEGIN CATCH
			IF @@trancount>0
				BEGIN	
					print('loi')
					ROLLBACK TRANSACTION 
				END
		END CATCH
END
GO
--DROP PROCEDURE sp_ThemHopDong
--
--THÊM SẢN PHẨM
--
CREATE PROCEDURE sp_ThemSanPham
	@TenSP nvarchar(50),
	@GiaBan int,
	@SLTon int
AS
BEGIN
	BEGIN TRAN
		BEGIN TRY
			declare @ma_count bigint,@MaSP varchar(6)
		
			set @MaSP=(select TOP 1 (MaSP) from SanPham  order by MaSP DESC)
			
			if (isnull(@MaSP,'false')<>'false')
			begin
				set @ma_count=cast (@MaSP as bigint)+1
			end
			else
			begin
				set @ma_count=1 
			end
			set @MaSP = RIGHT('00000'+CAST(@ma_count AS VARCHAR(6)), 6)
			
			print @MaSP

			INSERT INTO SanPham values (@MaSP, @TenSP, @GiaBan, @SLTon)

			if (@SLTon <0)
				begin
					print('1')
					raiserror(N'không được nhỏ hơn 0',15,1)
				end

		COMMIT TRAN
		END TRY
		BEGIN CATCH
			IF @@trancount>0
				BEGIN	
					print('loi')
					ROLLBACK TRANSACTION 
				END
		END CATCH
END
GO
--DROP PROCEDURE sp_ThemSanPham
--
--THÊM CHI TIẾT ĐƠN HÀNG 
--
CREATE PROCEDURE sp_ThemChiTietDonHang
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
--DROP PROCEDURE sp_ThemChiTietDonHang
--
--TÀI XẾ NHẬN ĐƠN HÀNG -> THÊM VÀO THU NHẬP TÀI XẾ
--
CREATE PROCEDURE sp_TaiXeNhanDonHang
            (@MaTX VARCHAR(12),
            @MaDH VARCHAR(10))
AS
BEGIN
  BEGIN TRAN
    BEGIN TRY
      IF (SELECT MaTT FROM TinhTrangDH ttd1 
          WHERE ttd1.MaDH = @MaDH 
            AND ttd1.NgayCapNhat > ALL(SELECT ttd2.NgayCapNhat 
                                      FROM TinhTrangDH ttd2 WHERE ttd2.MaDH = ttd1.MaDH)) <> 3
        BEGIN
          PRINT('1')
          RAISERROR(N'Đơn hàng đang không được chờ vận chuyển',15,1)
        END
      ELSE
        BEGIN
        DECLARE @PhiVanChuyen int
        SET @PhiVanChuyen = (SELECT PhiVanChuyen FROM DonHang WHERE MaDH = @MaDH)
        INSERT INTO ThuNhapTX VALUES (@MaTX, @MaDH, @PhiVanChuyen)

        INSERT INTO TinhTrangDH VALUES (GETDATE(), @MaDH, 4)
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
--DROP PROCEDURE sp_TaiXeNhanDonHang
--=======================================================================================================================
--CẬP NHẬT THÔNG TIN SẢN PHẨM
--
CREATE PROCEDURE sp_CapNhatSanPham
	(@MaSP varchar(6),
	@TenSP nvarchar(50),
	@GiaBan int,
	@SLTon int)
AS
BEGIN 
	BEGIN TRAN
		BEGIN TRY
			if not exists (select * from SanPham where @MaSP= MaSP)
				begin
					print('1')
					raiserror(N'Không tồn tại sản phẩm',15,1)
				end

			update SanPham
			set TenSP= @TenSP, GiaBan= @GiaBan, SLTon= @SLTon
			where MaSP= @MaSP
			
			select * from SanPham

			if (@SLTon <0)
				begin
					print('2')
					raiserror(N'không được nhỏ hơn 0',15,1)
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
--DROP PROCEDURE sp_CapNhatSanPham
--
--CẬP NHẬT CHI TIẾT ĐƠN HÀNG
--
CREATE PROCEDURE sp_ThemChiTietDonHang
	(@MaDH varchar(10),
	@MaSP varchar(6),
	@SoLuong int)
AS
BEGIN 
	BEGIN TRAN
		BEGIN TRY
			if not exists (select * from CT_DonHang where @MaDH= MaDH AND @MaSP = MaSP)
				begin
					print('1')
					raiserror(N'Không tồn tại chi tiết đơn hàng',15,1)
				end
			declare @sl int, @sld int
			set @sld=(select SoLuong from CT_DonHang where @MaDH = MaDH and @MaSP=MaSP)
			set @sl=(select SLTon from SanPham where MaSP=@MaSP)
			print(@sl)
			if (@sl-(@SoLuong-@sld)>=0)
				begin
				update CT_DonHang
				set SoLuong = @SoLuong
				where MaDH = @MaDH and MaSP = @MaSP
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
--DROP PROCEDURE sp_CapNhatChiTietDonHang
--
--CẬP NHẬT TÌNH TRẠNG ĐƠN HÀNG
--
CREATE PROCEDURE sp_CapNhatTinhTrangDonHang
	(@MaDH varchar(10), @MaTT int)
as
begin
	begin tran
		begin try
			insert into TinhTrangDH
			values (GETDATE(), @MaDH, @MaTT)
			ROLLBACK TRANSACTION 
		end try
		begin catch
			IF @@trancount>0
				BEGIN	
					print(N'Lỗi')
					ROLLBACK TRANSACTION 
				END
		end catch
END
GO
--DROP procedure sp_CapNhatTinhTrangDonHang
--=======================================================================================================================
--XÓA ĐƠN HÀNG
--
CREATE PROCEDURE dh_XoaDonHang
	(@MaDH varchar(10))
AS
BEGIN
	BEGIN TRAN
		BEGIN TRY
			IF NOT EXISTS (SELECT * FROM DonHang WHERE MaDH = @MaDH)
				begin
				print('2')
				raiserror(N'Không tồn tại đơn hàng',15,1)
				end
			ELSE
				BEGIN
				DELETE FROM CT_DonHang WHERE MaDH = @MaDH
				DELETE FROM DonHang WHERE MaDH = @MaDH
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
--DROP PROCEDURE dh_XoaDonHang
--
--XÓA CHI TIẾT ĐƠN HÀNG
CREATE PROCEDURE ctdh_XoaChiTietDonHang(@MaDH varchar(10), @MaSP varchar(6))
AS
BEGIN
	begin tran
		begin try
			if NOT EXISTS (Select * from CT_DonHang where MaDH = @MaDH and MaSP = @MaSP)
				print(N'Không tồn tại chi tiết đơn hàng')
			else
				DELETE FROM CT_DonHang WHERE MaDH = @MaDH and MaSP = @MaSP
		commit tran
		end try
		begin catch
			if @@TRANCOUNT>0
				begin
				print(N'Lỗi')
				rollback tran
				end
		end catch
END
GO
--DROP PROCEDURE ctdh_XoaChiTietDonHang
--
--TÀI XẾ HỦY NHẬN ĐƠN HÀNG -> XÓA TRONG THU NHẬP TÀI XẾ
--
CREATE PROCEDURE sp_TaiXeHuyNhanDonHang_tc
            (@MaTX VARCHAR(12),
            @MaDH VARCHAR(10))
AS
BEGIN
  BEGIN TRAN
    BEGIN TRY
      IF (SELECT MaTT FROM TinhTrangDH ttd1 
          WHERE ttd1.MaDH = @MaDH 
            AND ttd1.NgayCapNhat > ALL(SELECT ttd2.NgayCapNhat 
                                      FROM TinhTrangDH ttd2 WHERE ttd2.MaDH = ttd1.MaDH)) <> 4
        BEGIN
          PRINT('1')
          RAISERROR(N'Đơn hàng đang không được vận chuyển',15,1)
        END
      ELSE
        BEGIN
        DELETE FROM ThuNhapTX WHERE MaDH = @MaDH AND MaTX = @MaTX

        INSERT INTO TinhTrangDH VALUES (GETDATE(), @MaDH, 3)
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
--DROP PROCEDURE sp_TaiXeHuyNhanDonHang_tc
--=======================================================================================================================
--KIỂM TRA SẢN PHẨM TỒN TẠI
--
create procedure sp_KiemTraSP
	@MaSP varchar(6),
	@TenSP nvarchar(50)
as
begin
	begin tran
		begin try
			if not exists (select * from SanPham where @MaSP=MaSP and @TenSP= TenSP) 
				raiserror(N'Không tồn tại sản phẩm',15,1)

			select * from SanPham where MaSP= @MaSP and TenSP= @TenSP 
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
--DROP PROCEDURE sp_KiemTraSP
--
--XEM TÌNH TRẠNG ĐƠN HÀNG
--
CREATE PROCEDURE sp_XemTinhTrangDonHang
	(@MaDH varchar(10), @TTDH nvarchar(100) output)
as
begin
	begin tran
		begin try
			declare @MaTT int
			select @MaTT = MaTT
			from TinhTrangDH
			where MaDH = @MaDH and CAST(NgayCapNhat as datetime) >= All(select CAST (NgayCapNhat as datetime)
																from TinhTrangDH
																where MaDH = @MaDH)
			select @TTDH =  Mota from CT_TTDH where MaTinhTrang = @MaTT
		end try
		begin catch
			IF @@trancount>0
				BEGIN	
					print(N'Lỗi')
					ROLLBACK TRANSACTION 
				END
		end catch
	commit tran
	return
END
GO
--DROP PROCEDURE sp_XemTinhTrangDonHang
--=======================================================================================================================


