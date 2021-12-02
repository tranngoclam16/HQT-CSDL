﻿Use HT_DHCH_ONLINE
go

--TestCase03
--Transaction 2
begin tran
	begin try
		update KhachHang 
		set DiaChi = N'15/2/1 Nguyễn Sơn'
		where MaKH = '0909123450'
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