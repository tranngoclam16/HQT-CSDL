//api
function fetchData (value) {
    console.log(value)
   // console.log("url:",url)
    fetch('/DT/billinfo', {
            method: 'POST',
            headers: new Headers({'Content-Type': 'application/json'}),
            credentials: 'include',
            body: JSON.stringify({MaDH: value})
    })
    .then(response => {
        if (response.ok) {
            return response.json();
        } else {
            throw new Error(response.statusText);
        }
    })
    .then(data => {
        data = data[0];
        //console.log(data)
        document.getElementById('template-MaDH').innerHTML = data["MaDH"];
        document.getElementById('template-MaKH').innerHTML = data["MaKH"];
        document.getElementById('template-NgayLap').innerHTML = data["NgayLap"];
        document.getElementById('template-TenNguoiNhan').innerHTML = data["TenNguoiNhan"];
        document.getElementById('template-SDT').innerHTML = data["SDT"];
        document.getElementById('template-DiaChi').innerHTML = data["DiaChi"];
        document.getElementById('template-Phuong').innerHTML = data["Phuong"];
        document.getElementById('template-Quan').innerHTML = data["Quan"];
        document.getElementById('template-Tinh').innerHTML = data["Tinh"];
        document.getElementById('template-TongHang').innerHTML = data["TongHang"];
        document.getElementById('template-PhiVanChuyen').innerHTML = data["PhiVanChuyen"];
        document.getElementById('template-TongTien').innerHTML = data["TongTien"];
        document.getElementById('template-ThanhToan').innerHTML = data["ThanhToan"];
        document.getElementById('MaDH_update').value = data["MaDH"];
      });
  }
  
 function fetchTable (value) {
    //var url = 'http://localhost:3000/api/detailBill?MaDH='+MaDH;
    fetch('../../DT/detailBill', {
        method: 'POST',
        headers: new Headers({'Content-Type': 'application/json'}),
        credentials: 'include',
        body: JSON.stringify({MaDH: value})
    })
      .then(response => {
          response.json().then(data =>{
            console.log(data)
            length = data['tableLength']
            data = data['data']
            var source = document.getElementById('entry-template').innerHTML;
            var template = Handlebars.compile(source);
            var html = template(data);
            /* console.log(data[0][0])
            data = data[0][0]
            var source = document.getElementById('entry-template').innerHTML;
            var template = Handlebars.compile(source);
            var html = template(data); */
            $('#listBillDetail').html(html);
          })
      });
  }
  function fetchTableTT (value) {
    //var url = 'http://localhost:3000/api/detailBillStatus?MaDH='+MaDH;
    fetch('../../DT/detailBillStatus', {
        method: 'POST',
        headers: new Headers({'Content-Type': 'application/json'}),
        credentials: 'include',
        body: JSON.stringify({MaDH: value})
    })
      .then(response => {
            response.json().then(data =>{
                console.log(data)
                var source = document.getElementById('entry-template_1').innerHTML;
                var template = Handlebars.compile(source);
                var html = template(data);
                $('#listBillStatus').html(html);
            })
      })
  }

 /*  btnSaveStatus.addEventListener('click',() => {
    let objToPost = { 
        MaDH: $('#MaDH_update').val(),
        MaTT: $('#MaTT_update').val()
    }
    /* $.ajax({
        url: 'http://localhost:3000/DT/billStatusUpdate',
        type: 'POST',
        data: JSON.stringify(objToPost),
        timeout: 10000,
        contentType: "application/json"
    }).done(function (data){
        alert('Thêm tình trạng thành công!');
    }).fail(function (xhr, textStatus, error){
        console.log(textStatus);
        console.log(error);
        alert(error);
        console.log(xhr);
    }); 
}) */

/*--------------------------------------------------------------------------------------------------------------*/
//server
/*btnSaveStatus.addEventListener('click',() => {
    console.log(1)
    let objToPost = { 
        MaDH: $('#MaDH_update').val(),
        MaTT: $('#MaTT_update').val()
    }
    console.log(objToPost)
    senData('http://localhost:3000/DT/billStatusUpdate', objToPost)
})

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

        console.log(response)
        processData(response)
    }).catch((res) =>{
        console.log("error");
    });
}

const processData = (data)=> {
    if(data.alert){
        alert(data.alert)
    }
}*/
  