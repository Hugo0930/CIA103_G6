/**
 * 
 */
// 信用卡書入
$(function(){ //DOMContentLoaded
    $("div.card input.card_number").on("keydown",function(e){
        // console.log(e.keyCode); //48 ~ 57。
        // e.preventDefault();
        if ((e.which >= 48 && e.which <=57) || e.which == 8) {
            // console.log(e.target.value);
            // console.log(($(this).val()).length);
            if(($(this).val()).length == 0 && e.which == 8){
                // console.log("刪除數字");
                $(this).prev().prev().focus();
            }
        } else {
            e.preventDefault();
        }
    });


    $("div.card input.card_number").on("keyup",function(e){
        // console.log($(this).val());
		//輸入非數字會被替換成""
        let str = $(this).val().replace(/\D/g,"");
        // console.log(str);
        $(this).val(str);
        if(str.length == 4){
            $(this).next().next().focus();
        }
    });
})
// 按鈕點擊事件
document.getElementById("submit_btn").addEventListener("click", function() {
    const modal = document.getElementById("successModal");
    modal.style.display = "flex";

    // 自動隱藏彈窗
    setTimeout(() => {
        modal.style.display = "none";
		$("div.form-container form").submit();
    }, 3000);
    
});