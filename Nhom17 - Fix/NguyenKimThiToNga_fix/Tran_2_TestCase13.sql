BEGIN TRAN
UPDATE SanPham set SLTon = 200 where MaSP = '000002'; 
WAITFOR DELAY '00:00:10'
UPDATE SanPham set SLTon = 200 where MaSP = '000001'; 
COMMIT TRAN