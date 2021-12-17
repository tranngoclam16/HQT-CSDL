use HT_DHCH_ONLINE
GO

declare @sum int
exec sp_KiemTraSLTon 10, @Tong = @sum output;
select @sum as NumberOfProduct