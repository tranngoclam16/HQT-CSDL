registerKH_btn.addEventListener('click', function(){
    let objToPost = { 
        MaKH: $('#MaKH').val(),
        HoTen: $('#HoTen').val(),
        DiaChi: $('#DiaChi').val(),
        Email: $('#Email').val(),
        Password: $('#Password').val()
    }
    $.ajax({
        url: 'http://localhost:3000/api/SignUpKH',
        type: 'POST',
        data: JSON.stringify(objToPost),
        timeout: 10000,
        contentType: "application/json"
    }).done(function (data){
        alert('Đăng ký thành công');
    }).fail(function (xhr, textStatus, error){
        console.log(textStatus);
        console.log(error);
        alert(error);
        console.log(xhr);
    });
})