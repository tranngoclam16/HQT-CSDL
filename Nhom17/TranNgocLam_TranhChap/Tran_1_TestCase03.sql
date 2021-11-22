Use HT_DHCH_ONLINE
go

--TestCase03
--Transaction 1
begin tran
	begin try
		update KhachHang 
		set DiaChi = N'100 Lê Văn Quới'
		where MaKH = '0909123450'
		waitfor delay '00:00:07'
	commit tran
	end try
	begin catch
	IF @@trancount>0
	BEGIN	
		print(N'Lỗi')
		ROLLBACK TRANSACTION 
	END
end catch

select* from KhachHang where MaKH = '0909123450'
