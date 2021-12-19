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
      .then (response => {response.json().then(data => {
        if(data==null){
          alert('Không tồn tại sản phẩm thỏa yêu cầu')
        } else{
            console.log(data)
            var source = document.getElementById('entry-template').innerHTML;
            var template = Handlebars.compile(source);
            var html = template(data.recordset);
            $('#listProduct').html(html);
            document.getElementById("template-Tong").innerHTML= data.output['Tong'];
        }
  })
  })}


  function fetchTableKH (ma,ten) {  
    console.log("ma:",ma)
    console.log(ten)   
      fetch("http://localhost:3000/KH/CheckProduct", {
          method: 'POST',
          headers: {
            "Content-type":'application/json'
          },
          //credentials: 'include',
          body: JSON.stringify({MaSP:ma, TenSP:ten})
        })
        .then (response => {response.json().then(data => {
          if(data==null){
            alert('Không tồn tại sản phẩm thỏa yêu cầu')
          } else{
            console.log(data)
            var source = document.getElementById('entry-template').innerHTML;
            var template = Handlebars.compile(source);
            var html = template(data.recordset);
            $('#listProduct').html(html);
            document.getElementById("template-Tong").innerHTML= data.output['result'];
          }
             
    })
    })}