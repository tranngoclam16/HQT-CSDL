Use HT_DHCH_ONLINE
GO
declare @msg nvarchar(100)
EXEC sp_TaiXeNhanDonHang_TC '012456782', '0000000001',@msg=@msg output
SELECT @msg