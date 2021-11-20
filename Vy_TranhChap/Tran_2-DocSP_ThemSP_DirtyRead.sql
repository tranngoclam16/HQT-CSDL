--TC5
begin tran
	waitfor delay '00:00:09'
	select * from SanPham with (nolock)
COMMIT