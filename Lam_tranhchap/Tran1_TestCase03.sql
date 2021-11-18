create procedure sp_XemTTDonHang
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

go
declare @TTDonHang nvarchar(100);	
exec sp_XemTTDonHang 'DH0000', @TTDonHang output;
print (@TTDonHang)

drop procedure sp_XemTTDonHang
--Insert into TinhTrangDH values
--(GETDATE(), 'DH0000', 1)
--waitfor delay '00:00:02'
--Insert into TinhTrangDH values
--(GETDATE(), 'DH0000', 2)