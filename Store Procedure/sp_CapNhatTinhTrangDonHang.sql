USE HT_DHCH_ONLINE
GO

create procedure sp_CapNhatTinhTrangDonHang
	(@MaDH varchar(10), @MaTT int)
as
begin
	begin tran
		begin try
			insert into TinhTrangDH
			values (GETDATE(), @MaDH, @MaTT)
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