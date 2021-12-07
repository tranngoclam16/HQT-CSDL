var Db= require('./public/js/db');
var config=require('./public/js/db');
const sql=require('mssql/msnodesqlv8');
const dboperator=require('./public/js/dboperator');


const express = require('express');
const bodyParser = require('body-parser');
const cors = require('cors');
const morgan=require('morgan');
const path=require('path');
const app = express();
var router = express.Router();

app.use(morgan('dev'));

let staticPath = path.join(__dirname, "public")



app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json());
app.use(cors());

app.use(express.json());
/*app.use('/api', router); */



app.use(express.static(staticPath));
// call  function

app.get('/',(reg,res)=>{
    res.sendFile(path.join(staticPath,"index1.html"));
})

//signup route
app.get('/SignUpKH', (req, res) => {
    res.sendFile(path.join(staticPath,"SignUp_KH.html"));
})

app.post('/SignUpKH', (req, res) => {
    let dkn = {...req.body};
    console.log(req.body)
     dboperator.addCustomer(dkn).then(result => {
        res.status(201).json(result);
     }) 
})

/* router.route('/KH/login/:username').get((request,response)=>{
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
 }) */
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

app.listen(3000, () => {
  console.log(`listenning on port 3000`);
})