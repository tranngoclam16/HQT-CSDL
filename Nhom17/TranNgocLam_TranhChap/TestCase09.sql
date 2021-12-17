Use HT_DHCH_ONLINE
go

create procedure sp_KiemTraGiaBan_TC
	@gb float,
	@Tong int output
as
begin
	begin tran
		begin try
			select @Tong= count(MaSP) from SanPham where SanPham.GiaBan<@gb
			waitfor delay '00:00:05'
			SELECT ROW_NUMBER() OVER (ORDER BY MaSP) AS ROWNUMBER, MaSP,TenSP,GiaBan,SLTon FROM SanPham WHERE GiaBan<@gb
			
		commit tran
		end try
	BEGIN CATCH
		IF @@trancount>0
				BEGIN	
					print(N'Lỗi')
					ROLLBACK TRANSACTION 
				END
		END CATCH
end
go
GO
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

--Insert data for TestCase09's testing
exec sp_ThemSanPham N'Sách', 170000, 10
exec sp_ThemSanPham N'Áo thun', 89000, 450
exec sp_ThemSanPham N'Bông cải', 20000, 28
exec sp_ThemSanPham N'Nước hoa', 700000, 8
exec sp_ThemSanPham N'Dép', 65000, 1100
exec sp_ThemSanPham N'Giày thể thao', 300000, 44