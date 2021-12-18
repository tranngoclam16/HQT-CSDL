function fetchData (value) {
    //var url = 'http://localhost:3000/KH/Info?MaKH='+value;
    var url = 'http://localhost:3000/TX/Info';
    fetch(url,{
        method: 'POST',
        headers: {
          "Content-type":'application/json'
        },
        //credentials: 'include',
        body: JSON.stringify({MaTX:value})
      })
    .then (response => {response.json().then((data) => {
        data = data[0];
        console.log('js',data)
        document.getElementById('template-MaTX').innerHTML = data["CMND"];
        document.getElementById('template-HoTen').innerHTML = data["HoTen"];
        document.getElementById('template-SDT').innerHTML = data["SDT"];
      })});
  }

  function fetchTable (value, tx) {
    var url = 'http://localhost:3000/TX/InfoBill';
    fetch(url,{
        method: 'POST',
        headers: {
          "Content-type":'application/json'
        },
        //credentials: 'include',
        body: JSON.stringify({start:value, MaTX:tx})
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


 

