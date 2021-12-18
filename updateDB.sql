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


create procedure sp_getBillForDeliver
	(@start int, @num int, @tong int output)
as
begin
	--declare @tong int
	
	select MaDH into #tblTemp
	from CT_TTDH 
	group by MaDH
	having max(MaTT) = 3
	select @tong = count(*) 
	from DonHang DH join #tblTemp as T on T.MaDH=DH.MaDH
	SELECT * 
	FROM (SELECT ROW_NUMBER() OVER (ORDER BY DonHang.MaDH) AS ROWNUMBER, DonHang.MaDH, MaKH, DiaChi, Phuong, Quan, Tinh, TenNguoiNhan, SDT, convert(varchar, NgayLap, 113) as NgayLap, PhiVanChuyen, TongHang, TongTien, ThanhToan
         FROM DonHang join #tblTemp temp on temp.MaDH = DonHang.MaDH)  AS T WHERE T.ROWNUMBER >= @start AND T.ROWNUMBER < (@start+@num)
	return 
	
end
go
declare @sum int
exec sp_getBillForDeliver 0,100,@tong = @sum output
select @sum

declare @error nvarchar(100)
exec sp_TaiXeNhanDonHang '0000000003', '0930000000', @msg=@error output
select @error

select * 
from CT_TTDH
where MaDH='0000000003'