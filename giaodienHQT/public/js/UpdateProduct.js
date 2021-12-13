btnSaveUpdate.addEventListener('click',() => {
    let objToPost = { 
        MaSP: $('#MaSPupdate').val(),
        TenSP: $('#TenSP').val(),
        GiaBan: $('#GiaBan').val(),
        SLTon: $('#SLTon').val()
    }
    console.log(objToPost)
    senData('http://localhost:3000/DT/UpdateProduct_update', objToPost)
})

btnSaveAddToAgent.addEventListener('click',() => {
    let objToPost = { 
        MaSP: $('#MaSP').val(),
        MaCN: $('#MaCN').val()
    }
    console.log(objToPost)
    senData('http://localhost:3000/DT/UpdateProduct_agent', objToPost)
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
    .then (response => {

        console.log(response)
        processData(response)
    }).catch((res) =>{
        console.log("error");
    });
}

const processData = (data)=> {
    if(data.alert){
        alert(data.alert)
    }
}