USE HT_DHCH_ONLINE
GO
-- TẠO TÀI KHOẢN ĐỐI TÁC, TÀI XẾ, KHÁCH HÀNG, NHÂN VIÊN
--
CREATE PROC sp_CreateAccount_DT
	@MSThue varchar(10),
	@TenDT nvarchar(100),
	@TenNgDaiDien nvarchar(100),
	@ThanhPho nvarchar(50),
	@Quan nvarchar(30),
	@SoChiNhanh int,
	@LoaiHang nvarchar(100),
	@DiaChi nvarchar(200),
	@Email varchar(30),
	@SDT varchar(10)
AS
BEGIN
	BEGIN TRANSACTION
		BEGIN TRY
			declare @MaDT varchar(10), @pword varchar(20)
			set @MaDT=@SDT
			set @pword=@SDT
			INSERT INTO DoiTac VALUES (@MaDT, @pword,@MSThue, @TenDT, @TenNgDaiDien, @ThanhPho, @Quan, @SoChiNhanh,@LoaiHang, @DiaChi, @Email); 
		COMMIT TRANSACTION
		END TRY
		BEGIN CATCH
		IF @@trancount>0
			BEGIN	
				print('loi')
				ROLLBACK TRANSACTION 
			END
	END CATCH
END;
GO
--DROP PROC sp_CreateAccount_DT

CREATE PROC sp_CreateAccount_TX
	@CMND varchar(12),
	@SDT varchar(10),
	@pword varchar(20),
	@HoTen nvarchar(100),
	@DiaChi nvarchar(100),
	@BienSoXe nvarchar(12),
	@KVHoatDong nvarchar(30),
	@Email varchar(30),
	@STK varchar(15),
	@NganHang nvarchar(30),
	@ChiNhanh nvarchar(30)
AS
BEGIN
	BEGIN TRANSACTION
		BEGIN TRY
			INSERT INTO TaiXe VALUES (@CMND,@SDT,@pword, @HoTen, @DiaChi, @BienSoXe, @KVHoatDong, @Email, @STK, @NganHang, @ChiNhanh); 
		COMMIT TRANSACTION
		END TRY
		BEGIN CATCH
		IF @@trancount>0
			BEGIN	
				print('loi')
				ROLLBACK TRANSACTION 
			END
	END CATCH
END;
GO
--DROP PROC sp_CreateAccount_TX

CREATE PROC sp_CreateAccount_KH
	@MaKH varchar(10),
	@pword varchar(20),
	@HoTen nvarchar(100),
	@DiaChi nvarchar(100),
	@Email varchar(30)
AS
BEGIN
	BEGIN TRANSACTION
		BEGIN TRY
			INSERT INTO KhachHang VALUES (@MaKH,@pword, @HoTen,@DiaChi, @Email); 
		COMMIT TRANSACTION
		END TRY
		BEGIN CATCH
		IF @@trancount>0
			BEGIN	
				print('loi')
				ROLLBACK TRANSACTION 
			END
	END CATCH
END;
GO
--DROP PROC sp_CreateAccount_KH
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
	@ThanhToan nvarchar(100),
	@MaDonHang varchar (10) output
AS
BEGIN
	BEGIN TRAN
		BEGIN TRY
			declare @ma_count bigint,@MaDH varchar(10),@NgayLap DATETIME
			set @NgayLap=GETDATE()
		
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
			INSERT INTO DonHang (MaDH, MaKH, DiaChi, Phuong, Quan,Tinh, TenNguoiNhan, SDT, NgayLap,ThanhToan) 
			VALUES (@MaDH, @MaKH, @DiaChi, @Phuong, @Quan,@Tinh,  @TenNguoiNhan, @SDT, @NgayLap,@ThanhToan)
			
			select @MaDonHang=@MaDH
			select @MaDH
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
--THÊM SẢN PHẨM
--
CREATE PROCEDURE sp_ThemSanPham
	@TenSP nvarchar(50),
	@GiaBan float,
	@SLTon int
AS
BEGIN
	BEGIN TRAN
		BEGIN TRY
			declare @ma_count bigint,@MaSP varchar(6)
		
			set @MaSP=(select TOP 1 (MaSP) from SanPham with (XLOCK, ROWLOCK) 
			order by MaSP DESC)
			
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
create PROCEDURE sp_ThemChiTietDonHang
	(@MaDH varchar(10),
	@MaSP varchar(6),
	@SoLuong int,
	@error int output)
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
			set @sl=(select SLTon from SanPham with (XLOCK, ROWLOCK) where MaSP=@MaSP)
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
END
GO
--DROP PROCEDURE sp_ThemChiTietDonHang
--
--TÀI XẾ NHẬN ĐƠN HÀNG -> THÊM VÀO THU NHẬP TÀI XẾ
--
CREATE PROCEDURE sp_TaiXeNhanDonHang
            (@MaTX VARCHAR(12),
            @MaDH VARCHAR(10),
			@msg nvarchar(100) output)
AS
BEGIN
	BEGIN TRAN
		BEGIN TRY
		DECLARE @ttdh int, @mota nvarchar(100)
		SELECT @ttdh=MaTT FROM CT_TTDH ttd1 with (XLOCK, ROWLOCK)
        WHERE ttd1.MaDH = @MaDH 
        AND ttd1.NgayCapNhat >= ALL(SELECT ttd2.NgayCapNhat 
                                      FROM CT_TTDH ttd2 WHERE ttd2.MaDH = ttd1.MaDH)
		select @mota = Mota from TinhTrangDH where @ttdh = MaTinhTrang
		select @mota as MoTa
		select @ttdh as TTDH
		IF @ttdh < 3
			BEGIN
				select @msg = N'Đơn hàng chưa sẵn sàng để giao'
				PRINT(N'Đơn hàng chưa sẵn sàng để giao')
          --RAISERROR('1',15,1)
			END
			ELSE 
		IF @ttdh = 3
			BEGIN
				DECLARE @PhiVanChuyen int
				SET @PhiVanChuyen = (SELECT PhiVanChuyen FROM DonHang WHERE MaDH = @MaDH)
				INSERT INTO ThuNhapTX VALUES (@MaTX, @MaDH, @PhiVanChuyen)

				INSERT INTO CT_TTDH VALUES (GETDATE(), @MaDH, 4)
				select @msg = N'Nhận đơn thành công'
			END
		
			ELSE 
			begin
				select @msg = N'Đơn hàng đã có người nhận' 
				print(N'Đơn hàng đã có người nhận')
			--raiserror('2',15,1);
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
--DROP PROCEDURE sp_TaiXeNhanDonHang
--=======================================================================================================================
--CẬP NHẬT THÔNG TIN SẢN PHẨM
--
CREATE PROCEDURE sp_CapNhatSanPham
	(@MaSP varchar(6),
	@TenSP nvarchar(50),
	@GiaBan float,
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
			
			--select * from SanPham

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
--CẬP NHẬT TÌNH TRẠNG ĐƠN HÀNG
--
create PROCEDURE sp_CapNhatTinhTrangDonHang
	(@MaDH varchar(10), @MaTT int)
as
begin
	begin tran
		begin try
			insert into CT_TTDH
			values (GETDATE(), @MaDH, @MaTT)
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
--DROP procedure sp_CapNhatTinhTrangDonHang
--=======================================================================================================================
--XÓA ĐƠN HÀNG
--
CREATE PROCEDURE sp_XoaDonHang
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
--DROP PROCEDURE sp_XoaDonHang
--

--KIỂM TRA SẢN PHẨM TỒN TẠI
--
create procedure sp_KiemTraSP
	@MaSP varchar(6),
	@TenSP nvarchar(50),
	@result int output
as
begin
	--SET TRANSACTION ISOLATION LEVEL REPEATABLE READ
	begin tran
		begin try
			--declare @TenSP nvarchar(50), @MaSP varchar(6)
			--set @TenSP = N'áo'
			--set @MaSP = ' '
			Set @TenSP = '%'+@TenSP+'%'

			--select * 
			--from SanPham --with (XLOCK, ROWLOCK) 
			--where MaSP like @MaSP and  TenSP like @TenSP

			if not exists (select * from SanPham with (XLOCK, ROWLOCK) where MaSP like @MaSP or  TenSP like @TenSP) 
				raiserror(N'Không tồn tại sản phẩm',15,1)
			set @result=1
			
			select * from SanPham where MaSP like @MaSP or TenSP like @TenSP
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
--=======================================================================================================================
--KIỂM TRA CÁC SẢN PHẨM CÓ SLTON <N
--
create procedure sp_KiemTraSLTon
	@slt int,
	@Tong int output
as
begin
	--set transaction isolation level serializable
	begin tran
		begin try
			select @Tong= count(MaSP) from SanPham WITH (TABLOCK, HOLDLOCK) where SanPham.SLTon<@slt
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
--DROP PROCEDURE sp_KiemTraSLTon
--
--KIỂM TRA CÁC SẢN PHẨM CÓ GIABAN <N
--
create procedure sp_KiemTraGiaBan
	@gb float,
	@Tong int output
as
begin
	begin tran
		begin try
			select @Tong= count(MaSP) from SanPham WITH (TABLOCK, HOLDLOCK) where SanPham.GiaBan<@gb
			
			SELECT ROW_NUMBER() OVER (ORDER BY MaSP) AS ROWNUMBER, MaSP,TenSP,GiaBan,SLTon FROM SanPham WHERE GiaBan<@gb
			
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
--DROP PROCEDURE sp_KiemTraGiaBan
--=======================================================================================================================
--DANH SÁCH CÁC ĐƠN HÀNG ĐANG Ở TÌNH TRẠNG CHỜ GIAO HÀNG
create procedure sp_getBillForDeliver
	(@start int, @num int, @tong int output)
as
begin
	--declare @tong int
	
	select MaDH into #tblTemp
	from CT_TTDH 
	group by MaDH
	having max(MaTT) = 3
	select @tong = count(*) 
	from DonHang DH join #tblTemp as T on T.MaDH=DH.MaDH
	SELECT * 
	FROM (SELECT ROW_NUMBER() OVER (ORDER BY DonHang.MaDH) AS ROWNUMBER, DonHang.MaDH, MaKH, DiaChi, Phuong, Quan, Tinh, TenNguoiNhan, SDT, convert(varchar, NgayLap, 113) as NgayLap, PhiVanChuyen, TongHang, TongTien, ThanhToan
         FROM DonHang join #tblTemp temp on temp.MaDH = DonHang.MaDH)  AS T WHERE T.ROWNUMBER >= @start AND T.ROWNUMBER < (@start+@num)
	return 
	
end


