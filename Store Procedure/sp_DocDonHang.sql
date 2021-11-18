create procedure dh_DocDonHang 
as
begin
	begin tran
		begin try
			select * from DonHang 
			waitfor delay '00:00:15'
			select * from DonHang 
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
--drop procedure dh_DocDonHang