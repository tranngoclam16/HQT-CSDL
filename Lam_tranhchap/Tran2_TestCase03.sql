create procedure sp_CapNhatTTDonHang
	(@MaDH varchar(10), @MaTT int)
as
begin
	begin tran
		begin try
			insert into TinhTrangDH
			values (GETDATE(), @MaDH, @MaTT)
			waitfor delay '00:00:07'
			ROLLBACK TRANSACTION 
		end try
		begin catch
			IF @@trancount>0
				BEGIN	
					print(N'Lỗi')
					ROLLBACK TRANSACTION 
				END
		end catch
end

go
	
exec sp_CapNhatTTDonHang 'DH0000', 3;


drop procedure sp_CapNhatTTDonHang
--Insert into TinhTrangDH values
--(GETDATE(), 'DH0000', 1)
--waitfor delay '00:00:02'
--Insert into TinhTrangDH values
--(GETDATE(), 'DH0000', 2)