create database HT_DHCH_ONLINE
go

use HT_DHCH_ONLINE
go

/*
use master
drop database HT_DHCH_ONLINE
*/
create table HopDong (
	MSThue varchar(10) primary key,
	TenNgDaiDien nvarchar,
	SoChiNhanh int,
	TGHieuLuc Date,
	HoaHong int,
)

create table DoiTac (
	MaDT varchar(10) primary key,
	MSThue varchar(10) foreign key (MSThue) references HopDong(MSThue),
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

create table CT_HoaDon (
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

--Trigger
-- ThanhTien = GiaBan(SanPham)*Soluong
CREATE Trigger tinh_thanh_tien on CT_HoaDon
for insert, update
as
begin
	update CT_HoaDon
	set GiaBan = sp.GiaBan
	from inserted i join SanPham sp on i.MaSP = sp.MaSP

	update CT_HoaDon
	set ThanhTien=i.SoLuong*i.GiaBan
	from INSERTED i 
	where i.MaDH=CT_HoaDon.MaDH and i.MaSP=CT_HoaDon.MaSP;

end

--TongTien = sum(ThanhTien) (CTHD)
create trigger insert_CTHD 
on CT_HoaDon
FOR INSERT
AS 
BEGIN
	update DonHang 
	set DonHang.TongTien= (select sum (ct.ThanhTien)
	from INSERTED i join CT_HoaDon ct on i.MaDH=ct.MaDH
	group by ct.MaDH )
	from INSERTED i
	where DonHang.MaDH=i.MaDH
END
GO

create trigger insert_hoadon on DonHang
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
on CT_HoaDon
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

create trigger update_CTHD on CT_HoaDon
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
	from INSERTED i join CT_HoaDon ct on i.MaDH=ct.MaDH
	group by ct.MaDH )
	from INSERTED i
	where DonHang.MaDH=i.MaDH
end


