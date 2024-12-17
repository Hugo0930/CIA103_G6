/**
 * 
 */

$("#upload_btn").on("click",function(){
    $("input[type=file]").click();
})

$("input[type=file]").on("change",function(){

    console.log($(this).files);
    let reader = new FileReader(); // 用來讀取檔案
    reader.readAsDataURL(this.files[0]); // 讀取檔案
    reader.addEventListener("load", function () {
      //console.log(reader.result);
      let li_html = `<img src="${reader.result}" class="preview_img">`;
      $("div.preview").html(li_html);
    });
})