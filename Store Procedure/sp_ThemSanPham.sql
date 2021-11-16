USE HT_DHCH_ONLINE
GO

CREATE PROCEDURE sp_ThemSanPham
	@TenSP nvarchar(50),
	@GiaBan int,
	@SLTon int
AS
BEGIN
	BEGIN TRAN
		BEGIN TRY
			waitfor delay '00:00:05'
			declare @ma_count bigint,@MaSP varchar(6)
			set @ma_count=(select count(*)from SanPham with (NOLOCK))+1
			set @MaSP = RIGHT(CAST(@ma_count AS VARCHAR(6)), 6)
			waitfor delay '00:00:02'

			print @MaSP

			INSERT INTO SanPham values (@MaSP, @TenSP, @GiaBan, @SLTon)
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