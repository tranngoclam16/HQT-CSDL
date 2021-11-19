CREATE PROCEDURE sp_TaiXeHuyNhanDonHang_tc
            (@MaTX VARCHAR(12),
            @MaDH VARCHAR(10))
AS
BEGIN
  BEGIN TRAN
    BEGIN TRY
      IF (SELECT MaTT FROM TinhTrangDH ttd1 
          WHERE ttd1.MaDH = @MaDH 
            AND ttd1.NgayCapNhat > ALL(SELECT ttd2.NgayCapNhat 
                                      FROM TinhTrangDH ttd2 WHERE ttd2.MaDH = ttd1.MaDH)) <> 4
        BEGIN
          PRINT('1')
          RAISERROR(N'Đơn hàng đang không được vận chuyển',15,1)
        END
      ELSE
        BEGIN
        DELETE FROM ThuNhapTX WHERE MaDH = @MaDH AND MaTX = @MaTX

        INSERT INTO TinhTrangDH VALUES (GETDATE(), @MaDH, 3)
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
--DROP PROCEDURE sp_TaiXeHuyNhanDonHang_tc