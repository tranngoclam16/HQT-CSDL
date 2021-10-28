create database HT_DHCH_ONLINE
go

use HT_DHCH_ONLINE
go

create table DoiTac (
	MaSoThue varchar(10) primary key,
	TenNgDaiDien nvarchar(50),
	ThanhPho nvarchar(50),
	Quan nvarchar(30),
	SoChiNhanh int,
	SoLuongDH int,
	LoaiHang nvarchar(100),
	DiaChi nvarchar(200),
	SÐT varchar(10),
	Email varchar(30)
)

create table SanPham (
	MaSP varchar(6),
	MaDT varchar(10),
	TenSP nvarchar(50),
	GiaBan int,
	primary key (MaSP, MaDT),
	foreign key MaDT reference
)