USE HT_DHCH_ONLINE
GO

CREATE PROC sp_CreateAccount_DT
	--@MaDT varchar(10),
	@MSThue varchar(10),
	@TenDT nvarchar(100),
	@TenNgDaiDien nvarchar(100),
	@ThanhPho nvarchar(50),
	@Quan nvarchar(30),
	@SoChiNhanh int,
	@SoLuongDH int,
	@LoaiHang nvarchar(100),
	@DiaChi nvarchar(200),
	@SDT varchar(10),
	@Email varchar(30),
	@PASS varchar(50),
	@ROLE varchar(50),
	@err int output
AS
BEGIN
	BEGIN TRANSACTION
		BEGIN TRY
			waitfor delay '00:00:05'
			declare @ma_count bigint,@MaDT varchar(10)
		
			set @MaDT=(select TOP 1 (MaDT) from DoiTac  order by MaDT DESC)
			
			if (isnull(@MaDT,'false')<>'false')
			begin
				set @ma_count=cast (@MaDT as bigint)+1
			end
			else
			begin
				set @ma_count=1 
			end
			set @MaDT = RIGHT('000000000'+CAST(@ma_count AS VARCHAR(10)), 10)
			waitfor delay '00:00:02'
			
			print @MaDT

			DECLARE @SQL NVARCHAR(4000);
			DECLARE @LGNAME VARCHAR(10)=@MaDT;
			SET @SQL=('CREATE LOGIN ' + QUOTENAME(@LGNAME) + ' WITH PASSWORD = ' + quotename(@PASS, '''')+', DEFAULT_DATABASE=[HT_DHCH_ONLINE], CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF;')
			EXEC(@SQL);

			SET @SQL=('CREATE USER ' + QUOTENAME(@LGNAME) + ' FOR LOGIN ' + quotename(@LGNAME)+' WITH DEFAULT_SCHEMA=[dbo];')
			EXEC(@SQL)

			SET @SQL='ALTER ROLE ' + QUOTENAME(@ROLE)+ ' ADD MEMBER '+QUOTENAME(@LGNAME);
			EXECUTE sp_executesql @SQL;

			INSERT INTO DoiTac VALUES (@MaDT, @MSThue, @TenDT, @TenNgDaiDien, @ThanhPho, @Quan, @SoChiNhanh, @SoLuongDH, @LoaiHang, @DiaChi, @SDT, @Email); 
		COMMIT TRANSACTION
		END TRY
		BEGIN CATCH
		IF @@trancount>0
			BEGIN	
				set @err=@@trancount
				print('loi')
				ROLLBACK TRANSACTION 
			END
	END CATCH
END;
GO




CREATE PROC sp_CreateAccount_TX
	@CMND varchar(12),
	@HoTen nvarchar(100),
	@SDT varchar (10),
	@DiaChi nvarchar(100),
	@BienSoXe nvarchar(12),
	@KVHoatDong nvarchar(30),
	@Email varchar(30),
	@STK varchar(15),
	@NganHang nvarchar(30),
	@ChiNhanh nvarchar(30),
	@PASS varchar(50),
	@ROLE varchar(50),
	@err int output
AS
BEGIN
	BEGIN TRANSACTION
		BEGIN TRY
			DECLARE @SQL NVARCHAR(4000);
			DECLARE @LGNAME VARCHAR(10)=@CMND;
			SET @SQL=('CREATE LOGIN ' + QUOTENAME(@LGNAME) + ' WITH PASSWORD = ' + quotename(@PASS, '''')+', DEFAULT_DATABASE=[HT_DHCH_ONLINE], CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF;')
			EXEC(@SQL);

			SET @SQL=('CREATE USER ' + QUOTENAME(@LGNAME) + ' FOR LOGIN ' + quotename(@LGNAME)+' WITH DEFAULT_SCHEMA=[dbo];')
			EXEC(@SQL)

			SET @SQL='ALTER ROLE ' + QUOTENAME(@ROLE)+ ' ADD MEMBER '+QUOTENAME(@LGNAME);
			EXECUTE sp_executesql @SQL;

			INSERT INTO TaiXe VALUES (@CMND, @HoTen, @SDT, @DiaChi, @BienSoXe, @KVHoatDong, @Email, @STK, @NganHang, @ChiNhanh); 
		COMMIT TRANSACTION
		END TRY
		BEGIN CATCH
		IF @@trancount>0
			BEGIN	
				set @err=@@trancount
				print('loi')
				ROLLBACK TRANSACTION 
			END
	END CATCH
END;
GO

CREATE PROC sp_CreateAccount_KH
	@MaKH varchar(10),
	@HoTen nvarchar(50),
	@SDT varchar (10),
	@DiaChi nvarchar(100),
	@Email varchar(30),
	@PASS varchar(50),
	@ROLE varchar(50),
	@err int output
AS
BEGIN
	BEGIN TRANSACTION
		BEGIN TRY
			DECLARE @SQL NVARCHAR(4000);
			DECLARE @LGNAME VARCHAR(10)=@MaKH;
			SET @SQL=('CREATE LOGIN ' + QUOTENAME(@LGNAME) + ' WITH PASSWORD = ' + quotename(@PASS, '''')+', DEFAULT_DATABASE=[HT_DHCH_ONLINE], CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF;')
			EXEC(@SQL);

			SET @SQL=('CREATE USER ' + QUOTENAME(@LGNAME) + ' FOR LOGIN ' + quotename(@LGNAME)+' WITH DEFAULT_SCHEMA=[dbo];')
			EXEC(@SQL)

			SET @SQL='ALTER ROLE ' + QUOTENAME(@ROLE)+ ' ADD MEMBER '+QUOTENAME(@LGNAME);
			EXECUTE sp_executesql @SQL;

			INSERT INTO KhachHang VALUES (@MaKH, @HoTen, @SDT, @DiaChi, @Email); 
		COMMIT TRANSACTION
		END TRY
		BEGIN CATCH
		IF @@trancount>0
			BEGIN	
				set @err=@@trancount
				print('loi')
				ROLLBACK TRANSACTION 
			END
	END CATCH
END;
GO

CREATE PROC sp_CreateAccount_NV
	@MaNV varchar(10),
	@PASS varchar(50),
	@ROLE varchar(50),
	@err int output
AS
BEGIN
	BEGIN TRANSACTION
		BEGIN TRY
			DECLARE @SQL NVARCHAR(4000);
			DECLARE @LGNAME VARCHAR(13)='NV'+@MaNV;
			SET @SQL=('CREATE LOGIN ' + QUOTENAME(@LGNAME) + ' WITH PASSWORD = ' + quotename(@PASS, '''')+', DEFAULT_DATABASE=[HT_DHCH_ONLINE], CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF;')
			EXEC(@SQL);

			SET @SQL=('CREATE USER ' + QUOTENAME(@LGNAME) + ' FOR LOGIN ' + quotename(@LGNAME)+' WITH DEFAULT_SCHEMA=[dbo];')
			EXEC(@SQL)

			SET @SQL='ALTER ROLE ' + QUOTENAME(@ROLE)+ ' ADD MEMBER '+QUOTENAME(@LGNAME);
			EXECUTE sp_executesql @SQL;

		COMMIT TRANSACTION
		END TRY
		BEGIN CATCH
		IF @@trancount>0
			BEGIN	
				set @err=@@trancount
				print('loi')
				ROLLBACK TRANSACTION 
			END
	END CATCH
END;
GO