use HT_DHCH_ONLINE
GO
-------------ROLE----------------------------
--Đối tác:
create role [DOITAC] authorization [dbo]
go
		--cấp quyền
	--được quyền xem,sửa thông tin cá nhân
	grant select, update on DoiTac to [DOITAC]
	--được xem,thêm, xóa, sửa thông tin sản phẩm
	grant select, insert, delete, update on SanPham to [DOITAC]
	--được xem, thêm, xóa,sửa thông tin chi nhánh
	grant select,insert, delete, update on ChiNhanh to [DOITAC]
	grant select,insert,delete,update on CN_SP to[DOITAC]
	--xem thông tin đơn hàng, chi tiết và cập nhật tình trạng đơn hàng
	grant select  on DonHang to [DOITAC]
	grant select on CT_DonHang to [DOITAC]
	grant select on CT_TTDH to [DOITAC]
	grant select, update on TinhTrangDH to [DOITAC]



--Khách hàng: 
create role [KHACHHANG] authorization [dbo]
go
		--cấp quyền
	--được quyền xem,sửa, đăng ký thông tin cá nhân
	grant select, update,insert on KhachHang to [KHACHHANG] 
	--Xem danh sách đối tác, danh sách chi nhánh, danh sách sản phẩm
	grant select on DoiTac to [KHACHHANG]
	grant select on ChiNhanh to [KHACHHANG]
	grant select on SanPham to [KHACHHANG]
	grant select on CN_SP to[KHACHHANG]
	--Xem tình trạng đơn hàng và chi tiết đơn hàng, thông tin đơn hàng của mình
	--Được thêm,hủy đơn hàng
	grant select,insert,delete on DonHang to [KHACHHANG]
	grant select,insert,delete on CT_DonHang to [KHACHHANG]
	grant select on TinhTrangDH to [KHACHHANG]
	grant select on CT_TTDH to [KHACHHANG]

--Tài xế: 
			--Sửa,xem,đăng ký thông tin cá nhân
			--Xem danh sách đơn hàng
			--Cập nhật tình trạng đơn hàng
			--Xem danh sách thu nhập của mình
CREATE ROLE [TAIXE] AUTHORIZATION [dbo]
GO
GRANT SELECT,UPDATE,INSERT ON TaiXe TO [TAIXE]
GRANT SELECT,UPDATE ON TinhTrangDH TO [TAIXE]
GRANT SELECT ON DonHang TO [TAIXE]
GRANT SELECT, INSERT,DELETE ON ThuNhapTX TO [TAIXE]
grant select on CT_TTDH to [TAIXE]
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

-----------------------LOGIN-----------------------------
--DBA
CREATE LOGIN [dba1] WITH PASSWORD='dba1', DEFAULT_DATABASE=[HT_DHCH_ONLINE], CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF;
CREATE USER [dba1] FOR LOGIN [dba1] WITH DEFAULT_SCHEMA=[dbo];
ALTER ROLE [roleDBA] ADD MEMBER [dba1]
GO
--DOI TAC
CREATE LOGIN [dt] WITH PASSWORD='dt', DEFAULT_DATABASE=[HT_DHCH_ONLINE], CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF;
CREATE USER [dt] FOR LOGIN [dt] WITH DEFAULT_SCHEMA=[dbo];
ALTER ROLE [DOITAC] ADD MEMBER [dt]
GO
--TAI XE
CREATE LOGIN [tx] WITH PASSWORD='tx', DEFAULT_DATABASE=[HT_DHCH_ONLINE], CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF;
CREATE USER [tx] FOR LOGIN [tx] WITH DEFAULT_SCHEMA=[dbo];
ALTER ROLE [TAIXE] ADD MEMBER [tx]
GO
--KHACH HANG
CREATE LOGIN [kh] WITH PASSWORD='kh', DEFAULT_DATABASE=[HT_DHCH_ONLINE], CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF;
CREATE USER [kh] FOR LOGIN [kh] WITH DEFAULT_SCHEMA=[dbo];
ALTER ROLE [KHACHHANG] ADD MEMBER [kh]
GO
--NHAN VIEN
CREATE LOGIN [nv1] WITH PASSWORD='nv1', DEFAULT_DATABASE=[HT_DHCH_ONLINE], CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF;
CREATE USER [nv1] FOR LOGIN [nv1] WITH DEFAULT_SCHEMA=[dbo];
ALTER ROLE [NHANVIEN] ADD MEMBER [nv1]
GO



