login_submit.addEventListener('click', function(){
    var uname = $("#username").val();
    var pass = $("#password").val();
    let objToPost = { 
        username: $("#username").val(),
        password: $("#password").val()
    }

    console.log(objToPost);
    senData('http://localhost:3000/LogInKH', objToPost)
    /* $.ajax('http://localhost:3000/LogInKH', {
        method: 'POST',
        headers: {'Content-Type': 'text/csv'},
        credentials: 'include',
        body: JSON.stringify({uname: username})
      })
      .done(function(data) {
        console.log(data)
      }) */
    if (username!="" && password!=""){
        //senData('http://localhost:3000/LogInKH', objToPost)
        fetch('/LogInKH', {
            method: 'POST',
            headers: new Headers({'Content-Type': 'application/json'}),
            credentials: 'include',
            body: JSON.stringify(objToPost)
        })
        .then (response => {
            response.json().then((data) => {
                if (data.length>0){
                    if (uname==data[0].MaKH)
                        if (pass==data[0].pword){
                            //console.log(data[0]);
                            alert("Đăng nhập thành công")
                            window.location='http://localhost:3000'
                        }
                        else{
                            console.log("password is false");
                            alert("Sai tên đăng nhập hoặc mật khẩu. Bạn vui lòng thử lại.")
                        }
                    else{
                        console.log("password is false");
                        alert("Sai tên đăng nhập hoặc mật khẩu. Bạn vui lòng thử lại.")
                    }
                }
                else {
                    console.log("username false")
                    alert("Tài khoản đăng nhập không tồn tại.")
                }    
            });
            
        });
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
            processData(response)
        });
        
    });
}

const processData = (data)=> {
    if(data.alert){
        alert(data.alert)
    }
}

function checkData(data) {
    if (data.length>0){
        if (uname==data[0].MaKH)
            if (pass==data[0].pword){
                //console.log(data[0]);
                alert("Login successfully")
                window.location="index.html";
            }
            else{
                console.log("password is false");
                alert("Password is wrong")
            }
    }
    else {
        console.log("username false")
        alert("Username is wrong")
    }    
}

function checkLogin(uname,pass){

	        
    $.getJSON("http://localhost:3000/LogIn_KH/"+uname,checkData);
    console.log(JSON.stringify(uname))
    fetch('http://localhost:3000/LogInKH', {
            method: 'post',
            headers: new Headers({'Content-Type': 'application/json'}),
            body: JSON.stringify(objToPost)
        })
        .then (response => {
            checkData(response)
        });
    
    function checkData(data) {
        if (data.length>0){
            if (uname==data[0].MaKH)
                if (pass==data[0].pword){
                    //console.log(data[0]);
                    alert("Login successfully")
                    window.location="index.html";
                }
                else{
                    console.log("password is false");
                    alert("Password is wrong")
                }
        }
        else {
            console.log("username false")
            alert("Username is wrong")
        }    
    }
}