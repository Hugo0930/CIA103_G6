// JavaScript Document
window.onload = function(){
	showChater();
	scrollChater();
}
window.onscroll = scrollChater;
window.onresize = scrollChater;


function FocusItem(obj)
{
	obj.parentNode.parentNode.className = "current";
	var msgBox = obj.parentNode.getElementsByTagName("span")[0];
	msgBox.innerHTML = "";
	msgBox.className = "";
}

function CheckItem(obj)
{
	obj.parentNode.parentNode.className = "";
	var msgBox = obj.parentNode.getElementsByTagName("span")[0];
	switch(obj.name) {
		case "rePassWord":	
			 if(obj.value == ""){
				obj.value == " ";
			 }		
			 if(obj.value != document.getElementById("passWord").value) {
					msgBox.innerHTML = "<div><font style=' color: red; font-weight: bold; margin-bottom: 10px;'>兩次密碼輸入不同</font></div>";
					msgBox.className = "error";
					document.getElementById("sub").disabled= true;			
					return false;		
			 }else{
				document.getElementById("sub").disabled= false;
			 }
			 break;
		case "passWord":
			 if(obj.value == ""){
				obj.value == " ";
			  }			
			 if(obj.value != document.getElementById("rePassWord").value) {
					msgBox.innerHTML = "<div><font style=' color: red; font-weight: bold; margin-bottom: 10px;'>兩次密碼輸入不同</font></div>";
					msgBox.className = "error";
					document.getElementById("sub").disabled= true;			
					return false;
			 }else{
				document.getElementById("sub").disabled= false;
			}
			break;
	}
	
	return true;
}

function checkForm(frm)
{
	var els = frm.getElementsByTagName("input");
	for(var i=0; i<els.length; i++) {
		//if(typeof(els[i].getAttribute("onblur")) == "string") {
		if(typeof(els[i].getAttribute("onblur")) == "function") {
			if(!CheckItem(els[i])) return false;
		}
	}
	return true;
}

function showChater()
{
/*
	var _chater = document.createElement("div");
	_chater.setAttribute("id", "chater");
	var _dl = document.createElement("dl");
	var _dt = document.createElement("dt");
	var _dd = document.createElement("dd");
	var _a = document.createElement("a");
	_a.setAttribute("href", "#");
	_a.onclick = openRoom;
	_a.appendChild(document.createTextNode("在线聊天"));
	_dd.appendChild(_a);
	_dl.appendChild(_dt);
	_dl.appendChild(_dd);
	_chater.appendChild(_dl);
	document.body.appendChild(_chater);
	*/
}

function openRoom()
{
	window.open("chat-room.html","chater","status=0,scrollbars=0,menubar=0,location=0,width=600,height=400");
}

function scrollChater()
{
	var chater = document.getElementById("chater");
	var scrollTop = document.documentElement.scrollTop;
	var scrollLeft = document.documentElement.scrollLeft;
	//chater.style.left = scrollLeft + document.documentElement.clientWidth - 92 + "px";
	//chater.style.top = scrollTop + document.documentElement.clientHeight - 25 + "px";
}

function inArray(array, str)
{
	for(a in array) {
		if(array[a] == str) return true;
	}
	return false;
}

function setCookie(name,value)
{
  var Days = 30;
  var exp  = new Date();
  exp.setTime(exp.getTime() + Days*24*60*60*1000);
  document.cookie = name + "="+ escape(value) +";expires="+ exp.toGMTString();
}

function getCookie(name)
{
  var arr = document.cookie.match(new RegExp("(^| )"+name+"=([^;]*)(;|$)"));
  if(arr != null) return unescape(arr[2]); return null;
}

function delCookie(name)
{
  var exp = new Date();
  exp.setTime(exp.getTime() - 1);
  var cval=getCookie(name);
  if(cval!=null) document.cookie=name +"="+cval+";expires="+exp.toGMTString();
}

function goBuy(id, price)
{
	var newCookie = "";
	var oldCookie = getCookie("product");
	if(oldCookie) {
		if(inArray(oldCookie.split(","), id)) {
			newCookie = oldCookie;
		} else {
			newCookie = id + "," + oldCookie;
		}
	} else {
		newCookie = id;
	}
	setCookie("product", newCookie);
	location.href = "shopping.jsp";
}

function delShopping(id)
{
	var tr = document.getElementById("product_id_"+ id);
	var oldCookie = getCookie("product");
	if(oldCookie) {
		var oldCookieArr = oldCookie.split(",");
		var newCookieArr = new Array();
		for(c in oldCookieArr) {
			var cookie = parseInt(oldCookieArr[c]);
			if(cookie != id) newCookieArr.push(cookie);
		}
		var newCookie = newCookieArr.join(",");
		setCookie("product", newCookie);
	}
	if(tr) tr.parentNode.removeChild(tr);
}

function reloadPrice(id, status)
{
	var price = document.getElementById("price_id_" + id).getElementsByTagName("input")[0].value;
	var priceBox = document.getElementById("price_id_" + id).getElementsByTagName("span")[0];
	var number = document.getElementById("number_id_" + id);
	if(status) {
		number.value++;
	} else {
		if(number.value == 1) {
			return false;
		} else {
			number.value--;
		}
	}
	priceBox.innerHTML = "￥" + price * number.value;
}

var ajax;
function check(name){
	if(window.XMLHttpRequest){
		ajax=new XMLHttpRequest();
	}else if(window.ActiveXObject){
		ajax=new ActiveXObject();
		}
	var url="usernamecheck?name="+encodeURI(name)+"&"+new Date().getTime();
	ajax.onreadystatechange=check2;
	ajax.open("get",url,true);
	ajax.send();
}
function check2(){
	if(ajax.readyState==4 && ajax.status==200){
	var str=ajax.responseText;
	document.getElementById("sp").style.display="inline";
		if(str=='false'){
			document.getElementById("sp").innerHTML="<div><font style=' color: red; font-weight: bold; margin-bottom: 10px;'>賬號已被注冊</font></div>";
			//document.getElementById("sp").required.title="此用户名不可使用";
			document.getElementById("sub").disabled=true;
		}else if(str=='true'){
			document.getElementById("sp").innerHTML="<div><font style=' color: green; font-weight: bold; margin-bottom: 10px;'>賬號可以使用</font></div>";
			document.getElementById("sub").disabled=false;
		}else if(str=='space'){
			document.getElementById("sp").innerHTML="<div><font style=' color: red; font-weight: bold; margin-bottom: 10px;'>賬號不可空白</font></div>";
			document.getElementById("sub").disabled=false;
		}
	}
}

function change(img){
	img.src="usernum?"+new Date().getTime();
}
function Checknum(num){
	if(!CheckItem(num)){
		return;
	}
	
	if(window.XMLHttpRequest){
		ajax = new XMLHttpRequest();
	}else if(window.ActiveXObject){
		ajax = new ActiveXObject("Msxml.XMLHTTP");
	}
	ajax.onreadystatechange = Checknum2;
	var url="checkusernum?num="+encodeURI(num.value)+"&"+new Date().getTime();
	ajax.open("get",url,true);
	ajax.send();
	
	//alert('其他的js代码');
}

function Checknum2(){
	if(ajax.readyState==4 && ajax.status==200){
		var str = ajax.responseText.trim();
		document.getElementById("msg").style.display="inline";
		if(str=='false'){
			document.getElementById("msg").innerHTML="<div><font style=' color: red; font-weight: bold; margin-bottom: 10px;'>驗證碼錯誤</font></div>";
			document.getElementById("sub").disabled=true;
		}
		else {
			document.getElementById("msg").innerHTML="<font></font>";
			document.getElementById("sub").disabled=false;
		}
	}
}