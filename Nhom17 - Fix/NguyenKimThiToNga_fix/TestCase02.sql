--TEST CASE 02
USE HT_DHCH_ONLINE
GO
CREATE PROCEDURE sp_TaiXeNhanDonHang
            (@MaTX VARCHAR(12),
            @MaDH VARCHAR(10),
			@msg nvarchar(100) output)
AS
BEGIN
	BEGIN TRAN
		BEGIN TRY
		DECLARE @ttdh int, @mota nvarchar(100)
		SELECT @ttdh=MaTT FROM CT_TTDH ttd1 with (XLOCK, ROWLOCK)
        WHERE ttd1.MaDH = @MaDH 
        AND ttd1.NgayCapNhat >= ALL(SELECT ttd2.NgayCapNhat 
                                      FROM CT_TTDH ttd2 WHERE ttd2.MaDH = ttd1.MaDH)
		select @mota = Mota from TinhTrangDH where @ttdh = MaTinhTrang
		select @mota as MoTa
		select @ttdh as TTDH
		IF @ttdh < 3
			BEGIN
				select @msg = N'Đơn hàng chưa sẵn sàng để giao'
				PRINT(N'Đơn hàng chưa sẵn sàng để giao')
          --RAISERROR('1',15,1)
			END
			ELSE 
		IF @ttdh = 3
			BEGIN
			WAITFOR DELAY '00:00:05'
				DECLARE @PhiVanChuyen int
				SET @PhiVanChuyen = (SELECT PhiVanChuyen FROM DonHang WHERE MaDH = @MaDH)
				INSERT INTO ThuNhapTX VALUES (@MaTX, @MaDH, @PhiVanChuyen)

				INSERT INTO CT_TTDH VALUES (GETDATE(), @MaDH, 4)
				select @msg = N'Nhận đơn thành công'
			END
		
			ELSE 
			begin
				select @msg = N'Đơn hàng đã có người nhận' 
				print(N'Đơn hàng đã có người nhận')
			--raiserror('2',15,1);
			end
		COMMIT TRAN
    END TRY
	BEGIN CATCH
			IF @@trancount>0
				BEGIN	
					print(N'Lỗi')
					ROLLBACK TRANSACTION 
				END
	END CATCH
END
GO
--DROP PROCEDURE sp_TaiXeNhanDonHang
--TEST DATA
TRUNCATE TABLE CT_TTDH
TRUNCATE TABLE CT_DonHang
TRUNCATE TABLE ThuNhapTX
DELETE FROM TaiXe
DELETE FROM DonHang
DELETE FROM SanPham
DELETE FROM KhachHang
GO
INSERT KhachHang (MaKH, pword, HoTen, DiaChi, Email) VALUES ('0930123450', '123', N'Huỳnh Tuấn Khoa', N'366 Phan Văn Trị, Phường 5, Quận Gò Vấp, TP. HCM', 'htkhoa@email.com');
GO
INSERT INTO DonHang(MaDH, MaKH) VALUES ('0000000001','0930123450')
GO
INSERT INTO SanPham (MaSP, TenSP, GiaBan, SLTon) VALUES ('000001', N'Áo thun Mickey', 50000, 50);
GO
INSERT INTO CT_DonHang (MaDH, MaSP, SoLuong) VALUES ('0000000001', '000001', 30);
GO
INSERT INTO CT_TTDH (NgayCapNhat, MaDH, MaTT) VALUES (GETDATE(), '0000000001', 3);
GO
INSERT INTO TaiXe (CMND, SDT, pword, HoTen) VALUES
	('012317983262', '012456781', '12345', N'Huỳnh Bá Vỹ'),
	('047733459124', '012456782', '123456', N'Tô Huy Thành')
