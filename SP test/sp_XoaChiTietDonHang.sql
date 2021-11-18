--PROCEDURE XÓA CHI TIẾT ĐƠN HÀNG
USE HT_DHCH_ONLINE
GO
CREATE PROCEDURE ctdh_XoaChiTietDonHang(@MaDH varchar(10), @MaSP varchar(6))
AS
BEGIN
	begin tran
		begin try
			waitfor delay '00:00:05'
			if NOT EXISTS (Select * from CT_DonHang where MaDH = @MaDH and MaSP = @MaSP)
				print(N'Không tồn tại chi tiết đơn hàng')
			else
				DELETE FROM CT_DonHang WHERE MaDH = @MaDH and MaSP = @MaSP
		commit tran
		end try
		begin catch
			if @@TRANCOUNT>0
				begin
				print(N'Lỗi')
				rollback tran
				end
		end catch
END
GO
----
--drop procedure ctdh_XoaChiTietDonHang