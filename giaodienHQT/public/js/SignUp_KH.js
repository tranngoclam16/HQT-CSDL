
registerKH_btn.addEventListener('click',() => {
    let objToPost = { 
        MaKH: $('#MaKH').val(),
        HoTen: $('#HoTen').val(),
        DiaChi: $('#DiaChi').val(),
        Email: $('#Email').val(),
        Password: $('#Password').val()
    }
    senData('/SignUpKH', objToPost)
})

const senData = (path, data) => {
    fetch(path, {
        method: 'post',
        headers: new Headers({'Content-Type': 'application/json'}),
        body: JSON.stringify(data)
    }).then ((res)=>res.json)
    .then (response => {
        console.log(response)
    })
}