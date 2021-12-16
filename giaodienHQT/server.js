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
    console.log(dkn.MaKH)
    dboperator.getKH(dkn.MaKH).then(result =>{
        console.log(result[0]);
        //console.log(flag)
        if (result[0]==null){
            console.log('valid')
            dboperator.addCustomer(dkn).then(result => {
                res.json(dkn);
            })
        }
        else 
        res.json({'alert':'Số điện thoại đã tồn tại. Vui lòng nhập số điện thoại khác!'});
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
})

//Sign In
app.get('/LogInKH', (req, res) => {
    res.sendFile(path.join(staticPath,"LogIn_KH.html"));
})

/* app.post('/LogInKH', (req, res) => {
    let username = {...req.body}
    console.log(req.body)
    console.log(username)
   /*  dboperator.getKH(request.params.username).then(result =>{
        console.log(result[0]);
        response.json(result);
    })
}) */

app.post('/LogInKH', (req, res) => {
    let {username, password} = req.body;
    //console.log(dkn.username)
    //console.log(kh.username)
    dboperator.getKH(username).then(result =>{
        console.log(result);
        if (result.length>0){
            if (username==result[0].MaKH)
                if (password==result[0].pword){
                    //console.log(data[0]);
                    //return res.json({'alert':'Đăng nhập thành công'})
                    return res.json(result)
                    //alert("Đăng nhập thành công")
                    //window.location='http://localhost:3000'
                }
                else{
                    return res.json({'alert':'Sai tên đăng nhập hoặc mật khẩu. Bạn vui lòng thử lại.'})
                    /* console.log("password is false");
                    alert("Sai tên đăng nhập hoặc mật khẩu. Bạn vui lòng thử lại.") */
                }
            else{
                return res.json({'alert':'Sai tên đăng nhập hoặc mật khẩu. Bạn vui lòng thử lại.'})
                /* console.log("password is false");
                alert("Sai tên đăng nhập hoặc mật khẩu. Bạn vui lòng thử lại.") */
            }
        }
        else {
            return res.json({'alert':'Tài khoản đăng nhập không tồn tại.'})
            /* console.log("username false")
            alert("Tài khoản đăng nhập không tồn tại.") */
        }  
          
    });
    
});


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
    //console.log(typeof start)
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

//View Bill List
app.get('/KH/Info', (req, res) => {
    res.sendFile(path.join(staticPath,"BillList_KH.html"));
})
app.post('/KH/Info', (req, res) => {
    let start = (req.body['start'])
    dboperator.getKH(start).then(result => {
       res.status(201).json(result);
    })
})
app.post('/KH/InfoBill', (req, res) => {
    let start = (req.body['start'])
    let makh = (req.body['MaKH'])
    //res.json(start)
    if (!start || start<0)
    {
        start = 0
    }
    dboperator.getCustomerBillList(start,makh).then(result => {
        res.status(201).json(result);
    })
})
app.get('/KH/billinfo', (req, res) => {
    res.sendFile(path.join(staticPath,"billinfo_KH.html"));
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
         console.log(result)
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

//View Bill List
app.get('/DT/BillList', (req, res) => {
    res.sendFile(path.join(staticPath,"BillList_DT.html"));
})

app.post('/DT/BillList', (req, res) => {
    let start = parseInt(JSON.stringify( req.body))
    //res.json(start)
    if (!start || start<0)
    {
        start = 0
    }
    console.log(typeof start)
    dboperator.getBillList(start,num=100).then(result => {
        res.status(201).json(result);
    })
})
/*SỬA MẤY CÁI NÀY TRONG API*/
//show page billinfo
app.get('/DT/billinfo', (req, res) => {
    res.sendFile(path.join(staticPath,"billinfo_DT.html"));
})
//View bill info
//View bill detail
//View bill status
//Update bill status
app.post('/DT/billStatusUpdate',(req,res)=>{
    let bill = {...req.body};
     dboperator.addBillStatus(bill).then(result => {
        res.status(201).json(result);
     }) 
 })

//Check Product Page
 app.get('/DT/CheckProduct', (req, res) => {
    res.sendFile(path.join(staticPath,"CheckProduct_DT.html"));
})
//Check SLTon
app.post('/DT/CheckProduct',(req,res)=>{
    let start = parseInt(req.body['start'])
    //console.log(req.body['start'])
    //console.log("product:",start)
     dboperator.checkProductSLT(start).then(result => {
         //console.log(result)
        res.status(201).json(result);
     }) 
 })
 //Check Price
app.post('/DT/CheckProductPrice',(req,res)=>{
    let start = parseInt(req.body['start'])
     dboperator.checkProductPrice(start).then(result => {
        res.status(201).json(result);
     }) 
 })

app.listen(3000, () => {
  console.log(`listenning on port 3000`);
})
/*---------------------------------------TÀI XẾ------------------------------------------*/
//View Bill List
app.get('/TX/BillList', (req, res) => {
    res.sendFile(path.join(staticPath,"BillList_TX.html"));
})

app.post('/TX/BillList', (req, res) => {
    let start = parseInt(JSON.stringify( req.body))
    //res.json(start)
    if (!start || start<0)
    {
        start = 0
    }
    console.log(typeof start)
    dboperator.getBillList(start,num=100).then(result => {
        res.status(201).json(result);
    })
})
//Add Shipping
app.post('/TX/AddShipping',(req,res)=>{
    let bill = {...req.body};
     dboperator.addShipping(bill).then(result => {
        res.status(201).json(result);
     }) 
 })
 //View Info
app.get('/TX/Info', (req, res) => {
    res.sendFile(path.join(staticPath,"Info_TX.html"));
})