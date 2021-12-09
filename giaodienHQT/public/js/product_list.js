/*  function fetchTable (value) {
  var url = 'http://localhost:3000/api/KH/ProductList?start='+value;
  /*fetch('/KH/ProductList?start='+value)
    .then(data => {
      length = data['tableLength']
      data = data['data']
      console.log(data)
      var source = document.getElementById('entry-template').innerHTML;
      var template = Handlebars.compile(source);
      var html = template(data);
      $('#listProduct').html(html);
      document.getElementById("currentPage").innerHTML = currentPage + '/' + length/100
    })
    $.ajax(url)
    .done(function (data) {
      length = data['tableLength']
      data = data['data']
      var source = document.getElementById('entry-template').innerHTML;
      var template = Handlebars.compile(source);
      var html = template(data);
      $('#listProduct').html(html);
      document.getElementById("currentPage").innerHTML = currentPage + '/' + length/100
    }).fail(function (err) {
      console.log(err);
    });
}  

const setData = (data) => {
  length = data['tableLength']
  data = data['data']
  var source = document.getElementById('entry-template').innerHTML;
  var template = Handlebars.compile(source);
  var html = template(data);
  $('#listProduct').html(html);
  document.getElementById("currentPage").innerHTML = currentPage + '/' + length/100
}*/

function fetchTable (value) {  
  $.ajax('/KH/ProductList', {
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
  $('#listProduct').html(html);
  document.getElementById("currentPage").innerHTML = currentPage + '/' + length/100
})
}

