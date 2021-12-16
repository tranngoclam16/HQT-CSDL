USE HT_DHCH_ONLINE
Go

exec sp_ThemTinhTrangDonHang_TC '0000000001', 4;

select * from TinhTrangDH where MaDH = '0000000001'
select * from CT_TTDH

