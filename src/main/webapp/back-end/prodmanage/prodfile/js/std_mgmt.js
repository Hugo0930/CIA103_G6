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
		
		$("input#prodId").val($(this).data("id"));
		
		$("input#prodName").val($(this).data("name"));
		
		$("select#prodTypeId").val($(this).data("type"));
		
		$("input#prodBrand").val($(this).data("brand"));
		
		$("input#prodPrice").val($(this).data("price"));
		
		$("input#prodCount").val($(this).data("count"));
		
		$("input#prodRegTime").val($(this).data("date"));
		
		$("input#prodContent").val($(this).data("context"));
		
		$("select#prodStatus").val($(this).data("status"));
		
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
			window.location.href= "/CIA103G6-18Project/MyStudioServlet?action=get_all_std_on&page=1";
		}
		
		if(value === 'std_off'){
			window.location.href= "/CIA103G6-18Project/MyStudioServlet?action=get_all_std_off&page=1";
		}
		
		if(value === 'std_all'){
			window.location.href= "/CIA103G6-18Project/MyStudioServlet?action=get_all&page=1";
		}
	}
	
})

