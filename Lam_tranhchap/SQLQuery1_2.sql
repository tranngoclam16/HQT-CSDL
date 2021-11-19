begin tran
	begin try
		update KhachHang 
		set DiaChi = '15/2/1 Nguyễn Sơn'
		where MaKH = '0000000001'
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