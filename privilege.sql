use HT_DHCH_ONLINE
GO
--ROLE
--Đối tác:
create role [DOITAC] authorization [dbo]
go
		--cấp quyền
	--được quyền sửa thông tin cá nhân
	grant select, update on DoiTac to [DOITAC]
	--được xem,thêm, xóa, sửa thông tin sản phẩm
	grant select, insert, delete, update on SanPham to [DOITAC]
	--được xem, thêm, xóa,sửa thông tin chi nhánh
	grant select,insert, delete, update on ChiNhanh to [DOITAC]
	--xem thông tin đơn hàng, chi tiết và cập nhật tình trạng đơn hàng
	grant select  on DonHang to [DOITAC]
	grant select on CT_HoaDon to [DOITAC]
	grant select on CT_TTDH to [DOITAC]
	grant select, update on TinhTrangDH to [DOITAC]


--Khách hàng: 
create role [KHACHHANG] authorization [dbo]
go
		--cấp quyền
	--được quyền sửa thông tin cá nhân
	grant select, update on KhachHang to [KHACHHANG] 
	--Xem danh sách đối tác, danh sách chi nhánh, danh sách sản phẩm
	grant select on DoiTac to [KHACHHANG]
	grant select on ChiNhanh to [KHACHHANG]
	grant select on SanPham to [KHACHHANG]
	--Xem tình trạng đơn hàng và chi tiết đơn hàng, thông tin đơn hàng của mình
	--Được thêm đơn hàng
	grant select,insert on DonHang to [KHACHHANG]
	grant select,insert on CT_HoaDon to [KHACHHANG]
	grant select on TinhTrangDH to [KHACHHANG]
	grant select on CT_TTDH to [DOITAC]

--Tài xế: 
			--Sửa thông tin cá nhân
			--Xem danh sách đơn hàng
			--Cập nhật tình trạng đơn hàng
			--Xem danh sách thu nhập của mình
CREATE ROLE [TAIXE] AUTHORIZATION [dbo]
GO
GRANT SELECT,UPDATE ON TaiXe TO [TAIXE]
GRANT SELECT,UPDATE ON TinhTrangDH TO [TAIXE]
GRANT SELECT ON DonHang TO [TAIXE]
GRANT SELECT ON ThuNhapTX TO [TAIXE]
grant select on CT_TTDH to [DOITAC]
GO

--Nhân viên:
			--Xem danh sách đối tác
			--cập nhật hợp đồng

CREATE ROLE [NHANVIEN] AUTHORIZATION [dbo]
GO
GRANT SELECT ON DoiTac TO [NHANVIEN];
GO
GRANT UPDATE,SELECT ON HopDong TO [NHANVIEN];
GO
--Admin:
			--Cập nhật thông tin tài khoản
			--Thêm xóa sửa tài khoản admin, nhân viên
			--Khóa và kích hoạt tài khoản
			--Cấp quyền trên csdl và giao diện

CREATE ROLE [roleDBA] AUTHORIZATION dbo;

ALTER ROLE [db_owner] ADD MEMBER [roleDBA]
ALTER ROLE [db_accessadmin] ADD MEMBER [roleDBA]
ALTER ROLE [db_securityadmin] ADD MEMBER [roleDBA]
GO



