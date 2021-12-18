button.addEventListener('click',() => {
    let objToPost = { 
        MaDH: $('#textMaDH').val(),
        MaTX: $('#textMaTX').val()
    }
    console.log(objToPost)
    senData('http://localhost:3000/TX/AddShipping', objToPost)
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
  .then (response => { response.json().then(data =>{
      console.log(data)
      processData(data)
  })
  })
}

const processData = (data)=> {
  if(data.alert){
      alert(data.alert)
  }
  if(data.msg){
    alert(data.msg)
    location.reload('/TX/AddShipping')
  }
}
  
const DriverAction = (MaDH)=>{
  console.log(MaDH)
  let TX = JSON.parse(sessionStorage.user)
  console.log(TX.SDT)
  let objToPost = { 
    MaDH: MaDH,
    MaTX: TX.SDT
  }
  console.log(objToPost)
  senData('http://localhost:3000/TX/AddShipping', objToPost)
}
  