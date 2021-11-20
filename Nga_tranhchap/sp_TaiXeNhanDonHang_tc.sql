CREATE PROCEDURE sp_TaiXeNhanDonHang_TC
            (@MaTX VARCHAR(12),
            @MaDH VARCHAR(10))
AS
BEGIN
  BEGIN TRAN
    BEGIN TRY
      IF (SELECT MaTT FROM TinhTrangDH ttd1 
          WHERE ttd1.MaDH = @MaDH 
            AND ttd1.NgayCapNhat > ALL(SELECT ttd2.NgayCapNhat 
                                      FROM TinhTrangDH ttd2 WHERE ttd2.MaDH = ttd1.MaDH)) <> 3
        BEGIN
          PRINT('1')
          RAISERROR(N'Đơn hàng đang không được chờ vận chuyển',15,1)
        END
      ELSE
        BEGIN
        WAITFOR DELAY '00:00:05'
        DECLARE @PhiVanChuyen int
        SET @PhiVanChuyen = (SELECT PhiVanChuyen FROM DonHang WHERE MaDH = @MaDH)
        INSERT INTO ThuNhapTX VALUES (@MaTX, @MaDH, @PhiVanChuyen)

        INSERT INTO TinhTrangDH VALUES (GETDATE(), @MaDH, 4)
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