//api
function fetchData (value) {
    var url = 'http://localhost:3000/api/KH/Info?MaKH='+value;
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
        document.getElementById('template-MaKH').innerHTML = data["MaKH"];
        document.getElementById('template-HoTen').innerHTML = data["HoTen"];
        document.getElementById('template-DiaChi').innerHTML = data["DiaChi"];
        document.getElementById('template-Email').innerHTML = data["Email"];
      });
  }
  
  function fetchTable (value, MaKH) {
    var url = 'http://localhost:3000/api/KH/BillList?start='+value+'&MaKH='+MaKH;
    fetch(url)
      .then(response => {
          if (response.ok) {
              return response.json();
          } else {
              throw new Error(response.statusText);
          }
      })
      .then(data => {
        length = data['tableLength']
        data = data['data']
        console.log(data)
        var source = document.getElementById('entry-template').innerHTML;
        var template = Handlebars.compile(source);
        var html = template(data);
        $('#listBill').html(html);
        document.getElementById("currentPage").innerHTML = currentPage + '/' + length/100
      });
  }
/*--------------------------------------------------------------------------------------------------------------*/
//server
