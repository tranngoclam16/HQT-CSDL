﻿Use HT_DHCH_ONLINE
go

--TestCase06
--Transaction 1
declare @sum int
exec sp_KiemTraGiaBan_TC 100000, @Tong = @sum output
select @sum as TongSoSanPham