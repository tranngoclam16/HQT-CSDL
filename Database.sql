create database HT_DHCH_ONLINE
go

use HT_DHCH_ONLINE
go

/*
use master
drop database HT_DHCH_ONLINE
*/

create table DoiTac (
	MaDT varchar(10) primary key,--username-> SDT
	pword varchar(20) not null,--password
	MSThue varchar(10) unique not null,
	TenDT nvarchar(100),
	TenNgDaiDien nvarchar(100),
	ThanhPho nvarchar(50),
	Quan nvarchar(30),
	SoChiNhanh int,
	LoaiHang nvarchar(100),
	DiaChi nvarchar(200),
	Email varchar(30)
)
create table HopDong (
	MaHD varchar(10) primary key,
	MSThue varchar(10),
	TenNgDaiDien nvarchar(100),
	SoChiNhanh int,
	TGHieuLuc Date,
	HoaHong int,
	CONSTRAINT FK__HopDong__MSThue
	FOREIGN KEY (MSThue) references DoiTac(MSThue)
)


create table ChiNhanh (
	MaCN varchar(10) primary key,
	MaDT varchar(10) ,
	TenQL nvarchar(100),
	DiaChi nvarchar(100),
	SDT varchar(10),
	CONSTRAINT FK__ChiNhanh__MaDT
	FOREIGN KEY (MaDT) references DoiTac(MaDT)
)

create table SanPham (
	MaSP varchar(6) primary key,
	TenSP nvarchar(50),
	GiaBan float,
	SLTon int
)

create table CN_SP (
	MaCN varchar(10) ,
	MaSP varchar(6) ,
	primary key (MaCN, MaSP),
	CONSTRAINT FK__CN_SP__MaCN
	FOREIGN KEY (MaCN) references ChiNhanh(MaCN),
	CONSTRAINT FK__CN_SP__MaSP
	FOREIGN KEY (MaSP) references SanPham(MaSP)
)

create table KhachHang (
	MaKH varchar(10) primary key,--username là SDT 
	pword  varchar (20) not null,--password
	HoTen nvarchar(100),
	DiaChi nvarchar(100),
	Email varchar(30)
)

create table DonHang (
	MaDH varchar(10) primary key,
	MaKH varchar(10) references KhachHang(MaKH),
	DiaChi nvarchar(30),
	Phuong nvarchar(30),
	Quan nvarchar(30),
	Tinh nvarchar(30),
	TenNguoiNhan nvarchar(100),
	SDT varchar(10),
	NgayLap datetime,
	PhiVanChuyen float,
	TongHang float,
	TongTien as (PhiVanChuyen+TongHang),
	ThanhToan nvarchar(100)
)

create table CT_DonHang (
	MaDH varchar(10) ,
	MaSP varchar(6),
	SoLuong int,
	GiaBan float,
	ThanhTien int,
	constraint PK_CTHD primary key (MaDH, MaSP),
	CONSTRAINT FK__CT_DonHang__MaDH 
	FOREIGN KEY (MaDH) references DonHang(MaDH),
	CONSTRAINT FK__CT_DonHang__MaSP
	FOREIGN KEY (MaSP) references SanPham(MaSP)
)

create table TaiXe (
	CMND varchar(12) unique not null,
	SDT varchar(10) primary key,--username
	pword varchar(20) not null,--password
	HoTen nvarchar(100),
	DiaChi nvarchar(100),
	BienSoXe nvarchar(12),
	KVHoatDong nvarchar(30),
	Email varchar(30),
	STK varchar(15),
	NganHang nvarchar(30),
	ChiNhanh nvarchar(30)
)
--drop table ThuNhapTX
create table ThuNhapTX (
	MaTX varchar(10) ,
	MaDH varchar(10) ,
	PhiVanChuyen int ,
	constraint PK_TNTX primary key (MaDH),
	CONSTRAINT FK__ThuNhapTX__MaDH
	FOREIGN KEY (MaDH) references DonHang(MaDH),
	CONSTRAINT FK__ThuNhapTX__MaTX 
	FOREIGN KEY (MaTX) references TaiXe (SDT)
)


create table TinhTrangDH (
	MaTinhTrang int primary key,
	Mota nvarchar(100)
)

create table CT_TTDH (
	NgayCapNhat datetime,
	MaDH varchar(10),
	MaTT int ,
	primary key (NgayCapNhat, MaDH),
	CONSTRAINT FK__CTTTDH__MaDH
	FOREIGN KEY (MaDH) references DonHang(MaDH),
	CONSTRAINT FK__CTTTDH__MaTT
	FOREIGN KEY (MaTT) references TinhTrangDH (MaTinhTrang)
)
go

create table #temp (
	MaTinhTrang int primary key,
	Mota nvarchar(100)
)

--delete from CT_TTDH
--delete from TinhTrangDH
insert into #temp values
(0, N'Đơn hàng đã hủy.'),
(1, N'Đơn hàng được tiếp nhận.'),
(2, N'Đơn hàng đang đóng gói.'),
(3, N'Đang chờ giao hàng.'),
(4, N'Đơn hàng đang giao.'),
(5, N'Đơn hàng giao thành công.')

select * from #temp

update ttdh
set ttdh.Mota = t.Mota from TinhTrangDH ttdh inner join #temp t on ttdh.MaTinhTrang = t.MaTinhTrang 

