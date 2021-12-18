Use HT_DHCH_ONLINE
go

--TestCase09
--Transaction 1
declare @sum int
exec sp_KiemTraGiaBan 100000, @Tong = @sum output
select @sum as NumberOfColumn