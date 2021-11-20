USE HT_DHCH_ONLINE
Go

declare @TTDonHang nvarchar(100);	
exec sp_XemTTDonHang_TC 'DH0000', @TTDonHang output;
print (@TTDonHang)

--drop procedure sp_XemTTDonHang
--Insert into TinhTrangDH values
--(GETDATE(), 'DH0000', 1)
--waitfor delay '00:00:02'
--Insert into TinhTrangDH values
--(GETDATE(), 'DH0000', 2)