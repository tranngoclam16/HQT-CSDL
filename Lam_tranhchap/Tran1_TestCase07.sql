USE HT_DHCH_ONLINE
Go

exec sp_CapNhatTTDonHang_TC 'DH0000', 3;


--drop procedure sp_CapNhatTTDonHang_TC
--Insert into TinhTrangDH values
--(GETDATE(), 'DH0000', 1)
--waitfor delay '00:00:02'
--Insert into TinhTrangDH values
--(GETDATE(), 'DH0000', 2)