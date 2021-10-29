create database HT_DHCH_ONLINE
go

use HT_DHCH_ONLINE
go

create table DoiTac (
	MaDT varchar(10) primary key,
	MSThue varchar(10),
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
	STT int,
	MaDT varchar(10) foreign key (MaDT) references DoiTac(MaDT),
	TenQL nvarchar(100),
	DiaChi nvarchar(100),
	SDT varchar(10),
	constraint PK_CN primary key (STT, MaDT)
)

create table HopDong (
	MSThue varchar(10) foreign key (MSThue) references DoiTac(MSThue),
	TenNgDaiDien nvarchar(100) foreign key (TenNgDaiDien) references DoiTac(TenNgDaiDien),
	SoChiNhanh int,
	TGHieuLuc Date,
	HoaHong int,
	constraint PK_HD primary key (MSThue)
)

create table SanPham (
	MaSP varchar(6),
	TenSP nvarchar(50),
	GiaBan int,
	SLTon int
)

create table CN_SP (
	MaDT varchar(10) foreign key (MaDT) references ChiNhanh(MaDT),
	STT int foreign key (STT) references ChiNhanh(STT),
	MaSP varchar(6) foreign key (MaSP) references SanPham(MaSP),
	constraint PK_CNSP primary key (MaDT, MaSP, STT)
)

create table KhachHang (
	MaKH varchar(6) primary key,
	HoTen nvarchar(50),
	SDT varchar(10),
	DiaChi nvarchar(100),
	Email varchar(30)
)

create table DonHang (
	MaHD varchar(10) primary key,
	MaKH varchar(10),
	DiaChi nvarchar(30),
	Phuong nvarchar(30),
	Quan nvarchar(30),
	Tinh nvarchar(30),
	NgayLap date,
	PhiVanChuyen int,
	TongTien int,
	ThanhToan nvarchar(50)
)

create table CT_HoaDon (
	MaHD varchar(6) foreign key (MaHD) references HoaDon(MaHD),
	MaSP varchar(5) foreign key (MaSP) references SanPham(MaSP),
	SoLuong int,
	GiaBan int,
	GiaGiam int, 
	ThanhTien int,
	constraint PK_CTHD primary key (MaHD, MaSP)
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
	MaHD varchar(6) foreign key (MaHD) references HoaDon(MaHD),
	PhiVanChuyen int foreign key (PhiVanChuyen) references HoaDon(PhiVanChuyen),
	constraint PK_TNTX primary key (MaHD, MaTX)
)