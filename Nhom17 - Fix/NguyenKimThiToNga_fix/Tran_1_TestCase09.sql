USE HT_DHCH_ONLINE
GO
BEGIN TRAN
UPDATE SanPham WITH (TABLOCK,HOLDLOCK) set SLTon = 100 where MaSP = '000001'; 
WAITFOR DELAY '00:00:10'
UPDATE SanPham set SLTon = 100 where MaSP = '000002'; 
COMMIT TRAN