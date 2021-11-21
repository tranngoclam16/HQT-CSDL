use HT_DHCH_ONLINE
GO

begin tran
	begin try
		select * from SanPham where SLTon < 10
		waitfor delay '00:00:05'
		select * from SanPham where SLTon < 10
	commit tran
	end try
	begin catch
	IF @@trancount>0
	BEGIN	
		print(N'Lỗi')
		ROLLBACK TRANSACTION 
	END
end catch
