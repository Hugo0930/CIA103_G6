/**
 * 
 */

document.addEventListener("DOMContentLoaded", function () {
    // 從 URL 中解析當前頁面
    const params = new URLSearchParams(window.location.search);
    const currentPage = params.get("page");

	//console.log(currentPage);
    // 標記當前頁面按鈕
    if (currentPage) {
        const links = document.querySelectorAll(".page a");
        links.forEach((link) => {
            if (link.href.includes(`page=${currentPage}`)) {
				let page_el = link.closest(".page");
				//console.log(this);//document物件
                page_el.classList.add("active");
            }
        });
    }
});
//新增錄音室
$("#btn_add").on("click",function(){
	if($("div.table_box").hasClass("active")){
		$("div.table_box").removeClass("active");
	}else{
		$("div.table_box").addClass("active");
	}
})
$("#btn_close").on("click",function(e){
	$("div.table_box").removeClass("active");
	e.stopPropagation();
})
$("div.update_table_box").on("click",function(e){
	e.stopPropagation();
})

$("div.table_box").on("click",function(e){
	e.stopPropagation();
})

//更新錄音室
$(".update_btn").on("click",function(e){
	if($("div.update_table_box").hasClass("active")){
		$("div.update_table_box").removeClass("active");
	}else{
		$("div.update_table_box").addClass("active");
		$("input#studio_id").val($(this).data("id"));
		$("input#studio_loc").val($(this).data("loc"));
		$("input#studio_name").val($(this).data("name"));
		$("select#studio_capacity").val($(this).data("capacity"));
		$("input#studio_hourly_rate").val($(this).data("rate"));
	}
})
$("#update_btn_close").on("click",function(e){
	$("div.update_table_box").removeClass("active");
	e.stopPropagation();
})

$("div.update_table_box").on("click",function(e){
	e.stopPropagation();
})

/****************篩選條件**********************/
$("select#sort_type").on("change",function(){
	console.log('ttt');
	let value = $(this).val();
	if(value != null){
		if(value === 'std_on'){
			window.location.href= "/CIA103g6/MyStudioServlet?action=get_all_std_on&page=1";
		}
		
		if(value === 'std_off'){
			window.location.href= "/CIA103g6/MyStudioServlet?action=get_all_std_off&page=1";
		}
		
		if(value === 'std_all'){
			window.location.href= "/CIA103g6/MyStudioServlet?action=get_all&page=1";
		}
	}
})
/****************錯誤驗證**********************/
let errors = new Array();
$('div.table_box button#submit_btn').on("click",function(){
	//alert('zzz');
	/* 清除上一次的錯誤訊息 */
	$("div.table_box form ul").remove();
	
	validate('add');
	
	//console.log(errors);
	if(errors.length > 0){
		/*
		let errorStr = "";
		for(i = 0; i < errors.length; i++){
			errorStr += errors[i];
			errorStr += '\n';
		}
		console.log(errorStr);
		//alert(errorStr);
		*/
		$("div.table_box form h2").after("<ul></ul>");
		let li_el = "";
		for(i = 0; i < errors.length; i++){
			li_el = '<li style="color:red; margin-left:15px;">' + errors[i] + '</li>';
			$("div.table_box form ul").append(li_el);
		}
	}else{
		$("div.table_box form").submit();
	}
})

$("div.update_table_box button#update_submit_btn").on("click",function(){
	//alert('zzz');
	/* 清除上一次的錯誤訊息 */
	if($("div.update_table_box form ul").length > 0){
		$("div.update_table_box form ul").remove();
	}

	validate('update');

	if(errors.length > 0){
		$("div.update_table_box form h2").after("<ul></ul>");
		let li_el = "";
		for(i = 0; i < errors.length; i++){
			li_el = '<li style="color:red; margin-left:15px;">' + errors[i] + '</li>';
			$("div.update_table_box form ul").append(li_el);
		}
	}else{
		$("div.update_table_box form").submit();
	}
	
})
let imgFile = "";
$('div.table_box input.image').on("change",function(){
	imgFile = this.files[0];
})

$('div.table_box button[type="reset"]').on("click",function(){
	imgFile = "";
})
$('div.update_table_box input.image').on("change",function(){
	imgFile = this.files[0];
})
$('div.update_table_box button[type="reset"]').on("click",function(){
	imgFile = "";
})

function validate(action){
	let index = null;
	if(action == 'add'){
		index = 0;
	}
	if(action == 'update'){
		index = 1;
	}
	/* 清除陣列中的錯誤訊息 */
	let array_length = errors.length;
	for(i = 0; i < array_length; i++){
		errors.pop();
	}
	let loc = $("input.loc").eq(index).val().trim();
	if(loc == ""){
		errors.push('請輸入錄音室地點');
	}

	let name = $("input.name").eq(index).val().trim();
	if(name == ""){
		errors.push('請輸入錄音室名稱');
	}

	let hourly_rate = $("input.hourly_rate").eq(index).val().trim();
	let reg = /^\d+$/; // 表示一個或多個數字的正則表達式
	if(hourly_rate == ""){
		errors.push('請輸入錄音室租金');
	}else if(!reg.test(hourly_rate)){
		errors.push('錄音室租金必須是整數');
	}

	let date =  $("input.date").eq(index).val().trim();
	if(date == ""){
		errors.push('請選擇錄音室上架日期');
	}
	if(imgFile == ""){
		errors.push('請選擇錄音室照片');
	}
}