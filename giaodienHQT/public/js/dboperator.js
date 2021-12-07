var config=require('./db');
const sql=require('mssql/msnodesqlv8');

// create function
//get list bill

async function getKH(MaKH){
    try{
        let pool=await sql.connect(config);
        let products=await pool.request().query("SELECT * FROM KhachHang WHERE MaKH = '" + MaKH + "'");
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
    try{
        let pool=await sql.connect(config);
        length = await pool.request().query("SELECT COUNT(*) FROM SANPHAM")
        let products=await pool.request().query("SELECT * FROM (SELECT ROW_NUMBER() OVER (ORDER BY MaSP) AS ROWNUMBER, * FROM SanPham)  AS T WHERE T.ROWNUMBER >= "+start+" AND T.ROWNUMBER <" + (parseInt(start)+parseInt(num)));
        console.log(start)
        console.log((parseInt(start)+parseInt(num)))
        //let products=await pool.request().query("SELECT * FROM (SELECT ROW_NUMBER() OVER (ORDER BY MaSP) AS ROWNUMBER, * FROM SanPham)  AS T WHERE T.ROWNUMBER >= 0 AND T.ROWNUMBER <100")
        return {tableLength: length.recordsets[0][0][""], data: products.recordsets[0]};
  
    }
    catch(error){
        console.log(error);
    }
}
module.exports={
    getKH:getKH,
    addCustomer:addCustomer,
    getProductList:getProductList
}
