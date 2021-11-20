Use HT_DHCH_ONLINE
go

--TestCase09
--Transaction 1
begin tran
	begin try
		select count(*)
		from SanPham
		where GiaBan < 100000
		waitfor delay '00:00:05'
		select count(*)
		from SanPham
		where GiaBan < 100000
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