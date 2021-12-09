const sql = require('mssql/msnodesqlv8')

const config = {
    /* user: 'sa',
     password: '123456',*/
     //db bên khách hàng
     user: 'kh',
     password: 'kh',
     server: 'localhost',
     driver: 'msnodesqlv8',
     database: 'HT_DHCH_ONLINE',
     options: {
         trustedConnection: true
     }
} 
module.exports=config;


 

