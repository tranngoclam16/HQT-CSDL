USE HT_DHCH_ONLINE
GO

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
			waitfor delay '00:00:05'
			declare @ma_count bigint,@MaHD varchar(10)
			set @ma_count=(select count(*)from HopDong with (NOLOCK))+1
			set @MaHD = RIGHT(CAST(@ma_count AS VARCHAR(10)), 10)
			waitfor delay '00:00:02'

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