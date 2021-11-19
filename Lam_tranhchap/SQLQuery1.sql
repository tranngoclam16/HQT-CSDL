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

--select* from KhachHang where MaKH = '0000000001'