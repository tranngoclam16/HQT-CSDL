USE HT_DHCH_ONLINE
GO
create procedure sp_KiemTraSP
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
--drop procedure sp_KiemTraSP