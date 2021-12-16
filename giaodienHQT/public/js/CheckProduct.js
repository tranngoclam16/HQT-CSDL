function fetchTable (choice,value) { 
  var url
  if (choice==1){
    url="http://localhost:3000/DT/CheckProduct"
  }
  else{
    url="http://localhost:3000/DT/CheckProductPrice"
  }
  
    fetch(url, {
        method: 'POST',
        headers: {
          "Content-type":'application/json'
        },
        //credentials: 'include',
        body: JSON.stringify({start:value})
      })
      .then (response => {response.json().then((data) => {
            var dataT = data.recordsets[0]
            console.log(dataT)
            var source = document.getElementById('entry-template').innerHTML;
            var template = Handlebars.compile(source);
            var html = template(dataT);
            $('#listProduct').html(html);
            document.getElementById("template-Tong").innerHTML= data.output['Tong'];
  })
  })}