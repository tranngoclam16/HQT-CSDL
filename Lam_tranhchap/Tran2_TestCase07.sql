begin tran
	begin try
		insert into SanPham values
		 ('SP020',NULL,70000, 20)
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