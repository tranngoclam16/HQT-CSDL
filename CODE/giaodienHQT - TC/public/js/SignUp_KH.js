//const { is } = require("express/lib/request")
//const { response } = require("express");

registerKH_btn.addEventListener('click',() => {
    let objToPost = { 
        MaKH: $('#MaKH').val(),
        HoTen: $('#HoTen').val(),
        DiaChi: $('#DiaChi').val(),
        Email: $('#Email').val(),
        Password: $('#Password').val()
    }
    console.log(objToPost)
    if (objToPost.MaKH.length != 10 || !Number(objToPost.MaKH.length))
        alert("Số điện thoại không hợp lệ")
    else if (objToPost.Password.length < 6)
        alert("Mật khẩu phải có ít nhất 6 kí tự!")
    else 
        senData('http://localhost:3000/SignUpKH', objToPost)
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
    else if (data.MaKH){
        alert('Đăng ký thành công')
        sessionStorage.user=JSON.stringify(data)
        location.replace('/')
    }
}