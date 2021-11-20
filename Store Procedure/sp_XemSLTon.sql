Use HT_DHCH_ONLINE
go

create procedure sp_XemSLTon
	(@MaSP varchar(6))
as
begin
	begin tran
		begin try
			select SLTon from SanPham where MaSP = @MaSP
			waitfor delay '00:00:10'
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