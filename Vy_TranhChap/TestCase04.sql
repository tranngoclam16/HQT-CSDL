USE HT_DHCH_ONLINE
GO
--TestCase04
CREATE PROCEDURE sp_ThemSanPham_TC
	@TenSP nvarchar(50),
	@GiaBan int,
	@SLTon int
AS
BEGIN
	BEGIN TRAN
		BEGIN TRY
			waitfor delay '00:00:05'
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
			
			waitfor delay '00:00:02'

			print @MaSP

			INSERT INTO SanPham values (@MaSP, @TenSP, @GiaBan, @SLTon)

			waitfor delay '00:00:04'
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