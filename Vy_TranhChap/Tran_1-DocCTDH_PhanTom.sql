Begin tran
	select TongHang from DonHang where MaDH='0000000001'
	waitfor delay '00:00:09'
	select * from CT_DonHang where MaDH='0000000001'
commit TRAN