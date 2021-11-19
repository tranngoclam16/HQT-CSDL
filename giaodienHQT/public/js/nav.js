const createNav = () => {
    let nav = document.querySelector('.navbar');

    nav.innerHTML = `
    <div class="nav">
        <img src="img/logo.png" class="brand-logo" alt="">
        <div class="nav-items">
            <div class="search">
                <input type="text" class="search-box" placeholder="Tìm sản phẩm, đối tác">
                <button class="search-btn">Tìm kiếm</button>       
            </div>
            <a href="#"><img src="img/user.png" alt=""></a>
            <a href="#"><img src="img/shopping-cart.png" alt=""></a>
        </div>
    </div>
    <ul class="links-container">
        <li class="link-item"><a href="#" class="link">Trang chủ</a></li>
        <li class="link-item"><a href="#" class="link">Sản phẩm</a></li>
        <li class="link-item"><a href="#" class="link">Đối tác</a></li>
        <li class="link-item"><a href="#" class="link">Chi nhánh</a></li>
    </ul>`;
}

createNav();