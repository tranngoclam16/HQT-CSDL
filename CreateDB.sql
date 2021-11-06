create database HT_DHCH_ONLINE
go

use HT_DHCH_ONLINE
go

/*
use master
drop database HT_DHCH_ONLINE
*/

create table DoiTac (
	MaDT varchar(10) primary key,
	MSThue varchar(10) unique not null,
	TenDT nvarchar(100),
	TenNgDaiDien nvarchar(100),
	ThanhPho nvarchar(50),
	Quan nvarchar(30),
	SoChiNhanh int,
	SoLuongDH int,
	LoaiHang nvarchar(100),
	DiaChi nvarchar(200),
	SDT varchar(10),
	Email varchar(30)
)
create table HopDong (
	MaHD varchar(10) primary key,
	MSThue varchar(10) foreign key (MSThue) references DoiTac(MSThue),
	TenNgDaiDien nvarchar(100),
	SoChiNhanh int,
	TGHieuLuc Date,
	HoaHong int,
)



create table ChiNhanh (
	MaCN varchar(10) primary key,
	MaDT varchar(10) foreign key (MaDT) references DoiTac(MaDT),
	TenQL nvarchar(100),
	DiaChi nvarchar(100),
	SDT varchar(10),
)

create table SanPham (
	MaSP varchar(6) primary key,
	TenSP nvarchar(50),
	GiaBan int,
	SLTon int
)

create table CN_SP (
	MaCN varchar(10) foreign key (MaCN) references ChiNhanh(MaCN),
	MaSP varchar(6) foreign key (MaSP) references SanPham(MaSP),
	primary key (MaCN, MaSP)
)

create table KhachHang (
	MaKH varchar(6) primary key,
	HoTen nvarchar(50),
	SDT varchar(10),
	DiaChi nvarchar(100),
	Email varchar(30)
)

create table DonHang (
	MaDH varchar(10) primary key,
	MaKH varchar(10),
	DiaChi nvarchar(30),
	Phuong nvarchar(30),
	Quan nvarchar(30),
	Tinh nvarchar(30),
	NgayLap datetime,
	PhiVanChuyen int,
	TongTien int,
	ThanhToan nvarchar(50)
)

create table CT_DonHang (
	MaDH varchar(10) foreign key (MaDH) references DonHang(MaDH),
	MaSP varchar(6) foreign key (MaSP) references SanPham(MaSP),
	SoLuong int,
	GiaBan int,
	ThanhTien int,
	constraint PK_CTHD primary key (MaDH, MaSP)
)

create table TaiXe (
	CMND varchar(12) primary key,
	HoTen nvarchar(100),
	SDT varchar (10),
	DiaChi nvarchar(100),
	BienSoXe nvarchar(12),
	KVHoatDong nvarchar(30),
	Email varchar(30),
	STK varchar(15),
	NganHang nvarchar(30),
	ChiNhanh nvarchar(30)
)

create table ThuNhapTX (
	MaTX varchar(12) foreign key (MaTX) references TaiXe (CMND),
	MaDH varchar(10) foreign key (MaDH) references DonHang(MaDH),
	PhiVanChuyen int ,
	constraint PK_TNTX primary key (MaDH, MaTX)
)


create table CT_TTDH (
	MaTinhTrang int primary key,
	Mota nvarchar(100)
)

create table TinhTrangDH (
	NgayCapNhat datetime,
	MaDH varchar(10) foreign key (MaDH) references DonHang(MaDH),
	MaTT int foreign key (MaTT) references CT_TTDH (MaTinhTrang),
	primary key (NgayCapNhat, MaDH)
)
go

--Trigger
-- ThanhTien = GiaBan(SanPham)*Soluong

create trigger tinh_thanh_tien 
on CT_DonHang
for insert, update
as
begin
	update CT_DonHang
	set GiaBan = sp.GiaBan
	from inserted i join SanPham sp on i.MaSP = sp.MaSP

	update CT_DonHang
	set ThanhTien=i.SoLuong*i.GiaBan
	from INSERTED i 
	where i.MaDH=CT_DonHang.MaDH and i.MaSP=CT_DonHang.MaSP;

end
go

--TongTien = sum(ThanhTien) (CTHD)
create trigger insert_CTHD 
on CT_DonHang
FOR INSERT
AS 
BEGIN
	update DonHang 
	set DonHang.TongTien= (select sum (ct.ThanhTien)
	from INSERTED i join CT_DonHang ct on i.MaDH=ct.MaDH
	group by ct.MaDH )
	from INSERTED i
	where DonHang.MaDH=i.MaDH
END
GO

create trigger insert_DonHang on DonHang
for insert
as
begin
	update DonHang
	set TongTien = 0
	from inserted i
	where i.MaDH = DonHang.MaDH
end
go

create trigger delete_CTHD 
on CT_DonHang
FOR Delete
AS 
BEGIN
	
	declare @thanhtien int, @mahd varchar(6)
	select @thanhtien = d.ThanhTien, @mahd = d.MaDH
	from deleted d join SanPham sp on d.MaSP= sp.MaSP
	

	update DonHang
	Set TongTien = TongTien - d.ThanhTien
	from deleted d join SanPham sp on d.MaSP = sp.MaSP
	where DonHang.MaDH = d.MaDH
END
GO

create trigger update_CTHD on CT_DonHang
for update
as
begin
	declare @thanhtien int, @mahd varchar(6)
	select @thanhtien = d.ThanhTien, @mahd = d.MaDH
	from deleted d join SanPham sp on d.MaSP= sp.MaSP
	

	update DonHang
	Set TongTien = TongTien - d.ThanhTien
	from deleted d join SanPham sp on d.MaSP = sp.MaSP
	where DonHang.MaDH = d.MaDH

	update DonHang 
	set DonHang.TongTien= (select sum (ct.ThanhTien)
	from INSERTED i join CT_DonHang ct on i.MaDH=ct.MaDH
	group by ct.MaDH )
	from INSERTED i
	where DonHang.MaDH=i.MaDH
end
go


