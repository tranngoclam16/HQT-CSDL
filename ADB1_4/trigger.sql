USE HT_DHCH_ONLINE
GO
--Thành tiền
create trigger tinh_thanh_tien 
on CT_DonHang
for insert, update
as
begin
	update CT_DonHang
	set GiaBan = (select sp.GiaBan
					from SanPham sp 
					where CT_DonHang.MaSP = sp.MaSP)
	from INSERTED i
	where i.MaDH= CT_DonHang.MaDH and i.MaSP= CT_DonHang.MaSP

	update CT_DonHang
	set ThanhTien=i.SoLuong* CT_DonHang.GiaBan
	from INSERTED i 
	where i.MaDH=CT_DonHang.MaDH and i.MaSP=CT_DonHang.MaSP;
end
go

--Tổng tiền =phí vận chuyển + sum (thành tiền)
CREATE TRIGGER insertCTHD on CT_DonHang
for INSERT,UPDATE
AS
BEGIN
	update DonHang
	set TongHang= (select sum (ct.ThanhTien)
							from CT_DonHang ct
							where ct.MaDH= DonHang.MaDH)
	from INSERTED
	where INSERTED.MaDH= DonHang.MaDH

	UPDATE DonHang
	SET PhiVanChuyen = (select dh.TongHang * 0.05
							from DonHang dh
							where dh.MaDH= DonHang.MaDH)
	FROM INSERTED
	where INSERTED.MaDH= DonHang.MaDH

END
GO

CREATE TRIGGER deleteCTHD on CT_DonHang
FOR DELETE
AS 
BEGIN
	update DonHang
	set TongHang= (select sum (ct.ThanhTien)
							from CT_DonHang ct
							where ct.MaDH= DonHang.MaDH)
	from DELETED 
	where  DELETED.MaDH= DonHang.MaDH

	UPDATE DonHang
	SET PhiVanChuyen = (select dh.TongHang * 0.05
							from DonHang dh
							where dh.MaDH= DonHang.MaDH)
	FROM  DELETED
	where  DELETED.MaDH= DonHang.MaDH
END
GO

--số chi nhánh:
--số chi nhánh lúc đầu =0
create trigger insertDT on DoiTac 
for insert 
as
begin
	update DoiTac set SoChiNhanh=0
	from INSERTED 
	where INSERTED.MaDT=DoiTac.MaDT
end
GO
--số chi nhánh được cập nhật theo bảng chi nhánh
CREATE TRIGGER insertCN on ChiNhanh
FOR INSERT
AS
BEGIN
	update DoiTac
	set DoiTac.SoChiNhanh= (select count(ChiNhanh.MaCN) from ChiNhanh 
							where MaDT= DoiTac.MaDT)
	from INSERTED i 
	where i.MaDT= DoiTac.MaDT
END
GO

CREATE TRIGGER deleteCN on ChiNhanh
FOR DELETE
AS
BEGIN
	update DoiTac
	set DoiTac.SoChiNhanh= (select count(ChiNhanh.MaCN) from ChiNhanh 
							where MaDT= DoiTac.MaDT)
	from DELETED d
	where d.MaDT= DoiTac.MaDT
END
GO




-------------------------------------------------------------------------------------------------------------------------------------------
---trigger cập nhật số lượng tồn
-- khi đặt hàng
CREATE TRIGGER slt_dathang ON CT_DonHang for INSERT AS 
BEGIN
		UPDATE SanPham
		SET SLTon = SLTon - (
		SELECT sum(SoLuong)
		FROM INSERTED i
		WHERE i.MaSP = SanPham.MaSP
	)
		FROM INSERTED i
		where SanPham.MaSP = i.MaSP
		select * from SanPham
END
GO

-- khi hủy hàng
CREATE TRIGGER slt_huyhang ON CT_DonHang FOR DELETE AS 
BEGIN
	UPDATE SanPham
	SET SLTon = SLTon + (
		SELECT sum(SoLuong)
		FROM deleted d
		WHERE d.MaSP = SanPham.MaSP
	)
	FROM DELETED d 
	where SanPham.MaSP = d.MaSP
END
GO
-- khi sửa chi tiết hóa đơn
CREATE TRIGGER slt_capnhathang ON CT_DonHang after update AS
BEGIN
   UPDATE SanPham 
   SET SLTon = SLTon -
	   (SELECT sum(SoLuong) FROM inserted WHERE MaSP = SanPham.MaSP) +
	   (SELECT sum(SoLuong) FROM deleted WHERE MaSP = SanPham.MaSP)
   FROM SanPham
   JOIN deleted ON SanPham.MaSP = deleted.MaSP
END
GO
