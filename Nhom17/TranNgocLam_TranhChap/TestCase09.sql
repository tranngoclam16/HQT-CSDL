Use HT_DHCH_ONLINE
go

create procedure sp_KiemTraGiaBan_TC
	@gb float,
	@Tong int output
as
begin
	begin tran
		begin try
			select @Tong= count(MaSP) from SanPham where SanPham.GiaBan<@gb
			waitfor delay '00:00:05'
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
GO
CREATE PROCEDURE sp_ThemSanPham_TC
	@TenSP nvarchar(50),
	@GiaBan float,
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
truncate table CT_TTDH
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
exec sp_ThemSanPham_TC N'Sách', 170000, 10
exec sp_ThemSanPham_TC N'Áo thun', 89000, 450
exec sp_ThemSanPham_TC N'Bông cải', 20000, 28
exec sp_ThemSanPham_TC N'Nước hoa', 700000, 8
exec sp_ThemSanPham_TC N'Dép', 65000, 1100
exec sp_ThemSanPham_TC N'Giày thể thao', 300000, 44