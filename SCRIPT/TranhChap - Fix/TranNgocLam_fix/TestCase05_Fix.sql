USE HT_DHCH_ONLINE
Go

--TestCase05
--Transaction 1
create procedure sp_CapNhatTinhTrangDonHang
	(@MaDH varchar(10), @MaTT int)
as
begin
	begin tran
		begin try
			insert into CT_TTDH 
			values (GETDATE(), @MaDH, @MaTT)
			waitfor delay '00:00:07'
			ROLLBACK TRANSACTION
		end try
		begin catch
			IF @@trancount>0
				BEGIN	
					print(N'Lỗi')
					ROLLBACK TRANSACTION 
				END
		end catch
end
go

	
go
truncate table CT_TTDH
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
values ('0909123450', '0909123450', N'Trần Văn A', N'34 Trần Văn Giáp', 'abc@gmail.com')
insert into DonHang (MaDH, MaKH, TenNguoiNhan, SDT, NgayLap)
values ('0000000001', '0909123450', N'Trần Văn A', '0909123450', '2021-11-10')
Insert into CT_TTDH values
('2021-11-11', '0000000001', 1)
Insert into CT_TTDH values
('2021-11-13', '0000000001', 2)
Insert into CT_TTDH values
('2021-11-14', '0000000001', 3)

