use HT_DHCH_ONLINE
GO
--ROLE
--Đối tác:
		--được quyền sửa thông tin cá nhân
		--được thêm, xóa, sửa thông tin sản phẩm
		--được sửa thông tin chi nhánh
		--xem  đơn hàng, chi tiết và cập nhật  tình trạng đơn hàng

--Khách hàng: 
			--được quyền sửa thông tin cá nhân
			--Xem danh sách đối tác, danh sách chi nhánh, danh sách sản phẩm
			--Xem tình trạng đơn hàng và chi tiết đơn hàng, thông tin đơn hàng của mình

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
GO

--Nhân viên:
			--Xem danh sách đối tác
			--cập nhật hợp đồng

CREATE ROLE [NHANVIEN] AUTHORIZATION [dbo]
GO
GRANT UPDATE,SELECT ON DoiTac TO [NHANVIEN];
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



