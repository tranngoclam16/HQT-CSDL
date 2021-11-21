USE HT_DHCH_ONLINE
GO
--TestCase11
--Transaction 1
create procedure sp_KiemTraSP_TC
	@MaSP varchar(6),
	@TenSP nvarchar(50)
as
begin
	begin tran
		begin try
			if not exists (select * from SanPham where @MaSP=MaSP and @TenSP= TenSP) 
				raiserror(N'Không tồn tại sản phẩm',15,1)

			waitfor delay '00:00:08'
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
--drop procedure sp_KiemTraSP_TC

--Transaction 2
USE HT_DHCH_ONLINE
GO
CREATE PROCEDURE sp_CapNhatSanPham_TC
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

			waitfor delay '00:00:05'
			update SanPham
			set TenSP= @TenSP, GiaBan= @GiaBan, SLTon= @SLTon
			where MaSP= @MaSP
			
			select * from SanPham

			waitfor delay '00:00:02'
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
--
--drop procedure sp_CapNhatSanPham_TC