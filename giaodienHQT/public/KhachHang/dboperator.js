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

module.exports={
    getKH:getKH
}
