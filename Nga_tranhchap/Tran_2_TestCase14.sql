BEGIN TRAN
UPDATE SanPham set SLTon=2000; 
WAITFOR DELAY '00:00:07'; 
UPDATE DonHang set MaKH = '0930123453'; 
COMMIT TRAN
