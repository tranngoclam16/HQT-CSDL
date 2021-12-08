const sql = require('mssql/msnodesqlv8')

const config = {
     user: 'sa',
     password: '123456',
     server: 'localhost',
     driver: 'msnodesqlv8',
     database: 'HT_DHCH_ONLINE',
     options: {
         trustedConnection: true
     }
} 
module.exports=config;


 

