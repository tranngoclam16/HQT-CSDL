--TC6
Begin tran
waitfor delay '00:00:07'
select * from SanPham with (nolock)
COMMIT