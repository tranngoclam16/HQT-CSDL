const createNav = () => {
    let nav = document.querySelector('.navbar');

    nav.innerHTML = `
      <div class="container">
        <img src="img/logo.png" class="brand-logo" alt="">
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
          <span>
            <i id="bar" class="fas fa-bars"></i>
          </span>
        </button>
        <div class="collapse navbar-collapse" id="navbarSupportedContent">
          <ul class="navbar-nav ml-auto">
            <li class="nav-item">
              <a class="nav-link" href="#">Trang chủ</a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="#">Sản phẩm</a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="#">Đối tác</a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="#">Chi nhánh</a>
            </li>
              <li class="nav-item">
              <i class="fas fa-search"></i>
              <i id="cart-btn" class="fas fa-shopping-bag"></i>
            </li>
        </div>
      </div>`;
}

createNav();


document.getElementById("cart-btn").addEventListener("click",function()
        {
            var box1=document.getElementById("cart");
            if( box1.style.display=="none")
            {
                box1.style.display="block";
            }
            else{
                box1.style.display="none";
            }
        })