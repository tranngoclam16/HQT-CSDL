//const { is } = require("express/lib/request")
//const { response } = require("express");

registerTX_btn.addEventListener('click',() => {
    let objToPost = { 
       /*  MaKH: $('#MaKH').val(),
        HoTen: $('#HoTen').val(),
        DiaChi: $('#DiaChi').val(),
        Email: $('#Email').val(),
        Password: $('#Password').val() */

        CMND:$('#CMND').val(),
        SDT:$('#SDT').val(),
        pword:$('#Password').val(),
        Hoten:$('#HoTen').val(),
        DiaChi:$('#DiaChi').val(),
        BienSoXe:$('#BienSoXe').val(),
        KVHoatDong:$('#KVHoatDong').val(),
        Email:$('#Email').val(),
        STK:$('#STK').val(),
        NganHang:$('#NganHang').val(),
        ChiNhanh:$('#ChiNhanh').val()
    }
    console.log(objToPost)
    console.log(objToPost.CMND.length !=12 && objToPost.CMND.length !=10)
    if (objToPost.CMND.length !=12 && objToPost.CMND.length !=10)
        alert("Chứng minh nhân dân không hợp lệ")
    else if (objToPost.Hoten.length < 1)
        alert("Vui lòng nhập họ tên")
    else if (objToPost.SDT.length != 10 || !Number(objToPost.SDT.length))
        alert("Số điện thoại không hợp lệ")
    else if (objToPost.pword.length < 6)
        alert("Mật khẩu phải có ít nhất 6 kí tự!")
    else 
        senData('http://localhost:3000/SignUpTX', objToPost)
})

//alert function
const showAlert = (msg) => {
    let alertBox = document.querySelector('.alert-box')
    let alertMsg = document.querySelector('alert-msg')
    alertMsg.innerHTML = msg;
    alertBox.classList.add('show');
    setTimeout(()=> {
        alertBox.classList.remove('show')
    },3000)
}
const senData = (path, data) => {
    fetch(path, {
        method: 'post',
        headers: new Headers({'Content-Type': 'application/json'}),
        body: JSON.stringify(data)
    })
    .then (response => {
        response.json().then((data)=>{
            console.log(data)
            processData(data)
        })    
    })
}

const processData = (data)=> {
    //console.log(data)
    if(data.alert){
        alert(data.alert)
    } 
    else if (data.SDT){
        alert('Đăng ký thành công')
        sessionStorage.user=JSON.stringify(data)
        location.replace('/TX/BillList')
    }
}