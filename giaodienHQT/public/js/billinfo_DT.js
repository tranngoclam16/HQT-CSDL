function fetchData (value) {
    var url = 'http://localhost:3000/api/billinfo?MaDH='+value;
   // console.log("url:",url)
    fetch(url)
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
      });
  }
  
 function fetchTable (MaDH) {
    var url = 'http://localhost:3000/api/detailBill?MaDH='+MaDH;
    fetch(url)
      .then(response => {
          if (response.ok) {
              return response.json();
          } else {
              throw new Error(response.statusText);
          }
      })
      .then(data => {
        data = data[0]
        console.log(data)
        var source = document.getElementById('entry-template').innerHTML;
        var template = Handlebars.compile(source);
        var html = template(data);
        $('#listBillDetail').html(html);
      });
  }
  