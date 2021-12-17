USE HT_DHCH_ONLINE
Go

--TestCase07
--Transaction 1
create procedure sp_ThemTinhTrangDonHang_TC
	(@MaDH varchar(10), @MaTT int)
as
begin
	begin tran
		begin try
			insert into TinhTrangDH
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

-- Transaction 2
/*create procedure sp_XemTinhTrangDonHang_TC
	(@MaDH varchar(10), @TTDH nvarchar(100) output)
as
begin
	begin tran
		begin try
			SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
			declare @MaTT int
			select @MaTT = MaTT 
			from TinhTrangDH
			where MaDH = @MaDH and CAST(NgayCapNhat as datetime) >= All(select CAST (NgayCapNhat as datetime)
																from TinhTrangDH
																where MaDH = @MaDH)
			print (@MaTT)
			select @TTDH =  Mota from CT_TTDH where MaTinhTrang = @MaTT
		end try
		begin catch
			IF @@trancount>0
				BEGIN	
					print(N'Lỗi')
					ROLLBACK TRANSACTION 
				END
		end catch
	commit tran
	return
end*/

/*
drop procedure sp_XemTinhTrangDonHang_TC
drop procedure sp_ThemTinhTrangDonHang_TC
*/
	

	
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
values ('0909123450', N'Trần Văn A', '0909123450', N'34 Trần Văn Giáp', 'abc@gmail.com')
insert into DonHang (MaDH, MaKH, TenNguoiNhan, SDT, NgayLap)
values ('0000000001', '0909123450', N'Trần Văn A', '0909123450', '2021-11-10')
Insert into CT_TTDH values
('2021-11-11', '0000000001', 1)
Insert into CT_TTDH values
('2021-11-13', '0000000001', 2)
Insert into CT_TTDH values
('2021-11-14', '0000000001', 3)

