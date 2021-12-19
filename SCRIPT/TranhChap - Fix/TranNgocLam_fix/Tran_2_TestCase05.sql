USE HT_DHCH_ONLINE
Go

begin tran
select * from CT_TTDH where MaDH='0000000001'
commit tran


