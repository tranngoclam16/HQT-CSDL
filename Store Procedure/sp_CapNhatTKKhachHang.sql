create procedure sp_CapNhatTKKhachHang
	(@MaKH varchar(10), 
	@HoTen nvarchar(100),
	@SDT varchar(10),
	@DiaChi nvarchar(100),
	@Email varchar(30))
as
begin
	begin tran
		begin try
			if (@HoTen != '')
			begin
				update KhachHang
				set HoTen = @HoTen
				where MaKH = @MaKH
			end
			if (@SDT != '')
			begin
				update KhachHang
				set SDT = @SDT
				where MaKH = @MaKH
			end
			if (@DiaChi != '')
			begin
				update KhachHang
				set DiaChi = @DiaChi
				where MaKH = @MaKH
			end
			if (@Email != '')
			begin
				update KhachHang
				set Email = @Email
				where MaKH = @MaKH
			end
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
