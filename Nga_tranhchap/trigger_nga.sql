----trigger phí vận chuyển
CREATE TRIGGER phi_van_chuyen ON DonHang 
after UPDATE
AS
BEGIN
  UPDATE DonHang
  SET PhiVanChuyen = 0.05 * (select sum (ct.ThanhTien)
	from INSERTED i join CT_DonHang ct on i.MaDH=ct.MaDH
	group by ct.MaDH)
  from INSERTED i
  where DonHang.MaDH=i.MaDH
END
go
---trigger cập nhật số lượng tồn
-- khi đặt hàng
CREATE TRIGGER slt_dathang ON CT_DonHang AFTER INSERT AS 
BEGIN
	begin
	if exists (select inserted.SoLuong from inserted, SanPham where inserted.MaSP = SanPham.MaSP and inserted.SoLuong>SanPham.SLTon)
		begin
			raiserror(N'Số lượng đặt vượt quá số lượng trong kho',15,1)
			rollback
		end
	end
	UPDATE SanPham
	SET SLTon = SLTon - (
		SELECT SoLuong
		FROM inserted
		WHERE MaSP = SanPham.MaSP
	)
	FROM SanPham
	JOIN inserted ON SanPham.MaSP = inserted.MaSP
	select * from SanPham
END
GO

-- khi hủy hàng
CREATE TRIGGER slt_huyhang ON CT_DonHang FOR DELETE AS 
BEGIN
	UPDATE SanPham
	SET SLTon = SLTon + (
		SELECT SoLuong
		FROM deleted
		WHERE MaSP = SanPham.MaSP
	)
	FROM SanPham
	JOIN deleted ON SanPham.MaSP = deleted.MaSP
END
GO
-- khi sửa chi tiết hóa đơn
CREATE TRIGGER slt_capnhathang ON CT_DonHang after update AS
BEGIN
	begin
	if exists (select * from inserted i, deleted d, SanPham where i.MaSP = SanPham.MaSP and d.MaSP = SanPham.MaSP and i.SoLuong-d.SoLuong>SanPham.SLTon)
		begin
			raiserror(N'Số lượng chỉnh sửa vượt quá số lượng trong kho',15,1)
			rollback
		end
	end
   UPDATE SanPham 
   SET SLTon = SLTon -
	   (SELECT SoLuong FROM inserted WHERE MaSP = SanPham.MaSP) +
	   (SELECT SoLuong FROM deleted WHERE MaSP = SanPham.MaSP)
   FROM SanPham
   JOIN deleted ON SanPham.MaSP = deleted.MaSP
end
GO

