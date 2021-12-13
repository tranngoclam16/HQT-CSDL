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


//----------------------------KHÁCH HÀNG-----------------------------
//signup route
app.get('/SignUpKH', (req, res) => {
    res.sendFile(path.join(staticPath,"SignUp_KH.html"));
})


//let flag = true
app.post('/SignUpKH', (req, res) => {
    let dkn = {...req.body};
    dboperator.getKH(dkn.MaKH).then(result =>{
        console.log(result[0]);
        //console.log(flag)
        if (dkn.MaKH!=result[0].MaKH){
            console.log('valid')
            dboperator.addCustomer(dkn).then(result => {
                res.status(201).json(result);
            })
        }
        else 
        res.status(200).json(result);
    })
    /* let flag = true;
    dboperator.getKH(dkn.MaKH).then(result =>{
        //console.log(result[0]);
        //console.log(flag)
        if (dkn.MaKH.length==result[0].MaKH){
            flag = false;
            //res.json({'alert':'Mật khẩu phải có ít nhất 6 kí tự'})
            //console.log(flag)
        }
    })
    //if(!flag)
        console.log(flag) */
        /*
    if (dkn.MaKH.length != 10 || !Number(dkn.MaKH.length))
        return res.json({'alert':'Số điện thoại không hợp lệ'})
    else if (dkn.Password.length < 6)
        return res.json({'alert':'Mật khẩu phải có ít nhất 6 kí tự'})
    else if(flag){
        console.log('valid')
        
        })
        return res.json({'alert':'Đăng ký tài khoản thành công!'})
    } */
    /* else
        return res.json({'alert':'Số điện thoại đã tồn tại. Vui lòng nhập số khác!'}) */

    /* dboperator.addCustomer(dkn).then(result => {
        res.status(201).json(result);
    }) */
})

//Sign In
app.get('/LogInKH', (req, res) => {
    res.sendFile(path.join(staticPath,"LogIn_KH.html"));
})

app.get('/LogInKH', (req, res) => {
    res.sendFile(path.join(staticPath,"LogIn_KH.html"));
})

//View product
app.get('/KH/ProductList', (req, res) => {
    res.sendFile(path.join(staticPath,"Product_KH.html"));
})

app.post('/KH/ProductList', (req, res) => {
    let start = parseInt(JSON.stringify( req.body))
    //res.json(start)
    if (!start || start<0)
    {
        start = 0
    }
    console.log(typeof start)
    dboperator.getProductList(start,num=100).then(result => {
        res.status(201).json(result);
    })
})
//Add bill
app.post('/KH/bill',(req,res)=>{
    let bill = {...req.body};
    console.log("body")
    console.log(req.body)
     dboperator.addBill(bill).then(result => {
        res.status(201).json(result);
     }) 
 })

/*----------------------- ĐỐI TÁC---------------------------------*/
//View Product
 app.get('/DT/ProductList', (req, res) => {
    res.sendFile(path.join(staticPath,"Product_DT.html"));
})

app.post('/DT/ProductList', (req, res) => {
    let start = parseInt(JSON.stringify( req.body))
    //res.json(start)
    if (!start || start<0)
    {
        start = 0
    }
    console.log(typeof start)
    dboperator.getProductList(start,num=100).then(result => {
        res.status(201).json(result);
    })
})

//Add Product
//Show Add Product Page
app.get('/DT/AddProduct', (req, res) => {
    res.sendFile(path.join(staticPath,"AddProduct.html"));
})
//Add Product
app.post('/DT/AddProduct_add',(req,res)=>{
    let product = {...req.body};
    console.log("body")
    console.log(req.body)
     dboperator.addProduct(product).then(result => {
        res.status(201).json(result);
     }) 
 })

 //Update Product
 //Show Update Product Page
app.get('/DT/UpdateProduct', (req, res) => {
    res.sendFile(path.join(staticPath,"UpdateProduct.html"));
})
//Update Product
app.post('/DT/UpdateProduct_update',(req,res)=>{
    let product = {...req.body};
    console.log("body")
    console.log(req.body)
     dboperator.updateProduct(product).then(result => {
        res.status(201).json(result);
     }) 
 })
 //Add Product to agent
app.post('/DT/UpdateProduct_agent',(req,res)=>{
    let product = {...req.body};
    console.log("body")
    console.log(req.body)
     dboperator.addProductToAgent(product).then(result => {
        res.status(201).json(result);
     }) 
 })
/*router.route('/KH/ProductList').get((request,response)=>{
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
*/

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