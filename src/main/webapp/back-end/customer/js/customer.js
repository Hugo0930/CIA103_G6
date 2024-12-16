/**
 * 
 */

$("table.main").on("click","button.lookup_btn",function(){
	//alert('ttt');
	$("div.see_view_block").show();
	let caseId = $(this).closest("tr").find("td").eq(0).text();
	let memId = $(this).closest("tr").find("td").eq(1).text();
	let subject = $(this).closest("tr").find("td").eq(2).text();
	let type = $(this).closest("tr").find("td").eq(3).text();
	let questionType = $(this).closest("tr").find("td").eq(4).text();
	let question = $(this).closest("tr").find("td").eq(5).text();
	let reply = $(this).closest("tr").find("td").eq(6).text();
	let state = $(this).closest("tr").find("td").eq(7).text();
	let updatedAt = $(this).closest("tr").find("td").eq(8).text();
	let createdAt = $(this).closest("tr").find("td").eq(9).text();
	$("div.see_view tr:nth-child(1)").find("td").last().text(caseId);
	$("div.see_view tr:nth-child(2)").find("td").last().text(memId);
	$("div.see_view tr:nth-child(3)").find("td").last().text(subject);
	$("div.see_view tr:nth-child(4)").find("td").last().text(type);
	$("div.see_view tr:nth-child(5)").find("td").last().text(questionType);
	$("div.see_view tr:nth-child(6)").find("td").last().text(question);
	$("div.see_view tr:nth-child(7)").find("td").last().text(reply);
	$("div.see_view tr:nth-child(8)").find("td").last().text(state);
	$("div.see_view tr:nth-child(9)").find("td").last().text(updatedAt);
	$("div.see_view tr:nth-child(10)").find("td").last().text(createdAt);
})

$("button#close_btn2").on("click",function(){
	$("div.see_view_block").hide();
})

$("table.main").on("click","button.reply_btn",function(){
	//alert('zzz');
	//console.log($(this).closest("tr").find("td").get(0).textContent);
	let caseId = $(this).closest("tr").find("td").eq(0).text();
	let memId = $(this).closest("tr").find("td").eq(1).text();
	let subject = $(this).closest("tr").find("td").eq(2).text();
	let type = $(this).closest("tr").find("td").eq(3).text();
	let questionType = $(this).closest("tr").find("td").eq(4).text();
	let question = $(this).closest("tr").find("td").eq(5).text();
	let reply = $(this).closest("tr").find("td").eq(6).text();
	let state = $(this).closest("tr").find("td").eq(7).text();
	let updatedAt = $(this).closest("tr").find("td").eq(8).text();
	let createdAt = $(this).closest("tr").find("td").eq(9).text();
	
	$("div.reply_view input#caseId").val(caseId);
	$("div.reply_view input#memId").val(memId);
	$("div.reply_view input#subject").val(subject);
	$("div.reply_view select#typeInput").val(type);
	$("div.reply_view input#stateInput").val('已回覆');
	$("div.reply_view textarea#reply").val(reply);
	
	$("div.reply_view").show();
})

$("button#close_btn").on("click",function(){
	//alert('ttt');
	$("div.reply_view").hide();
 
})

$("div.lookup form").on("click","button",function(){
	//alert('ttt');
	let btn_id = this.id;
	//console.log(btn_id);
	$('div.lookup form input[type="hidden"]').remove();
	if(btn_id === 'no_reply'){
		//$('div.lookup form input[name="action"]').val("get_all_no_reply_case");
		$("div.lookup form").append('<input type="hidden" name="action" value="get_all_no_reply_case">');
	}else if(btn_id === 'reply'){
		//$('div.lookup form input[name="action"]').val("get_all_reply_case");
		$("div.lookup form").append('<input type="hidden" name="action" value="get_all_reply_case">');
	}else if(btn_id === 'get_all'){
		//$('div.lookup form input[name="action"]').val("get_all_case");
		$("div.lookup form").append('<input type="hidden" name="action" value="get_all_case">');
	}else if(btn_id === 'lookup_btn'){
		if($("input#inputId").val() === ''){
			alert("請輸入案件編號");
			return false;
		}else{
			//console.log($("table.main tbody tr td:first-child()"));
			
			let input_value = $("input#inputId").val();
			let found = false;
			$("table.main tbody tr td:first-child()").each(function(index,item){
				let case_id = item.textContent.trim(); // 確保去掉多餘的空格
			    //console.log(case_id);
			    if (input_value === case_id) {
			       alert('案件紀錄存在');
			       $("div.lookup form").append('<input type="hidden" name="action" value="get_one_case">');
			       found = true; // 設定找到的狀態
			       return false; // 結束迴圈
			    }

			})
			// 如果沒找到，顯示提示訊息
			if (!found) {
			    alert('查無資料');
				$("input#inputId").val("");
				return false;
			} else{
				$("div.lookup form").submit();
			}
			
		}
	}
	$("div.lookup form").submit();
})


$("select#sort_type").on("change",function(){
	//alert('ttt');
	var sort_type = $(this).val();
	$('div.lookup form input[name="last_search"]').remove();
	var last_state = $("input#last_state").val();
		console.log('last_state:' + last_state);
	
	if(last_state === undefined){
		/* 狀態改變時，lastState無值 */
		$("div.lookup form").append('<input type="hidden" name="last_search" value="get_all_reply_case">');
	}else{
		/* 狀態改變時，lastState有值 */
		$("div.lookup form").append('<input type="hidden" name="last_search" value="' + last_state +'">');
	}
	let submit_btn = $("button#lookup_btn").get(0);
	if(sort_type != '請選擇排序'){
		if(sort_type === '遞增排序'){
			sort_type = 'asc';
			$("div.lookup form").append('<input type="hidden" name="sort_type" value="' + sort_type +'">');
		}
		
		if(sort_type === '遞減排序'){
			sort_type = 'desc';
			$("div.lookup form").append('<input type="hidden" name="sort_type" value="' + sort_type +'">');
		}
	}
	$("div.lookup form").append('<input type="hidden" name="action" value="lookup">');
	$("div.lookup form").submit();
})

$("textarea#reply").on("blur",function(){
	//console.log($(this).val());
	//console.log($("input#stateInput").val());
	if($(this).val() === ''){
		alert("請輸入回覆訊息!");
	}else{
		$("input#stateInput").val("已回覆");
		if(confirm("確認送出")){
			$("div.reply_view form").submit();
		}
	}
	
})

