const createNav = () => {
    let nav = document.querySelector('.navbar');

    nav.innerHTML = `
    <div class="navbar-wrapper container-wrapper">
    <img src="img/logo.png" class="brand-logo" alt="">  
  </div>
  <div class="header">
    <div class="container-fluid">
      <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
        <span>
          <i id="bar" class="fas fa-bars"></i>
        </span>
      </button>
      <div class="collapse navbar-collapse" id="navbarSupportedContent">
        <ul class="navbar-nav ml-auto">
          <li class="nav-item">
            <a class="nav-link" href="index1.html">Trang chủ</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="Product.html">Sản phẩm</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="#">Đối tác</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="#">Chi nhánh</a>
          </li>
            <li class="nav-item">
            <i class="fas fa-shopping-bag"></i>
            <a class="fas fa-user" role="button" href="SignUp_KH.html">
            </a>
            </i>
              <!-- <a href="#"><img src="img/user.png" alt=""></a>
              <a href="#"><img src="img/shopping-cart.png" alt=""></a>   -->
          </li>
      </div>
      <div class="search ml-auto">
        <div class="nav-items">
          <input type="text" class="search-box" placeholder="Tìm kiếm sản phẩm">
          <button class="fas fa-search"></button>

        </div>
        
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