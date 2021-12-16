/* function fetchData (value) {
    //var url = 'http://localhost:3000/KH/Info?MaKH='+value;
    var url = 'http://localhost:3000/KH/Info';
    fetch(url,{
        method: 'POST',
        headers: {
          "Content-type":'application/json'
        },
        //credentials: 'include',
        body: JSON.stringify({start:value})
      })
    .then (response => {response.json().then((data) => {
        data = data[0];
        console.log(data)
        document.getElementById('template-MaKH').innerHTML = data["MaKH"];
        document.getElementById('template-HoTen').innerHTML = data["HoTen"];
        document.getElementById('template-DiaChi').innerHTML = data["DiaChi"];
        document.getElementById('template-Email').innerHTML = data["Email"];
      })});
  }

  function fetchTable (value, kh) {
    var url = 'http://localhost:3000/KH/InfoBill';
    fetch(url,{
        method: 'POST',
        headers: {
          "Content-type":'application/json'
        },
        //credentials: 'include',
        body: JSON.stringify({start:value, MaKH:kh})
      })
    .then (response => {response.json().then((data) => {
        length = data['tableLength']
        data = data['data']
        console.log(data)
        var source = document.getElementById('entry-template').innerHTML;
        var template = Handlebars.compile(source);
        var html = template(data);
        $('#listBill').html(html);
        document.getElementById("currentPage").innerHTML = currentPage + '/' + length/100
        //console.log(currentPage + '/' + length/100)
      })});
  } */

//=============================================
function fetchData (value) {
  //var url = 'http://localhost:3000/KH/Info?MaKH='+value;
  var url = 'http://localhost:3000/KH/Info';
  fetch(url,{
      method: 'POST',
      headers: {
        "Content-type":'application/json'
      },
      //credentials: 'include',
      body: JSON.stringify({start:value})
    })
  .then (response => {response.json().then((data) => {
      data = data[0];
      console.log(data)
      document.getElementById('template-MaKH').innerHTML = data["MaKH"];
      document.getElementById('template-HoTen').innerHTML = data["HoTen"];
      document.getElementById('template-DiaChi').innerHTML = data["DiaChi"];
      document.getElementById('template-Email').innerHTML = data["Email"];
    })});
}

function fetchTable (value, kh) {
  var url = 'http://localhost:3000/KH/InfoBill';
  fetch(url,{
      method: 'POST',
      headers: {
        "Content-type":'application/json'
      },
      //credentials: 'include',
      body: JSON.stringify({start:value, MaKH:kh})
    })
  .then (response => {response.json().then((data) => {
      length = data['tableLength']
      data = data['data']
      console.log(data)
      var source = document.getElementById('entry-template').innerHTML;
      var template = Handlebars.compile(source);
      var html = template(data);
      $('#listBill').html(html);
      document.getElementById("currentPage").innerHTML = currentPage + '/' + length/100
      //console.log(currentPage + '/' + length/100)
    })});
}

