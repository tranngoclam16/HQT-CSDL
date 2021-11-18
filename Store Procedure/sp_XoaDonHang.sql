CREATE PROCEDURE dh_XoaDonHang
	(@MaDH varchar(10))
AS
BEGIN
	BEGIN TRAN
		BEGIN TRY
			WAITFOR DELAY '00:00:05'
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
--drop procedure dh_XoaDonHang
exec 