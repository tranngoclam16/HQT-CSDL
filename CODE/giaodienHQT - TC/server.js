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
})

//Sign In
app.get('/LogInKH', (req, res) => {
    res.sendFile(path.join(staticPath,"LogIn_KH.html"));
})



app.post('/LogInKH', (req, res) => {
    let {username, password} = req.body;
    dboperator.getKH(username).then(result =>{
        //console.log(result);
        if (result.length>0){
            if (username==result[0].MaKH)
                if (password==result[0].pword){
                    return res.json(result[0])
                }
                else{
                    return res.json({'alert':'Sai tên đăng nhập hoặc mật khẩu. Bạn vui lòng thử lại.'})
                }
            else{
                return res.json({'alert':'Sai tên đăng nhập hoặc mật khẩu. Bạn vui lòng thử lại.'})
            }
        }
        else {
            return res.json({'alert':'Tài khoản đăng nhập không tồn tại.'})
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
       // sessionStorage['notify'] = sessionStorage['notify'] ? sessionStorage['notify'] : ""
       console.log(result)
       if(result==1)
        res.json('Đặt hàng thành công.');
       else if (result==2)
        res.json('Số lượng đặt vượt quá số lượng trong kho');
        else res.json('Lỗi');
        /* console.log(result)
        res.json(result); */
     }) 
 })

//View Bill List
app.get('/KH/Info', (req, res) => {
    res.sendFile(path.join(staticPath,"BillList_KH.html"));
})
app.post('/KH/Info', (req, res) => {
    let MaKH = req.body['MaKH']
    console.log(MaKH)
    dboperator.getKH(MaKH).then(result => {
        console.log(result)
        res.json(result);
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
        console.log(result)
        res.json(result);
    })
})
app.get('/KH/billinfo/:MaDH', (req, res) => {
    res.sendFile(path.join(staticPath,"billinfo_KH.html"));
})

//Check Product Page
app.get('/KH/CheckProduct', (req, res) => {
    res.sendFile(path.join(staticPath,"CheckProduct_KH.html"));
})
//Check 
app.post('/KH/CheckProduct',(req,res)=>{
    let MaSP = (req.body['MaSP'])
    let TenSP = (req.body['TenSP'])
     dboperator.CheckProductKH(MaSP,TenSP).then(result => {
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
app.get('/DT/billinfo/:MaDH', (req, res) => {
    res.sendFile(path.join(staticPath,"billinfo_DT.html"));
})

//View bill info
app.post('/DT/billinfo',(req,res)=>{
    let MaDH = {...req.body}
    dboperator.getBill(MaDH.MaDH).then(result => {
       res.json(result);
    })
})

//View bill detail
app.post('/DT/detailBill', (req,res)=>{
    let MaDH = {...req.body}
    dboperator.getDetailBill(MaDH.MaDH).then(result => {
        //console.log('Detail bill')
        //console.log(result)
        res.json(result);
    })
 })
//View bill status
app.post('/DT/detailBillStatus',(req,res)=>{
    let MaDH = {...req.body}
   dboperator.getDetailBillStatus(MaDH.MaDH).then(result => {
       //console.log('bill status')
       //console.log(result)
      res.json(result);
   })
})
//Update bill status
app.post('/DT/billStatusUpdate',(req,res)=>{
    let bill = {...req.body};
    console.log(bill)
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
    console.log("product:",start)
     dboperator.checkProductSLT(start).then(result => {
        console.log(result)
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
//
app.get('/SignUpTX', (req, res) => {
    res.sendFile(path.join(staticPath,"SignUp_TX.html"));
})

//let flag = true
app.post('/SignUpTX', (req, res) => {
    let dkn = {...req.body};
    console.log(dkn.SDT)
    dboperator.chechDriverExist(dkn).then(result =>{
        console.log(result);
        if (result[0]==null){
            console.log('valid')
            dboperator.addTX(dkn).then(result => {
                res.json(dkn);
            })
        }
        else if (result[0].CMND == dkn.CMND)
            res.json({'alert':'CMND đã được sử dụng. Vui lòng nhập số CMND khác!'});
        else 
        res.json({'alert':'Số điện thoại đã tồn tại. Vui lòng nhập số điện thoại khác!'});
    })
})

//Sign In
app.get('/LogInTX', (req, res) => {
    res.sendFile(path.join(staticPath,"LogIn_TX.html"));
})

app.post('/LogInTX', (req, res) => {
    let {username, password} = req.body;
    //console.log(username)
    dboperator.getDriver(username).then(result =>{
        console.log(result);
        if (result.length>0){
            if (username==result[0].SDT)
                if (password==result[0].pword){
                    return res.json(result[0])
                }
                else{
                    return res.json({'alert':'Sai tên đăng nhập hoặc mật khẩu. Bạn vui lòng thử lại.'})
                }
            else{
                return res.json({'alert':'Sai tên đăng nhập hoặc mật khẩu. Bạn vui lòng thử lại.'})
            }
        }
        else {
            return res.json({'alert':'Tài khoản đăng nhập không tồn tại.'})
        }  
          
    });
    
});

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
    dboperator.getBillForDelivery(start,num=100).then(result => {
        res.status(201).json(result);
    })
})
//Add Shipping
app.post('/TX/AddShipping',(req,res)=>{
    let bill = {...req.body};
     dboperator.addShipping(bill).then(result => {
        res.json(result);
     }) 
 })
 //View Info
app.get('/TX/Info', (req, res) => {
    res.sendFile(path.join(staticPath,"Info_TX.html"));
})
app.post('/TX/Info', (req, res) => {
    let MaTX = (req.body['MaTX'])
    console.log("tx: ",MaTX)
    dboperator.getDriver(MaTX).then(result => {
       console.log(result)
       res.status(201).json(result);
    })
})
app.post('/TX/InfoBill', (req, res) => {
    let start = (req.body['start'])
    let matx = (req.body['MaTX'])
    //res.json(start)
    if (!start || start<0)
    {
        start = 0
    }
    dboperator.getDriverBillList(start,matx).then(result => {
        res.status(201).json(result);
    })
})
//Update bill status
app.post('/TX/billStatusUpdate',(req,res)=>{
    let bill = {...req.body};
     dboperator.addBillStatus(bill).then(result => {
        res.status(201).json(result);
     }) 
 })