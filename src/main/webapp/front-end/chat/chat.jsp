<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
<link rel="stylesheet" href="${pageContext.request.contextPath}/font-end/css/chat/friendchat.css" type="text/css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/font-end/css/chat/mystyle.css" type="text/css" />
<style type="text/css">
<%-- 1對1聊天室範例 --%>
</style>
<title>最大私人聊天室</title>
</head>
<%-- body綁定load事件，執行connect()函式 --%>
<body onload="connect();" onunload="disconnect();">
	<div id="row"></div>
	<div class="chat">
		<div class="icon_block">
			<i class="fa-solid fa-window-minimize"></i>
			<i class="fa-solid fa-xmark"></i>
		</div>
		<div class="name_block">
			<h3 id="statusOutput" class="statusOutput"></h3>
		</div>
		<div class="content">
			<div id="messagesArea" class="panel message-area"></div>
		</div>
		<div class="panel input-area">
			<%-- 按下enter鍵，執行sendMessage()函式 --%>
			<input id="message" class="text-field" type="text" placeholder="輸入訊息..." onkeydown="if (event.keyCode == 13) sendMessage();" /> 
			<div id="input_block">		
				<%--		
					<input type="button" id="connect" class="button" value="Connect" onclick="connect();" /> 
					<input type="button" id="disconnect" class="button" value="Disconnect" onclick="disconnect();" />
				 --%>
				<input type="file" accept="audio/*" id="upload_audio">
				<button type="button" id="audio_btn"><i class="fa-solid fa-file-audio fa-2x"></i></button>
				<button type="button" id="match_btn"><i class="fa-solid fa-hand fa-2x"></i></button>
				<input type="submit" id="sendMessage" class="button" value="傳送" onclick="sendMessage();" /> 
				<span><i class="fa-solid fa-paper-plane fa-lg"></i></span>
			</div>
		</div>
	</div>
</body>
<script src="${pageContext.request.contextPath}/back-end/vendor/jquery-3.7.1.min.js"></script>
<script src="https://kit.fontawesome.com/155106be6f.js" crossorigin="anonymous"></script>
<script>
	/**使用EL取出userName的值，userName也就是使用者輸入的名稱**/
	var MyPoint = "/FriendWS/${userName}";
	var host = window.location.host;
	var path = window.location.pathname;
	var webCtx = path.substring(0, path.indexOf('/', 1));
	var endPointURL = "ws://" + window.location.host + webCtx + MyPoint;

	var statusOutput = document.getElementById("statusOutput");
	var messagesArea = document.getElementById("messagesArea");
	/**self就是指自己也就是輸入的使用者名稱**/
	var self = '${userName}';
	var webSocket;

	function connect() {
		// create a websocket
		webSocket = new WebSocket(endPointURL);
		
		webSocket.onopen = function(event) {
			console.log("Connect Success!");
			/*設定按鈕哪些可以點選*/
			document.getElementById('sendMessage').disabled = false;
			//document.getElementById('connect').disabled = true;
			//document.getElementById('disconnect').disabled = false;
		};

		webSocket.onmessage = function(event) {
			/*接收資料*/		
			var	jsonObj = JSON.parse(event.data);
			if ("open" === jsonObj.type) {
				refreshFriendList(jsonObj);
			} else if ("history" === jsonObj.type) {
				messagesArea.innerHTML = '';
				var ul = document.createElement('ul');
				ul.id = "area";
				messagesArea.appendChild(ul);
				// 這行的jsonObj.message是從redis撈出跟好友的歷史訊息，再parse成JSON格式處理
				var messages = JSON.parse(jsonObj.message);
				for (var i = 0; i < messages.length; i++) {
					var historyData = JSON.parse(messages[i]);
					var li = document.createElement('li');
					var showMsg = historyData.message;
					// 根據發送者是自己還是對方來給予不同的class名, 以達到訊息左右區分
					historyData.sender === self ? li.className += 'me' : li.className += 'friend';
					if("text" === historyData.msgtype){
						li.innerHTML = showMsg;
						var span = document.createElement('span');
						span.innerHTML = historyData.time;
						historyData.sender === self ? span.className += 'me' : span.className += 'friend';
						li.appendChild(span);
						ul.appendChild(li);
					}else if("sound" === historyData.msgtype){
						let dir_span = null;
						let dir_li = null;
						if(historyData.sender == self){
							dir_li = 'me';
							dir_span = 'me ' + 'mysound';
						}else{
							dir_li = 'friend';
							dir_span = 'friend ' + 'yoursound';
						}
						let audio_html2 = '';
						audio_html2 += '<li class="' + dir_li + '" style="background:none;"' + '>'
						audio_html2 += '<audio controls controlsList="nodownload">';
						audio_html2 += '<source src="' + showMsg + '"/>';
						audio_html2 += '</audio>';
						audio_html2 += '<span class="' + dir_span + '">' + historyData.time +'</span>';
						audio_html2 += '</li>';
						ul.insertAdjacentHTML('beforeend', audio_html2);
					}
					
				}
				messagesArea.scrollTop = messagesArea.scrollHeight;
			} else if ("chat" === jsonObj.type) {
				var span = document.createElement('span');
				span.innerHTML = jsonObj.time;
				var li = document.createElement('li');
				jsonObj.sender === self ? li.className += 'me' : li.className += 'friend';
				//console.log(li.className);
				jsonObj.sender === self ? span.className += 'me' : span.className += 'friend';
				li.innerHTML += jsonObj.message;
				li.appendChild(span);
				//console.log(li);
				document.getElementById("area").appendChild(li);
				messagesArea.scrollTop = messagesArea.scrollHeight;
			} else if ("close" === jsonObj.type) {
				refreshFriendList(jsonObj);
			} else if ("question" === jsonObj.type){
				//console.log(jsonObj);
				let time = getCurrentTime();
				let message = jsonObj.message;
				if(message.length > 0){
					let question_block = `
						<li class="friend">
							<div class="match_block">
								<p>是否接受媒合?</p>
								<button type="button" id="yes_btn" class="friend">同意</button>
								<button type="button" id="no_btn" class="friend">不同意</button>
							</div>`;
					question_block += '<span class="yourmatch">' + time + '</span>' +'</li>'
					$("ul#area").append(question_block);
					findLastMatch();
	
				}
			} else if("match" === jsonObj.type){
				//console.log(jsonObj);
				
				if(jsonObj.message === "yes"){
					$("button#no_btn").attr("disabled","true");
					$("button#yes_btn").addClass("agreed");
					alert("媒合成功!");
				}
				
				if(jsonObj.message === 'no'){
					$("button#yes_btn").attr("disabled","true");
					$("button#no_btn").addClass("disagreed");
					alert("媒合失敗!");
					
				}
			} else if("audio" === jsonObj.type){
				//console.log(jsonObj);
				let person = null;
				if(jsonObj.sender == self){
					person = 'me ' + 'mysound';
				}else{
					person = 'friend ' + 'yoursound';
				}
				
				let base64 = jsonObj.message;
				let audio_html = '';
				audio_html += '<li class="friend_audio">'
				audio_html += '<audio controls controlsList="nodownload">';
				audio_html += '<source src="' + base64 + '"/>';
				audio_html += '</audio>';
				audio_html += '<span class="' + person + '">' + jsonObj.time +'</span>';
				audio_html += '</li>';
				$("div#messagesArea ul").append(audio_html);
			}
			
			
		};

		webSocket.onclose = function(event) {
			console.log("Disconnected!");
		};
	}
	
	function sendMessage() {
		let time = getCurrentTime();
		
		var inputMessage = document.getElementById("message");
		var friend = statusOutput.textContent;
		var message = inputMessage.value.trim();
		
		if (message === "") {
			alert("Input a message");
			inputMessage.focus();
		} else if (friend === "") {
			alert("Choose a friend");
		} else {
			var jsonObj = {
				"type" : "chat",
				"sender" : self,
				"receiver" : friend,
				"message" : message,
				"time" : time,
				"msgtype" : "text"
			};
			webSocket.send(JSON.stringify(jsonObj));
			inputMessage.value = "";
			inputMessage.focus();
		}
	}
	
	// 有好友上線或離線就更新列表
	function refreshFriendList(jsonObj) {
		var friends = jsonObj.users;
		var row = document.getElementById("row");
		row.innerHTML = '';
		for (var i = 0; i < friends.length; i++) {
			/**如果是自己則不需要在好友名單上顯示自己的名稱**/
			if (friends[i] === self) { continue; }
			row.innerHTML +='<div id=' + i + ' class="column" name="friendName" value=' + friends[i] + ' ><h2>' + friends[i] + '</h2></div>';
		}
		addListener();
	}
	// 註冊列表點擊事件並抓取好友名字以取得歷史訊息
	function addListener() {
		var container = document.getElementById("row");
		container.addEventListener("click", function(e) {
			var friend = e.srcElement.textContent;
			updateFriendName(friend);
			var jsonObj = {
					"type" : "history",
					"sender" : self,
					"receiver" : friend,
					"message" : "",
					"msgtype" : ""
				};
			webSocket.send(JSON.stringify(jsonObj));
		});
	}
	
	function disconnect() {
		webSocket.close();
		document.getElementById('sendMessage').disabled = true;
		document.getElementById('connect').disabled = false;
		document.getElementById('disconnect').disabled = true;
	}
	
	function updateFriendName(name) {
		statusOutput.innerHTML = name;
	}
	/*****************************我的程式碼****************************/
	$("button#audio_btn").on("click",function(){
		$("input#upload_audio").click();
	})
	
	$("input#upload_audio").on("change",function(){
			let time = getCurrentTime();
			let file = this.files[0];
			//console.log(file);
			let li = document.createElement("li");
			li.className += 'me_audio';
			let audio = document.createElement("audio");
			let objURL = URL.createObjectURL(file);
			audio.setAttribute("src",objURL);
			audio.setAttribute("controls",true);
			audio.setAttribute("controlsList","nodownload");
			let span = document.createElement('span');
			span.className += 'me mysound';
			span.textContent = time;
			li.appendChild(audio);
			li.appendChild(span);
			let reader = new FileReader();
			reader.readAsDataURL(file);
			let friend = statusOutput.textContent;
			let base64;
			reader.addEventListener("load",function(){
				base64 = reader.result;
				//console.log(base64);
				//console.log(typeof(base64));
				let jsonObj = {
						type : "audio",
						sender : self,
						receiver : friend,
						message : base64,
						time : time,
						msgtype : "sound"
				};
				if(jsonObj != null){
					//console.log(jsonObj);
					webSocket.send(JSON.stringify(jsonObj));				
					$("div#messagesArea ul").append(li);
				}
			});
			
			
		})
	
	$("button#match_btn").on("click",function(){
		//alert("ttt");	
		let receiver = statusOutput.textContent;
		let time = getCurrentTime();
		let question = {
				type : "question",
				sender : self,
				receiver : receiver,
				message : "是否同意媒合?",
				time : time,
				msgtype : "question"
		}
		let question_block = `
			<li class="me">
				<div class="match_block">
					<p>是否接受媒合?</p>
					<button type="button" id="yes_btn">同意</button>
					<button type="button" id="no_btn">不同意</button>
				</div>`;
		question_block += '<span class="mymatch">' + time + '</span>' +'</li>'
		$("ul#area").append(question_block);
		webSocket.send(JSON.stringify(question));
		findLastMatch();
	})
	

	
	$("div#messagesArea").on("click",'button.friend',function(){
		//alert("ttt");
		let friend = statusOutput.textContent;
		//console.log(this);
		let response = null;
		if($(this).text() === '同意'){
			response = {
				type : "match",
				sender : self,
				receiver : friend,
				message : "yes",
				msgtype : "question"
			}
			$("button#no_btn").attr("disabled","true");
			$(this).addClass("agreed");
		}
		
		if($(this).text() === '不同意'){
			response = {
				type : "match",
				sender : self,
				receiver : "L",
				message : "no",
				msgtype : "question"
			}
			$("button#yes_btn").attr("disabled","true");
			$(this).addClass("disagreed")
		}
		//console.log(response);
		webSocket.send(JSON.stringify(response));
	})
	
	$("i.fa-xmark").on("click",function(){
		$("div.chat").hide();
	})
	/********函式**********/
	function findLastMatch(){
		$("div.match_block").each(function(index,item){
			let last_item = $("div.match_block").last().get(0);
			//console.log("last_item: " + last_item);
			//console.log("item_length: " + $("div.match_block").length);
			//console.log('item: ' + item);
			if($("div.match_block").length === 1 && item === last_item){
				last_item.classList.add("last_match");
			}
			
			if($("div.match_block").length > 1){
				if(item === last_item){
					item.classList.add("last_match");
				}else{
					item.classList.remove("last_match");
				}
			}
		})
	}
	function getCurrentTime(){
		let today = new Date();
		let time = today.toLocaleTimeString([], { hour: "2-digit", minute: "2-digit", hour12: false});
		return time;
		//console.log(today.toLocaleTimeString([], { hour: "2-digit", minute: "2-digit", hour12: false}),);
	}
</script>
</html>