--ALTER TABLE ThuNhapTX
--DROP CONSTRAINT FK__ThuNhapTX__MaTX

--ALTER TABLE ThuNhapTX
--DROP CONSTRAINT PK_TNTX

--alter table ThuNhapTX alter column MaTX varchar(10) not null

--alter table ThuNhapTX
--add constraint FK__ThuNhapTX__MaTX
--foreign key (MaTX) references TaiXe(SDT)

--alter table ThuNhapTX
--add constraint  PK_TNTX
--primary key (MaTX, MaDH)

drop table ThuNhapTX

create table ThuNhapTX (
	MaTX varchar(10) ,
	MaDH varchar(10) ,
	PhiVanChuyen int ,
	constraint PK_TNTX primary key (MaDH, MaTX),
	CONSTRAINT FK__ThuNhapTX__MaDH
	FOREIGN KEY (MaDH) references DonHang(MaDH),
	CONSTRAINT FK__ThuNhapTX__MaTX 
	FOREIGN KEY (MaTX) references TaiXe (SDT)
)