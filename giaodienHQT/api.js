var Db= require('./public/js/db');
var config=require('./public/js/db');
const sql=require('mssql/msnodesqlv8');
const dboperator=require('./public/js/dboperator');


var express = require('express');
var bodyParser = require('body-parser');
var cors = require('cors');
var morgan=require('morgan');
var path=require('path');
var app = express();
var router = express.Router();

app.use(morgan('dev'));


app.get('/',(reg,res)=>{
    res.json({
        msg:'root'
    });
})

app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json());
app.use(cors());

app.use(express.json());
app.use('/api', router);

router.use((request,response,next)=>{
   console.log('middleware');
   next();
})

app.use(express.static)


router.route('/KH/login/:username').get((request,response)=>{
    dboperator.getKH(request.params.username).then(result =>{
        console.log(result[0]);
        response.json(result);
    })
})
router.route('/SignUpKH').post((request,response)=>{
    
    let dkn = {...request.body};
    console.log(request.body)
     dboperator.addCustomer(dkn).then(result => {
        response.status(201).json(result);
     }) 
 })
 router.route('/KH/ProductList').get((request,response)=>{
    var start = request.query['start']
    if (!start || start<0)
    {
        start = 0
    }
    console.log(start)
    dboperator.getProductList(start,num=100).then(result => {
       response.json(result);
    })

})
router.route('/KH/bill').post((request,response)=>{
    let bill = {...request.body};
    console.log("body")
    console.log(request.body)
     dboperator.addBill(bill).then(result => {
        response.status(201).json(result);
     }) 
 })
/*
router.route('/billinfo').get((request,response)=>{
    var MaHD = request.query['MaHD']
    dboperator.getBill(MaHD).then(result => {
       response.json(result);
    })
})

router.route('/bill_month/:year').get((request,response)=>{
    dboperator.invoiceStatisticMonth(request.params.year).then(result =>{
        console.log(result[0]);
        response.json(result);
    })
})

router.route('/bill').post((request,response)=>{
    
   let bill = {...request.body};
   console.log(request.body)
    dboperator.addBill(bill).then(result => {
       response.status(201).json(result);
    }) 
})

router.route('/detailBill').post((request,response)=>{
    
    let dbill = {...request.body};
    console.log(request.body)
     dboperator.addDetailBill(dbill).then(result => {
        response.status(201).json(result);
     }) 
 })

 router.route('/detailBill').get((request,response)=>{
    
    var start = request.query['start']
    var MaHD = request.query['MaHD']
    console.log(start)
    console.log(MaHD)
    if (!start || start<0)
        start = 0
    dboperator.getDetailBill(start, MaHD).then(result => {
       response.json(result);
    })
 })
*/
//var port = process.env.PORT || 3000;
app.listen(3000, () => {
  console.log(`listenning on port 3000`);
})