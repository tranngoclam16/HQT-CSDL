create procedure sp_XemSLT
	(@MaSP varchar(6))
as
begin
	begin tran
		begin try
			select SLTon from SanPham where MaSP = @MaSP
			waitfor delay '00:00:05'
			select SLTon from SanPham where MaSP = @MaSP
		commit tran
		end try
		begin catch
			IF @@trancount>0
				BEGIN	
					print(N'Lỗi')
					ROLLBACK TRANSACTION 
				END
		end catch
end

exec sp_XemSLT 'SP001'