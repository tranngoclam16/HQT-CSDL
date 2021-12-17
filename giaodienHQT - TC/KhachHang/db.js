const sql = require('mssql/msnodesqlv8')

const config = {
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


 

