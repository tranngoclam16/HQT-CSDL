--TEST CASE 02
CREATE PROCEDURE sp_TaiXeNhanDonHang_TC
            (@MaTX VARCHAR(12),
            @MaDH VARCHAR(10))
AS
BEGIN
  BEGIN TRAN
    BEGIN TRY
	  DECLARE @ttdh int, @mota nvarchar(100)
	  Set @ttdh = (SELECT MaTT FROM TinhTrangDH ttd1 
          WHERE ttd1.MaDH = @MaDH 
            AND ttd1.NgayCapNhat >= ALL(SELECT ttd2.NgayCapNhat 
                                      FROM TinhTrangDH ttd2 WHERE ttd2.MaDH = ttd1.MaDH))
		SET @mota = (select Mota from CT_TTDH where @ttdh = MaTinhTrang)
		print(@mota)
      IF @ttdh <> 3
        BEGIN
          PRINT('1')
          RAISERROR(N'Đơn hàng đang không được chờ vận chuyển',15,1)
        END
      ELSE
        BEGIN
        WAITFOR DELAY '00:00:05'
        DECLARE @PhiVanChuyen int
        SET @PhiVanChuyen = (SELECT PhiVanChuyen FROM DonHang WHERE MaDH = @MaDH)
        if exists (select MaDH from ThuNhapTX where @MaDH = MaDH)
		begin
			print('2')
			raiserror(N'Đơn hàng đã có người nhận',15,1);
		end
		else
		begin
		INSERT INTO ThuNhapTX VALUES (@MaTX, @MaDH, @PhiVanChuyen)

        INSERT INTO TinhTrangDH VALUES (GETDATE(), @MaDH, 4)
		end
        END
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
--DROP PROCEDURE sp_TaiXeNhanDonHang_TC
--TEST DATA
TRUNCATE TABLE TinhTrangDH
TRUNCATE TABLE CT_DonHang
TRUNCATE TABLE ThuNhapTX
DELETE FROM TaiXe
DELETE FROM DonHang
DELETE FROM SanPham
TRUNCATE TABLE KhachHang
GO
INSERT KhachHang (MaKH, HoTen, SDT, DiaChi, Email) VALUES ('0930123450', N'Huỳnh Tuấn Khoa', '0930123451', N'366 Phan Văn Trị, Phường 5, Quận Gò Vấp, TP. HCM', 'htkhoa@email.com');
GO
INSERT INTO DonHang(MaDH, MaKH) VALUES ('0000000001','0930123450')
GO
INSERT INTO SanPham (MaSP, TenSP, GiaBan, SLTon) VALUES ('000001', N'Áo thun Mickey', 50000, 50);
GO
INSERT INTO CT_DonHang (MaDH, MaSP, SoLuong) VALUES ('0000000001', '000001', 30);
GO
INSERT INTO TinhTrangDH (NgayCapNhat, MaDH, MaTT) VALUES (GETDATE(), '0000000001', 3);
GO
INSERT INTO TaiXe (CMND, HoTen) VALUES
	('012317983262', N'Huỳnh Bá Vỹ'),
	('047733459124', N'Tô Huy Thành')
