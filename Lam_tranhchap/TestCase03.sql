Use HT_DHCH_ONLINE
go

truncate table TinhTrangDH
truncate table ThuNhapTX
delete from TaiXe
truncate table CT_DonHang
delete from DonHang
delete from KhachHang
truncate table CN_SP
delete from SanPham
delete from ChiNhanh
truncate table HopDong
delete from DoiTac

--Insert data for TestCase03's testing
insert into KhachHang 
values ('0909123450', N'Trần Văn A', '0909123450', N'34 Trần Văn Giáp', 'abc@gmail.com')
