Use HT_DHCH_ONLINE
go

--TestCase03
--Transaction 1
begin tran
	begin try
		update KhachHang 
		set DiaChi = '100 Lê Văn Quới'
		where MaKH = '0000000001'
		waitfor delay '00:00:05'
	commit tran
	end try
	begin catch
	IF @@trancount>0
	BEGIN	
		print(N'Lỗi')
		ROLLBACK TRANSACTION 
	END
end catch
