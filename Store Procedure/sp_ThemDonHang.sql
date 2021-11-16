USE HT_DHCH_ONLINE
GO

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
			waitfor delay '00:00:05'
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
			waitfor delay '00:00:02'

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