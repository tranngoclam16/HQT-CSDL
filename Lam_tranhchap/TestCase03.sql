Use HT_DHCH_ONLINE
go

ALTER TABLE TinhTrangDH
DROP CONSTRAINT FK__TinhTrangD__MaDH

ALTER TABLE TinhTrangDH
DROP CONSTRAINT FK__TinhTrangD__MaTT


ALTER TABLE ThuNhapTX
DROP CONSTRAINT FK__ThuNhapTX__MaTX

ALTER TABLE ThuNhapTX
DROP CONSTRAINT FK__ThuNhapTX__MaDH

ALTER TABLE CT_DonHang
DROP CONSTRAINT FK__CT_DonHang__MaDH

ALTER TABLE CT_DonHang
DROP CONSTRAINT FK__CT_DonHang__MaSP

ALTER TABLE CN_SP
DROP CONSTRAINT FK__CN_SP__MaCN

ALTER TABLE CN_SP
DROP CONSTRAINT FK__CN_SP__MaSP

ALTER TABLE HopDong
DROP CONSTRAINT FK__HopDong__MSThue

ALTER TABLE ChiNhanh
DROP CONSTRAINT FK__ChiNhanh__MaDT




truncate table TinhTrangDH
truncate table ThuNhapTX
truncate table TaiXe
truncate table CT_DonHang
truncate table DonHang
truncate table KhachHang
truncate table CN_SP
truncate table SanPham
truncate table ChiNhanh
truncate table HopDong
truncate table DoiTac

ALTER TABLE HopDong
ADD CONSTRAINT FK__HopDong__MSThue
FOREIGN KEY (MSThue) references DoiTac(MSThue)

ALTER TABLE ChiNhanh
ADD CONSTRAINT FK__ChiNhanh__MaDT
FOREIGN KEY (MaDT) references DoiTac(MaDT)

ALTER TABLE CN_SP
ADD CONSTRAINT FK__CN_SP__MaCN
FOREIGN KEY (MaCN) references ChiNhanh(MaCN)

ALTER TABLE CN_SP
ADD CONSTRAINT FK__CN_SP__MaSP
FOREIGN KEY (MaSP) references SanPham(MaSP)

ALTER TABLE CT_DonHang
ADD CONSTRAINT FK__CT_DonHang__MaDH 
FOREIGN KEY (MaDH) references DonHang(MaDH)

ALTER TABLE CT_DonHang
ADD CONSTRAINT FK__CT_DonHang__MaSP
FOREIGN KEY (MaSP) references SanPham(MaSP)

ALTER TABLE ThuNhapTX
ADD CONSTRAINT FK__ThuNhapTX__MaTX 
FOREIGN KEY (MaTX) references TaiXe (CMND)

ALTER TABLE ThuNhapTX
ADD CONSTRAINT FK__ThuNhapTX__MaDH
FOREIGN KEY (MaDH) references DonHang(MaDH)

ALTER TABLE TinhTrangDH
ADD CONSTRAINT FK__TinhTrangD__MaDH
FOREIGN KEY (MaDH) references DonHang(MaDH)

ALTER TABLE TinhTrangDH
ADD CONSTRAINT FK__TinhTrangD__MaTT
FOREIGN KEY (MaTT) references CT_TTDH (MaTinhTrang)












insert into KhachHang 
values ('0909123450', N'Trần Văn A', '0909123450', N'34 Trần Văn Giáp', 'abc@gmail.com')
