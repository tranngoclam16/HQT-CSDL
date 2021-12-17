USE HT_DHCH_ONLINE
Go

exec sp_ThemTinhTrangDonHang '0000000001', 4;

select * from CT_TTDH where MaDH = '0000000001'
select * from TinhTrangDH

