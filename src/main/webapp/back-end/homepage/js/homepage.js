let hamburger_el = document.getElementsByClassName("hamburger")[0];
let nav_right_slide_el = document.getElementsByClassName("right_slide")[0];
hamburger_el.addEventListener("click",function(){
	hamburger_el.classList.toggle("active");
	nav_right_slide_el.classList.toggle("active");

})

$("#rent_btn").on("click",function(){
	if($(this).closest("ul.func_name").find("div.rent_btn_block").hasClass("active")){
		$(this).closest("ul.func_name").find("div.rent_btn_block").removeClass("active");
		$(this).removeClass("active");
	}else{
		$(this).closest("ul.func_name").find("div.rent_btn_block").addClass("active");
		$(this).addClass("active");
	}
})

$("#shop_btn").on("click",function(){
	if($(this).closest("ul.func_name").find("div.shop_btn_block").hasClass("active")){
		$(this).closest("ul.func_name").find("div.shop_btn_block").removeClass("active");
		$(this).removeClass("active");
	}else{
		$(this).closest("ul.func_name").find("div.shop_btn_block").addClass("active");
		$(this).addClass("active");
	}
})
$("#web_btn").on("click",function(){
	if($(this).closest("ul.func_name").find("div.web_btn_block").hasClass("active")){
		$(this).closest("ul.func_name").find("div.web_btn_block").removeClass("active");
		$(this).removeClass("active");
	}else{
		$(this).closest("ul.func_name").find("div.web_btn_block").addClass("active");
		$(this).addClass("active");
	}
})
$("#member_btn").on("click",function(){
	if($(this).closest("ul.func_name").find("div.member_btn_block").hasClass("active")){
		$(this).closest("ul.func_name").find("div.member_btn_block").removeClass("active");
		$(this).removeClass("active");
	}else{
		$(this).closest("ul.func_name").find("div.member_btn_block").addClass("active");
		$(this).addClass("active");
	}
})
$("#emp_btn").on("click",function(){
	if($(this).closest("ul.func_name").find("div.emp_btn_block").hasClass("active")){
		$(this).closest("ul.func_name").find("div.emp_btn_block").removeClass("active");
		$(this).removeClass("active");
	}else{
		$(this).closest("ul.func_name").find("div.emp_btn_block").addClass("active");
		$(this).addClass("active");
	}
})
$("#match_btn").on("click",function(){
	if($(this).closest("ul.func_name").find("div.match_btn_block").hasClass("active")){
		$(this).closest("ul.func_name").find("div.match_btn_block").removeClass("active");
		$(this).removeClass("active");
	}else{
		$(this).closest("ul.func_name").find("div.match_btn_block").addClass("active");
		$(this).addClass("active");
	}
})

$(document).ready(function(){
	if($("div.container").length > 1){
		$("div.container").first().hide();
	}else{
		$("div.container").first().show();
	}
})
