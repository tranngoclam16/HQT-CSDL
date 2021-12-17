USE HT_DHCH_ONLINE
Go

/*declare @TTDonHang nvarchar(100);	
exec sp_XemTinhTrangDonHang_TC '0000000001', @TTDonHang output;
print (@TTDonHang)*/
begin tran
select * from CT_TTDH where MaDH='0000000001'
commit tran


