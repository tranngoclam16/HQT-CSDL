Use HT_DHCH_ONLINE
go

--TestCase09
--Transaction 1
declare @sum int
exec sp_KiemTraGiaBan_TC 100000, @Tong = @sum output
select @sum as NumberOfColumn