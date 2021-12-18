login_submit.addEventListener('click', function(){
    var uname = $("#username").val();
    var pass = $("#password").val();
    let objToPost = { 
        username: $("#username").val(),
        password: $("#password").val()
    }

    console.log(objToPost);
    if (username!="" && password!=""){
        senData('http://localhost:3000/LogInTX', objToPost)
    }
    else alert("Vui lòng nhập đầy đủ thông tin!")

});

const senData = (path, data) => {
    fetch(path, {
        method: 'POST',
        headers: new Headers({'Content-Type': 'application/json'}),
        body: JSON.stringify(data)
    })
    .then (response => {
        response.json().then((data) => {
            //console.log(data)
            processData(data)
        });
        
    });
}

const processData = (data)=> {
    console.log(data)
    if(data.alert){
        alert(data.alert)
    } else if (data.SDT){
        alert('Tài xế đăng nhập thành công!')
        sessionStorage.user = JSON.stringify(data)
        location.replace('/TX/Info')
    }
}

