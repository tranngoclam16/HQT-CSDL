var config=require('./db');
const sql=require('mssql/msnodesqlv8');

// create function
//get list bill

async function getKH(MaKH){
    try{
        let pool=await sql.connect(config);
        let products=await pool.request().query("SELECT * FROM KhachHang WHERE MaKH = '" + MaKH + "'");
        console.log(products.recordset)
        return products.recordset;
    }
    catch(error){
        console.log(error);
    }
}

async function addCustomer(dkn){
    try{
        let pool = await sql.connect(config);
        let insertProduct = await pool.request()
        .input('MaKH', sql.VarChar(10), dkn.MaKH)
        .input('Hoten', sql.NVarChar(100), dkn.HoTen)
        .input('DiaChi', sql.NVarChar(100), dkn.DiaChi)
        .input('Email', sql.VarChar(30), dkn.Email)
        .input('Password', sql.VarChar(20), dkn.Password)
        .query("INSERT INTO KhachHang VALUES('" + dkn.MaKH + "', '" + dkn.Password + "', '" + dkn.HoTen + "', '" + dkn.DiaChi + "', '" + dkn.Email + "')");
        return insertProduct.recordsets;
    }
    catch(error){
        console.log(error);
    }
}
async function getProductList(start, num=100){
    console.log(start)
    try{
        let pool=await sql.connect(config);
        length = await pool.request().query("SELECT COUNT(*) FROM SanPham")
        let products=await pool.request().query("SELECT * FROM (SELECT ROW_NUMBER() OVER (ORDER BY MaSP) AS ROWNUMBER, * FROM SanPham)  AS T WHERE T.ROWNUMBER >= "+start+" AND T.ROWNUMBER <" + (parseInt(start)+parseInt(num)));
        //console.log(start)
        //console.log(products.recordsets[0])
        //console.log(length.recordsets[0][0][""])
        return {tableLength: length.recordsets[0][0][""], data: products.recordsets[0]};
    }
    catch(error){
        return error;
    }
}

async function addBill(bill){
    try{
        let pool = await sql.connect(config);
        let insertBill = await pool.request()
        .input('MaKH', sql.VarChar(10), bill.MaKH)
        .input('DiaChi', sql.NVarChar(30), bill.DiaChi)
        .input('Phuong', sql.NVarChar(30), bill.Phuong)
        .input('Quan', sql.NVarChar(30), bill.Quan)
        .input('Tinh', sql.NVarChar(30), bill.Tinh)
        .input('TenNguoiNhan', sql.NVarChar(100), bill.TenNguoiNhan)
        .input('SDT', sql.VarChar(10), bill.SDT)
        .input('ThanhToan', sql.NVarChar(100), bill.ThanhToan)
        .output('MaDonHang')
        .execute('sp_ThemDonHang',async(err,result)=>{
            if (err) {
                
            } else {
                MaDH=result.output.MaDonHang;
                console.log('MaDH:',MaDH)
                for (i=0;i<bill.Products.length;i++){
                    var SL=bill.Products[i].quantity;
                    var MaSP=bill.Products[i].id;
                   // console.log('sp: ',MaSP)
                    let insertP= await pool.request()
                    .input('MaDH',sql.VarChar(10),MaDH)
                    .input('MaSP',sql.VarChar(6),MaSP)
                    .input('SoLuong',sql.Int,SL)
                    .output('error',sql.Int)
                    .execute('sp_ThemChiTietDonHang')
                    
                    //console.log(insertP.output.error)
                    if (insertP.output.error==2){
                        console.log('out of stock');
                        let de=await pool.request()
                        .input('MaDH',sql.VarChar(10),MaDH)
                        .execute('sp_XoaDonHang')
                        break;
                    }           
                }
            }
    })
        return 1;
    }
    catch(error){
        console.log(error);
    }
}


async function addProduct(dkn){
    try{
        let pool = await sql.connect(config);
        let insertProduct = await pool.request()
        .input('TenSP', sql.NVarChar(50), dkn.TenSP)
        .input('GiaBan', sql.Float, dkn.GiaBan)
        .input('SLTon', sql.Int, dkn.SLTon)
        .execute('sp_ThemSanPham')
        return insertProduct.recordsets;
    }
    catch(error){
        console.log(error);
    }
}

async function updateProduct(dkn){
    try{
        let pool = await sql.connect(config);
        let insertProduct = await pool.request()
        .input('MaSP', sql.VarChar(6), dkn.MaSP)
        .input('TenSP', sql.NVarChar(50), dkn.TenSP)
        .input('GiaBan', sql.Float, dkn.GiaBan)
        .input('SLTon', sql.Int, dkn.SLTon)
        .execute('sp_CapNhatSanPham')
        return insertProduct.recordsets;
    }
    catch(error){
        console.log(error);
    }
}

async function addProductToAgent(dkn){
    try{
        let pool = await sql.connect(config);
        let insertProduct = await pool.request()
        /*.input('MaSP', sql.VarChar(6), dkn.MaSP)
        .input('MaCN', sql.VarChar(10), dkn.MaCN)*/
        .query("INSERT INTO CN_SP VALUES('" + dkn.MaCN + "', '" + dkn.MaSP + "')");
        return insertProduct.recordsets;
    }
    catch(error){
        console.log(error);
    }
}

async function getBillList(start, num=100){
    //console.log(start)
    try{
        let pool=await sql.connect(config);
        length = await pool.request().query("SELECT COUNT(*) FROM DonHang")
        let products=await pool.request().query("SELECT * FROM (SELECT ROW_NUMBER() OVER (ORDER BY MaDH) AS ROWNUMBER, * FROM DonHang)  AS T WHERE T.ROWNUMBER >= "+start+" AND T.ROWNUMBER <" + (parseInt(start)+parseInt(num)));
        //console.log(start)
        //console.log(products.recordsets[0])
        //console.log(length.recordsets[0][0][""])
        return {tableLength: length.recordsets[0][0][""], data: products.recordsets[0]};
    }
    catch(error){
        return error;
    }
}

async function getBill(MaDH){
    try{
        let pool=await sql.connect(config);
        let products=await pool.request().query("SELECT * FROM DonHang WHERE MaDH = '" + MaDH + "'");
        //console.log(products.recordset)
        return products.recordset;
    }
    catch(error){
        console.log(error);
    }
}

async function getDetailBill(MaDH){
    try{
        let pool=await sql.connect(config);
        let products=await pool.request().query("SELECT  CTDH.* , SP.TenSP \
            FROM CT_DonHang CTDH join SanPham SP on CTDH.MaSP=SP.MaSP \
            WHERE CTDH.MaDH= '"+MaDH+"'") 
        //console.log(products.recordset)
        return products.recordset;
    }
    catch(error){
        console.log(error);
    }
}

async function getDetailBillStatus(MaDH){
    try{
        let pool=await sql.connect(config);
        let products=await pool.request().query("SELECT  NgayCapNhat,MaTT \
            FROM CT_TTDH\
            WHERE CT_TTDH.MaDH= '"+MaDH+"'") 
        //console.log(products.recordset)
        return products.recordset;
    }
    catch(error){
        console.log(error);
    }
}

async function addBillStatus(bill){
    try{
        let pool = await sql.connect(config);
        console.log(bill)
        let insertStatus = await pool.request()
        .input('MaDH', sql.VarChar(10), bill.MaDH)
        .input('MaTT', sql.Int, bill.MaTT)
        .execute("sp_CapNhatTinhTrangDonHang");
        console.log(insertStatus)
        return insertStatus.recordsets;
    }
    catch(error){
        console.log(error);
    }
}
module.exports={
    getKH:getKH,
    addCustomer:addCustomer,
    getProductList:getProductList,
    addBill:addBill,
    addProduct:addProduct,
    updateProduct:updateProduct,
    addProductToAgent: addProductToAgent,
    getBillList:getBillList,
    getBill:getBill,
    getDetailBill:getDetailBill,
    getDetailBillStatus:getDetailBillStatus,
    addBillStatus:addBillStatus
}
