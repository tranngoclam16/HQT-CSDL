  //server.js
  /*function fetchTable (value) {  
    $.ajax('/DT/BillList', {
    method: 'POST',
    headers: {
      "Content-type": 'text/csv'
    },
    credentials: 'include',
    body: JSON.stringify({start: value})
  })
  .done(function(data) {
    console.log(data)
    length = data['tableLength']
    data = data['data']
    var source = document.getElementById('entry-template').innerHTML;
    var template = Handlebars.compile(source);
    var html = template(data);
    $('#listBill').html(html);
    document.getElementById("currentPage").innerHTML = currentPage + '/' + length/100
  })
  }*/

  //api.js
  /* function fetchTable (value) {
    var url = 'http://localhost:3000/api/DT/bill?start='+value;
    $.ajax(url)
      .done(function (data) {
        length = data['tableLength']
        data = data['data']
        var source = document.getElementById('entry-template').innerHTML;
        var template = Handlebars.compile(source);
        var html = template(data);
        $('#listBill').html(html);
        document.getElementById("currentPage").innerHTML = currentPage + '/' + length/100
      }).fail(function (err) {
        console.log(err);
      });
  } */
  

  function fetchTable (value) {  
    fetch('/DT/BillList', {
    method: 'POST',
    headers: new Headers({'Content-Type': 'application/json'}),
    credentials: 'include',
    body: JSON.stringify({start: value})
  })
  .then(response => {
    response.json().then(data =>{
      console.log(data)
      length = data['tableLength']
      console.log(length)
      data = data['data']
      var source = document.getElementById('entry-template').innerHTML;
      var template = Handlebars.compile(source);
      var html = template(data);
      $('#listBill').html(html);
      document.getElementById("currentPage").innerHTML = currentPage + '/' + length/100
    })

  })
}
  
  