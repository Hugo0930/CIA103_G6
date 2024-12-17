<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="com.prodBack.model.*"%>

<!DOCTYPE html>
<html class="wide wow-animation" lang="en">
  <head>
    <!-- Site Title-->
    <title>查看單一商品</title>
    <meta name="format-detection" content="telephone=no">
    <meta name="viewport" content="width=device-width, height=device-height, initial-scale=1.0, maximum-scale=1.0, user-scalable=0">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta charset="utf-8">
    <link rel="icon" href="images/favicon.ico" type="image/x-icon">
    <!-- Stylesheets-->
    <link rel="stylesheet" type="text/css" href="https://fonts.googleapis.com/css?family=Berkshire+Swash%7COpen+Sans:300,500,400,400italic,700,600,600italic%7CRaleway%7CLato:400,700%7CRoboto:400">
    <link rel="stylesheet" href="css/bootstrapsingle.css">
    <link rel="stylesheet" href="css/fontsingle.css">
    <link rel="stylesheet" href="css/stylesingle.css">
		<!--[if lt IE 10]>
    <div style="background: #212121; padding: 10px 0; box-shadow: 3px 3px 5px 0 rgba(0,0,0,.3); clear: both; text-align:center; position: relative; z-index:1;"><a href="http://windows.microsoft.com/en-US/internet-explorer/"><img src="images/ie8-panel/warning_bar_0000_us.jpg" border="0" height="42" width="820" alt="You are using an outdated browser. For a faster, safer browsing experience, upgrade for free today."></a></div>
    <script src="js/html5shiv.min.js"></script>
		<![endif]-->
  </head>
  <body>
    <div class="preloader">
      <div class="preloader-body">
        <div class="cssload-container">
          <div class="cssload-speeding-wheel"></div>
        </div>
        <p>Loading...</p>
      </div>
    </div>
    <!-- Page-->
    <div class="page text-center text-md-left">
      <!-- Page Header-->
      <header class="page-head">
        <!-- RD Navbar-->
        <div class="rd-navbar-wrap">
          <nav class="rd-navbar" data-layout="rd-navbar-fixed" data-sm-layout="rd-navbar-fixed" data-md-device-layout="rd-navbar-fixed" data-md-layout="rd-navbar-fixed" data-lg-layout="rd-navbar-static" data-lg-device-layout="rd-navbar-static" data-xl-layout="rd-navbar-static" data-xl-device-layout="rd-navbar-static" data-sm-stick-up-offset="50px" data-lg-stick-up-offset="107px" data-stick-up-clone="false" data-stick-up="true" data-sm-stick-up="true" data-md-stick-up="true" data-lg-stick-up="true">
            <div class="container rd-navbar-outer text-center">
              <div class="row align-items-md-center justify-content-lg-between">
                <div class="offset-xl-2 col-md-12 text-center col-lg-2 order-lg-2">
<!--                   <div class="rd-navbar-brand"><a class="brand-name" href="index.html"><img src="images/logo.jpg" alt=""></a></div> -->
                </div>
                <div class="col-md-12 text-lg-start col-xl-3 col-lg-4 order-lg-1"><span class="icon fl-bigmug-line-big104 icon-gray-lighter icon-sm"></span><a class="text-middle text-gray preffix-left-10" href="#">69 Halsey St, New York, Ny 10002.</a></div>
                <div class="offset-xl-2 col-md-12 text-lg-end col-xl-3 order-lg-3 col-lg-4"><span class="icon fl-bigmug-line-nine16 icon-gray-lighter icon-xs"></span><span class="text-middle text-gray preffix-left-10">Opening Hours: 08:00amâ7:30pm</span></div>
              </div>
            </div>
            <div class="rd-navbar-inner">
              <!-- RD Navbar Panel-->
              <div class="rd-navbar-panel">
                <!-- RD Navbar Toggle\-->
                <button class="rd-navbar-toggle" data-rd-navbar-toggle=".rd-navbar-nav-wrap"><span></span></button>
                <button class="rd-navbar-collapse-toggle" data-rd-navbar-toggle=".rd-navbar-outer"><span></span></button>
                <!-- 導覽欄 -->
                <div class="rd-navbar-brand"><a class="brand-name" href="index.html"><span>VoiceBus</span></a></div>
              </div>
              <div class="rd-navbar-nav-wrap">
                <!-- RD Navbar Nav-->
                <ul class="rd-navbar-nav">
                  <li><a href="index.html">首頁</a></li>
                  <li class="active"><a href="#">商城</a>
                    <ul class="rd-navbar-dropdown">
                      <li><a href="shop-cart.jsp">購物車</a></li>
                      <li><a href="shop-grid-view.html">Shop Grid View</a></li>
                      <li><a href="shop-list-view.html">Shop List View</a></li>
                    </ul>
                  </li>
                  <li><a href="#">Pages</a>
                    <!-- RD Navbar Dropdown-->
                    <ul class="rd-navbar-megamenu">
                      <li>
                        <p>Elements</p>
                        <ul>
                          <li><a href="buttons.html">Buttons</a></li>
                          <li><a href="icons.html">Icons</a></li>
                          <li><a href="tabs.html">Tabs</a></li>
                          <li><a href="forms.html">Forms</a></li>
                          <li><a href="grid-system.html">Grid System</a></li>
                          <li><a href="typography.html">Typography</a></li>
                          <li><a href="tables.html">Table Styles</a></li>
                          <li><a href="progress-bars.html">Progress Bars</a></li>
                          <li><a href="pricing-tables.html">Pricing Tables</a></li>
                        </ul>
                      </li>
                      <li>
                        <p>Pages 1</p>
                        <ul>
                          <li><a href="about-us.html">About Us</a></li>
                          <li><a href="contacts.html">Contact Us</a></li>
                          <li><a href="appointment.html">Make an Appointment</a></li>
                          <li><a href="maintenance.html">Maintenance</a></li>
                          <li><a href="our-farmers.html">Our Team</a></li>
                          <li><a href="team-members.html">Team Member Profile</a></li>
                          <li><a href="services.html">Services</a></li>
                          <li><a href="single-services.html">Single Service</a></li>
                          <li><a href="careers.html">Careers</a></li>
                        </ul>
                      </li>
                      <li>
                        <p>Pages 2</p>
                        <ul>
                          <li><a href="faq.html">FAQ</a></li>
                          <li><a href="coming-soon.html">Coming Soon</a></li>
                          <li><a href="login.html">Login Page</a></li>
                          <li><a href="register.html">Register Page</a></li>
                          <li><a href="testimonials.html">Clients</a></li>
                          <li><a href="search-results.html">Search results</a></li>
                          <li><a href="404.html">404 Page</a></li>
                          <li><a href="503.html">503 Page</a></li>
                          <li><a href="privacy.html">Privacy Policy</a></li>
                        </ul>
                      </li>
                    </ul>
                  </li>
                  <li><a href="#">blog</a>
                    <ul class="rd-navbar-dropdown">
                      <li><a href="grid-blog.html">Grid Blog</a></li>
                      <li><a href="classic-blog.html">Classic Blog</a></li>
                      <li><a href="masonry-blog.html">Masonry Blog</a></li>
                      <li><a href="modern-blog.html">Modern Blog</a></li>
                      <li><a href="classic-single-blog.html">Single Blog Post</a></li>
                    </ul>
                  </li>
                  <li><a href="#">Gallery</a>
                    <ul class="rd-navbar-dropdown">
                      <li><a href="gallery.html">Grid Gallery</a></li>
                      <li><a href="masonry-gallery.html">Masonry Gallery</a></li>
                      <li><a href="cobles-gallery.html">Cobbles Gallery</a></li>
                      <li><a href="full-width-grid.html">Full Width Gallery</a></li>
                    </ul>
                  </li>
                  <li><a href="contacts.html">Contact Us</a></li>
                  <!-- RD Search-->
                  <li class="rd-navbar-search">
                    <button class="rd-navbar-search-toggle icon rd-search-form-submit icon-xs fl-crisp-icons-search69 icon-gray" data-rd-navbar-toggle=".rd-search"></button>
                    <form class="rd-search" action="search-results.html" method="GET" data-search-live="rd-search-results-live">
                      <div class="form-group">
                        <label class="form-label" for="rd-search-form-input">Search...</label>
                        <input class="form-control" id="rd-search-form-input" type="text" name="s" autocomplete="off">
                      </div>
                      <div class="rd-search-results-live" id="rd-search-results-live"></div>
                      <button class="icon rd-search-form-submit icon-xs fl-crisp-icons-search69 icon-gray" type="submit"></button>
                    </form>
                  </li>
                  <li class="rd-navbar-cart-wrap"><span class="rd-navbar-cart"><a class="icon icon-sm icon-gray" href="shop-cart.html"><span class="icon icon-gray fl-outicons-shopping-cart13"></span><span class="text-bold">$124.00</span></a></span></li>
                </ul>
              </div>
            </div>
          </nav>
        </div>
      </header>
      <!-- Page Content-->
      <!-- Breadcrumbs-->
      <section class="section section-50 breadcrumbs-wrap custom-bg-image novi-background">
        <div class="container text-center">
          <h2>查看單一商品</h2>
          <ul class="breadcrumbs-custom">
            <li><a href="index.html">Home</a><span>/</span></li>
            <li><a href="#">Shop </a><span>/</span></li>
            <li class="active">Single Product </li>
          </ul>
        </div>
      </section>
      <!-- Bananas-->
      <section class="section section-50 novi-background bg-cover">
        <div class="container">
          <div class="product product-single">
            <div class="row row-50 row-sm-90 text-start justify-content-sm-center">
              <div class="col-md-8 col-lg-6">
                
                <div class="product-image">
                  <div class="image"><img class="img-responsive product-image-area" src="images/single-product-01-443x365.png" alt=""></div>
                  <ul class="product-thumbnails">
                    <li class="active" data-large-image="images/single-product-01-443x365.png"><img class="img-responsive" src="images/single-product-01-78x62.png" alt="" width="84" height="84"></li>
                    <li data-large-image="images/single-product-02-443x365.png"><img class="img-responsive" src="images/single-product-02-78x62.png" alt="" width="84" height="84"></li>
                    <li data-large-image="images/single-product-03-309x236.png"><img class="img-responsive" src="images/single-product-03-78x62.png" alt="" width="84" height="84"></li>
                  </ul>
                </div>
                
              </div>
              <div class="col-md-12 col-lg-6 text-start offset-md-top-10">
                <!-- 品牌 -->
                <p class="product-brand text-italic text-light">${prodVO.prodBrand}</p>
                <!--  商品名稱 -->
                <h4 class="product-title offset-top-0 font-default text-sbold"><a class="text-content" href="#">${prodVO.prodName}</a></h4>
                <!-- 點閱次數 -->
                <div class="product-rating offset-top-20"><span class="mdi novi-icon mdi-star icon-xs-small"></span><span class="mdi novi-icon mdi-star icon-xs-small"></span><span class="mdi novi-icon mdi-star icon-xs-small"></span><span class="mdi novi-icon mdi-star-half icon-xs-small"></span><span class="mdi novi-icon mdi-star-outline icon-xs-small"></span><span class="product-review-count text-light">4 customer reviews</span></div>
                <!-- Responsive-tabs-->
                <div class="card-group-custom card-group-corporate" id="accordion1" role="tablist" aria-multiselectable="false">
                  <!--Bootstrap card-->
                  <article class="card card-custom card-corporate">
                    <div class="card-header" role="tab">
                      <div class="card-title"><a id="accordion1-card-head-bgkabidv" data-bs-toggle="collapse" data-parent="#accordion1" href="#accordion1-card-body-bmqvomat" aria-controls="accordion1-card-body-bmqvomat" aria-expanded="true" role="button">商品描述
                          <div class="card-arrow"></div></a></div>
                    </div>
                    <div class="collapse show" id="accordion1-card-body-bmqvomat" aria-labelledby="accordion1-card-head-bgkabidv" data-bs-parent="#accordion1" role="tabpanel">
                      <div class="card-body">
                        <p>${prodVO.prodContent}</p>
                      </div>
                    </div>
                  </article>
                  <!--Bootstrap card-->
                  <article class="card card-custom card-corporate">
                    <div class="card-header" role="tab">
                      <div class="card-title"><a class="collapsed" id="accordion1-card-head-qbhkgpbm" data-bs-toggle="collapse" data-parent="#accordion1" href="#accordion1-card-body-toropuws" aria-controls="accordion1-card-body-toropuws" aria-expanded="false" role="button">更多資訊 
                          <div class="card-arrow"></div></a></div>
                    </div>
                    <div class="collapse" id="accordion1-card-body-toropuws" aria-labelledby="accordion1-card-head-qbhkgpbm" data-bs-parent="#accordion1" role="tabpanel">
                      <div class="card-body">
                        <p>已售出：${prodVO.prodSold}</p>
                        <p>商品剩餘數量：${prodVO.prodCount}</p>
                      </div>
                    </div>
                  </article>
                </div>
                <!-- 商品價格 -->
                <div class="product-price offset-top-30"> <span class="product-price-new h5 text-bold text-content">$${prodVO.prodPrice}</span><span class="product-price-old h6 text-light text-medium">$80.00</span></div>
                <div class="offset-top-5">
                  <div class="form-group product-number product-number-mod-1">
                    <label class="text-light">數量:</label>
                    <div class="stepper stepper-mod preffix-left-7 postfix-right-20">
                      <input class="form-control input-sm form-control-impressed" type="number" data-zeros="true" value="1" min="1" max="${prodVO.prodCount}">
                    </div>
                  </div>
                  <!-- 加入購物車 --><a class="btn btn-primary btn-icon btn-icon-left btn-sm btn-sm-small" href="shop-cart.jsp" style="position: relative; top: 1px;"><span class="icon fl-outicons-shopping-cart13 icon-xs-big"></span>加入購物車</a>
                </div>
              </div>
            </div>
          </div>
        </div>
      </section>
      <!-- 4 Customer Reviews-->
      <section class="section section-50 section-bottom-0 section-75 novi-background bg-cover">
        <div class="container">
          <div class="tabs-custom tabs-vertical tabs-corporate tabs-vertical-1" id="tabs-1">
            <!--Nav tabs-->
            <ul class="nav nav-tabs">
              <li class="nav-item" role="presentation"><a class="nav-link active" href="#tabs-1-1" data-bs-toggle="tab">Additional Information</a></li>
              <li class="nav-item" role="presentation"><a class="nav-link" href="#tabs-1-2" data-bs-toggle="tab">Video Review</a></li>
              <li class="nav-item" role="presentation"><a class="nav-link" href="#tabs-1-3" data-bs-toggle="tab">Customer Reviews</a></li>
              <li class="nav-item" role="presentation"><a class="nav-link" href="#tabs-1-4" data-bs-toggle="tab">Comments</a></li>
            </ul>
            <!--Tab panes-->
            <div class="tab-content">
              <div class="tab-pane fade show active" id="tabs-1-1">
                <p class="text-gray-base">
                  We are committed to using sustainable farming practices to improve the health of our soil and theintegrity of our land.Â They have granted us our certification and we&#39;re proud to call our vegetables, flowers, and herbs organic.Â </p>
              </div>
              <div class="tab-pane fade" id="tabs-1-2">
                <div class="ratio ratio-16x9">
                  <iframe class="ratio-item" src="#" sandbox=""></iframe>
                </div>
              </div>
              <div class="tab-pane fade" id="tabs-1-3">
                <h6 class="text-uppercase text-sbold">4 Customer Reviews</h6>
                <ul class="list-inline offset-top-10">
                  <li>
                    <div class="h7 text-uppercase text-sbold">John Doe</div>
                  </li>
                  <li>
                    <div class="product-rating offset-top-20"><span class="mdi novi-icon mdi-star icon-xs-small"></span><span class="mdi novi-icon mdi-star icon-xs-small"></span><span class="mdi novi-icons mdi-star icon-xs-small"></span><span class="mdi novi-icon mdi-star-half icon-xs-small"></span><span class="mdi novi-icon mdi-star-outline icon-xs-small"></span></div>
                  </li>
                </ul>
                <p class="offset-top-5">Your bananas are very tasty and nitrate-free. They also represent the essence of organic farming that I like the most.</p>
                <ul class="list-inline">
                  <li>
                    <div class="h7 text-uppercase text-sbold">Alex Ross</div>
                  </li>
                  <li>
                    <div class="product-rating offset-top-20"><span class="mdi novi-icon mdi-star icon-xs-small"></span><span class="mdi novi-icon mdi-star icon-xs-small"></span><span class="mdi novi-icon mdi-star icon-xs-small"></span><span class="mdi novi-icon mdi-star icon-xs-small"></span><span class="mdi novi-icon mdi-star icon-xs-small"></span></div>
                  </li>
                </ul>
                <p class="offset-top-5">This product is exactly what I am looking for! The bananas sold by your farm have very original taste and reasonable price.</p>
                <ul class="list-inline">
                  <li>
                    <div class="h7 text-uppercase text-sbold">Diana Roe</div>
                  </li>
                  <li>
                    <div class="product-rating offset-top-20"><span class="mdi novi-icon mdi-star icon-xs-small"></span><span class="mdi novi-icon mdi-star icon-xs-small"></span><span class="mdi novi-icon mdi-star icon-xs-small"></span><span class="mdi novi-icon mdi-star-outline icon-xs-small"></span><span class="mdi novi-icon mdi-star-outline icon-xs-small"></span></div>
                  </li>
                </ul>
                <p class="offset-top-5">My children love your bananas a lot and I can understand why. Organic farming technology is what all of us need - to be healthy.</p>
                <ul class="list-inline">
                  <li>
                    <div class="h7 text-uppercase text-sbold">Sara Cole</div>
                  </li>
                  <li>
                    <div class="product-rating offset-top-20"><span class="mdi novi-icon mdi-star icon-xs-small"></span><span class="mdi novi-icon mdi-star icon-xs-small"></span><span class="mdi novi-icon mdi-star icon-xs-small"></span><span class="mdi novi-icon mdi-star icon-xs-small"></span><span class="mdi novi-icon mdi-star-outline icon-xs-small"></span></div>
                  </li>
                </ul>
                <p class="offset-top-5">This offer is a must-buy! These are not just delicious bananas, they also have a lot of vitamins and minerals.</p>
              </div>
              <div class="tab-pane fade" id="tabs-1-4">
                <h6 class="text-uppercase text-sbold">COMMENTS</h6>
                <div class="h7 text-uppercase text-sbold offset-top-30">Sara Cole</div>
                <p class="offset-top-5">This offer is a must-buy! These are not just delicious bananas, they also have a lot of vitamins and minerals.</p>
                <div class="h7 text-uppercase text-sbold offset-top-30">Alex Ross</div>
                <p class="offset-top-5">This product is exactly what I am looking for! The bananas sold by your farm have very original taste and reasonable price.</p>
                <div class="h7 text-uppercase text-sbold offset-top-30">John Doe</div>
                <p class="offset-top-5">Your bananas are very tasty and nitrate-free. They also represent the essence of organic farming that I like the most.</p>
                <div class="h7 text-uppercase text-sbold offset-top-30">Diana Roe</div>
                <p class="offset-top-5">My children love your bananas a lot and I can understand why. Organic farming technology is what all of us need - to be healthy.</p>
              </div>
            </div>
          </div>
        </div>
      </section>
      <!-- Featured Products-->
      <section class="section section-50 section-lg-115 section-md-bottom-5 novi-background bg-cover">
        <div class="container">
          <h3 class="heading-3 text-center">Featured Products</h3>
          <div class="row justify-content-md-center">
            <div class="col-md-10 col-lg-8 col-xl-12">
              <div class="row">
                <div class="col-md-6 col-xl-3">
                  <div class="product-featured text-center">
                    <div class="product-featured-images"><img class="img-responsive" src="images/home-06-270x204.png" alt="" width="270" height="204"/>
                    </div>
                    <div class="product-featured-rating"><span class="icon material-icons-grade icon-saffron icon-xs-small"></span><span class="icon material-icons-grade icon-saffron icon-xs-small"></span><span class="icon material-icons-grade icon-saffron icon-xs-small"></span><span class="icon material-icons-grade icon-saffron icon-xs-small"></span><span class="icon material-icons-star_half icon-saffron icon-xs-small"></span></div>
                    <div class="product-featured-title">
                      <div class="h7 text-sbold"><a class="text-chateau-green" href="shop-single-products.html">Bananas</a></div>
                    </div>
                    <div class="product-featured-price"><span class="product-price-new h6 text-sbold">$34.00</span><span class="product-price-old h7 text-light text-regular">$80.00</span></div>
                    <div class="product-featured-block-hover"><a class="btn btn-icon btn-icon-left btn-success" href="shop-cart.html"><span class="icon fl-outicons-shopping-cart13"></span>Add to cart</a></div>
                  </div>
                </div>
                <div class="col-md-6 col-xl-3">
                  <div class="product-featured text-center">
                    <div class="product-featured-images"><img class="img-responsive" src="images/home-07-270x204.png" alt="" width="270" height="204"/>
                    </div>
                    <div class="product-featured-rating"><span class="icon material-icons-grade icon-saffron icon-xs-small"></span><span class="icon material-icons-grade icon-saffron icon-xs-small"></span><span class="icon material-icons-grade icon-saffron icon-xs-small"></span><span class="icon material-icons-grade icon-saffron icon-xs-small"></span><span class="icon material-icons-star_half icon-saffron icon-xs-small"></span></div>
                    <div class="product-featured-title">
                      <div class="h7 text-sbold"><a class="text-chateau-green" href="shop-single-products.html">Kiwis</a></div>
                    </div>
                    <div class="product-featured-price"><span class="product-price-new h6 text-sbold">$74.00</span><span class="product-price-old h7 text-light text-regular">$90.00</span></div>
                    <div class="product-featured-block-hover"><a class="btn btn-icon btn-icon-left btn-success" href="shop-cart.html"><span class="icon fl-outicons-shopping-cart13"></span>Add to cart</a></div>
                  </div>
                </div>
                <div class="col-md-6 col-xl-3">
                  <div class="product-featured text-center">
                    <div class="product-featured-images"><img class="img-responsive" src="images/home-08-270x204.png" alt="" width="270" height="204"/>
                    </div>
                    <div class="product-featured-rating"><span class="icon material-icons-grade icon-saffron icon-xs-small"></span><span class="icon material-icons-grade icon-saffron icon-xs-small"></span><span class="icon material-icons-grade icon-saffron icon-xs-small"></span><span class="icon material-icons-grade icon-saffron icon-xs-small"></span><span class="icon material-icons-star_half icon-saffron icon-xs-small"></span></div>
                    <div class="product-featured-title">
                      <div class="h7 text-sbold"><a class="text-chateau-green" href="shop-single-products.html">Strawberries</a></div>
                    </div>
                    <div class="product-featured-price"><span class="product-price-new h6 text-sbold">$90.00</span><span class="product-price-old h7 text-light text-regular">$120.00</span></div>
                    <div class="product-featured-block-hover"><a class="btn btn-icon btn-icon-left btn-success" href="shop-cart.html"><span class="icon fl-outicons-shopping-cart13"></span>Add to cart</a></div>
                  </div>
                </div>
                <div class="col-md-6 col-xl-3">
                  <div class="product-featured text-center">
                    <div class="product-featured-images"><img class="img-responsive" src="images/home-09-270x204.png" alt="" width="270" height="204"/>
                    </div>
                    <div class="product-featured-rating"><span class="icon material-icons-grade icon-saffron icon-xs-small"></span><span class="icon material-icons-grade icon-saffron icon-xs-small"></span><span class="icon material-icons-grade icon-saffron icon-xs-small"></span><span class="icon material-icons-grade icon-saffron icon-xs-small"></span><span class="icon material-icons-star_half icon-saffron icon-xs-small"></span></div>
                    <div class="product-featured-title">
                      <div class="h7 text-sbold"><a class="text-chateau-green" href="shop-single-products.html">Pineapples</a></div>
                    </div>
                    <div class="product-featured-price"><span class="product-price-new h6 text-sbold">$60.00</span><span class="product-price-old h7 text-light text-regular">$90.00</span></div>
                    <div class="product-featured-block-hover"><a class="btn btn-icon btn-icon-left btn-success" href="shop-cart.html"><span class="icon fl-outicons-shopping-cart13"></span>Add to cart</a></div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </section>
      <!-- Banners-->
      <section class="section section-44 bg-primary novi-background bg-cover">
        <div class="container">
          <div class="row row-30 text-center align-items-lg-center justify-content-sm-center">
            <div class="col-sm-6 col-md-4 col-xl-2"><a class="banner" href="#"><img class="img-responsive" src="images/home-10-129x110.png" alt="" width="129" height="110"/></a></div>
            <div class="col-sm-6 col-md-4 col-xl-2"><a class="banner" href="#"><img class="img-responsive" src="images/home-11-120x114.png" alt="" width="120" height="114"/></a></div>
            <div class="col-sm-6 col-md-4 col-xl-2"><a class="banner" href="#"><img class="img-responsive" src="images/home-12-105x105.png" alt="" width="105" height="105"/></a></div>
            <div class="col-sm-6 col-md-4 col-xl-2"><a class="banner" href="#"><img class="img-responsive" src="images/home-13-126x113.png" alt="" width="126" height="113"/></a></div>
            <div class="col-sm-6 col-md-4 col-xl-2"><a class="banner" href="#"><img class="img-responsive" src="images/home-14-126x96.png" alt="" width="126" height="96"/></a></div>
            <div class="col-sm-6 col-md-4 col-xl-2"><a class="banner" href="#"><img class="img-responsive" src="images/home-14-108x106.png" alt="" width="108" height="106"/></a></div>
          </div>
        </div>
      </section>
      <!-- Page Footer-->
      <footer class="page-foot text-center text-md-start">
        <div class="container">
          <div class="row row-45 align-items-md-start">
            <div class="col-xl-3 col-md-6 order-lg-1"><a href="index.html"><img class="img-responsive" src="images/brand-foot-172x44.png" alt="" width="172" height="44"/></a>
              <address class="contact-info offset-top-25">
                <dl>
                  <dt class="text-bold reveal-block">Address:<br></dt>
                  <dd class="text-light">69 Halsey St, New York,<br>Ny 10002.</dd>
                </dl>
                <dl class="offset-top-5">
                  <dt class="text-bold">Phone:</dt>
                  <dd><a class="text-light" href="tel:#">1-800-1234-567</a></dd>
                </dl>
                <dl>
                  <dt class="text-bold">E-Mail:</dt>
                  <dd><a class="text-light" href="mailto:#">info@demolink.org</a></dd>
                </dl>
              </address>
              <ul class="list-inline offset-top-25">
                <li><a class="icon icon-gray-round icon-round icon-xs-small fa-facebook" href="#"></a></li>
                <li><a class="icon icon-gray-round icon-round icon-xs-small fa-twitter" href="#"></a></li>
                <li><a class="icon icon-gray-round icon-round icon-xs-small fa-google-plus" href="#"></a></li>
                <li><a class="icon icon-gray-round icon-round icon-xs-small fa-linkedin" href="#"></a></li>
              </ul>
            </div>
            <div class="col-xl-3 col-md-6 order-lg-3"><span class="h7 text-uppercase text-spacing-60">Twitter Feed</span>
              <!-- RD Twitter Feed-->
              <div class="twitter" data-twitter-username="templates" data-twitter-date-hours=" hours ago" data-twitter-date-minutes=" minutes ago">
                <div data-twitter-type="tweet"><span class="icon fa-twitter icon-xs-small text-picton-blue"></span>
                  <div class="twitter-date text-light" data-date="text"></div>
                  <div data-tweet="text"></div>
                  <div class="twitter-name h7 text-picton-blue" data-screen_name="text"></div>
                </div>
              </div>
              <div class="twitter" data-twitter-username="templates" data-twitter-date-hours=" hours ago" data-twitter-date-minutes=" minutes ago">
                <div data-twitter-type="tweet"><span class="icon fa-twitter icon-xs-small text-picton-blue"></span>
                  <div class="twitter-date text-light" data-date="text"></div>
                  <div data-tweet="text"></div>
                  <div class="twitter-name h7 text-picton-blue" data-screen_name="text"></div>
                </div>
              </div>
            </div>
            <div class="col-xl-2 col-md-6 order-lg-4"><span class="h7 text-uppercase text-spacing-60">Gallery</span>
              <div class="postfix-lg-right--30">
                <!-- RD Flickr-->
                <div class="flickr group-sm" data-lightgallery="group">
                  <div class="flickr-item"><a class="thumbnail thumbnail-flick" data-lightgallery="item" href="images/footer-gallery-original-1.jpg"><img width="80" height="80" src="images/footer-gallery-1-80x80.jpg" alt=""></a></div>
                  <div class="flickr-item"><a class="thumbnail thumbnail-flick" data-lightgallery="item" href="images/footer-gallery-original-2.jpg"><img width="80" height="80" src="images/footer-gallery-2-80x80.jpg" alt=""></a></div>
                  <div class="flickr-item"><a class="thumbnail thumbnail-flick" data-lightgallery="item" href="images/footer-gallery-original-3.jpg"><img width="80" height="80" src="images/footer-gallery-3-80x80.jpg" alt=""></a></div>
                  <div class="flickr-item"><a class="thumbnail thumbnail-flick" data-lightgallery="item" href="images/footer-gallery-original-4.jpg"><img width="80" height="80" src="images/footer-gallery-4-80x80.jpg" alt=""></a></div>
                </div>
              </div>
            </div>
            <div class="col-xl-4 col-md-6 order-lg-2 order-xl-4"><span class="h7 text-uppercase text-spacing-60">latest from the blog</span>
              <article class="post-widget"><a href="classic-single-blog.html">
                  <div class="unit unit-sm-horizontal unit-align-center unit-xs unit-xs-middle unit-spacing-sm unit-sm-align-left">
                    <div class="unit-left"><img class="img-responsive img-circle" src="images/home-15-60x60.jpg" alt="" width="60" height="60"/>
                    </div>
                    <div class="unit-body">
                      <div class="post-widget-meta"><span class="icon material-design-right244 icon-xxs icon-success"></span>
                        <time class="text-light" datetime="2019">05/14/2019</time>
                      </div>
                      <div class="post-widget-title">
                        <p>Organics Reduce Health Risks</p>
                      </div>
                    </div>
                  </div></a></article>
              <article class="post-widget"><a href="classic-single-blog.html">
                  <div class="unit unit-sm-horizontal unit-align-center unit-xs unit-xs-middle unit-spacing-sm unit-sm-align-left">
                    <div class="unit-left"><img class="img-responsive img-circle" src="images/home-16-60x60.jpg" alt="" width="60" height="60"/>
                    </div>
                    <div class="unit-body">
                      <div class="post-widget-meta"><span class="icon material-design-right244 icon-xxs icon-success"></span>
                        <time class="text-light" datetime="2019">05/14/2019</time>
                      </div>
                      <div class="post-widget-title">
                        <p>GMOs: Your Right To Know</p>
                      </div>
                    </div>
                  </div></a></article>
              <article class="post-widget"><a href="classic-single-blog.html">
                  <div class="unit unit-sm-horizontal unit-align-center unit-xs unit-xs-middle unit-spacing-sm unit-sm-align-left">
                    <div class="unit-left"><img class="img-responsive img-circle" src="images/home-17-60x60.jpg" alt="" width="60" height="60"/>
                    </div>
                    <div class="unit-body">
                      <div class="post-widget-meta"><span class="icon material-design-right244 icon-xxs icon-success"></span>
                        <time class="text-light" datetime="2019">05/14/2019</time>
                      </div>
                      <div class="post-widget-title">
                        <p>Itâs Your Personal Choice</p>
                      </div>
                    </div>
                  </div></a></article>
            </div>
          </div>
          <p class="text-center copyright offset-top-45 offset-xl-top-15">Organic Farm Â©
<span class="copyright-year"></span>
.
<a href="privacy.html">Privacy Policy</a>. <a target="_blank" href="https://www.mobanwang.com/" title="ç½ç«æ¨¡æ¿">ç½ç«æ¨¡æ¿</a>
          </p>
        </div>
      </footer>
    </div>
    <!-- Global Mailform Output-->
    <div class="snackbars" id="form-output-global"></div>
    <!-- Java script-->
    <script src="js/core.min.js"></script>
    <script src="js/script.js"></script>
  </body>
</html>