Use HT_DHCH_ONLINE
go

--drop procedure sp_XemSLTon_TC

--TestCase12
--Transaction 1
create procedure sp_XemSLTon_TC
	(@MaSP varchar(6))
as
begin
	begin tran
		begin try
			select * from SanPham where MaSP = @MaSP
			waitfor delay '00:00:10'
			select * from SanPham where MaSP = @MaSP
		commit tran
		end try
		begin catch
			IF @@trancount>0
				BEGIN	
					print(N'Lỗi')
					ROLLBACK TRANSACTION 
				END
		end catch
end

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

--Insert data for TestCase09's testing
exec sp_ThemSanPham N'Sách', 170000, 100
insert into KhachHang 
values ('0909123450', N'Trần Văn A', '0909123450', N'34 Trần Văn Giáp', 'abc@gmail.com')
insert into DonHang (MaDH, MaKH, TenNguoiNhan, SDT, NgayLap)
values ('0000000001', '0909123450', N'Trần Văn A', '0909123450', '2021-11-10')



