USE HT_DHCH_ONLINE
GO

create procedure sp_XemTinhTrangDonHang
	(@MaDH varchar(10), @TTDH nvarchar(100) output)
as
begin
	begin tran
		begin try
			declare @MaTT int
			select @MaTT = MaTT
			from TinhTrangDH
			where MaDH = @MaDH and CAST(NgayCapNhat as datetime) >= All(select CAST (NgayCapNhat as datetime)
																from TinhTrangDH
																where MaDH = @MaDH)
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
end