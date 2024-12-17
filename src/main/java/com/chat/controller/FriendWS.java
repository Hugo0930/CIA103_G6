package com.chat.controller;

import java.io.IOException;
import java.util.Collection;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.concurrent.ConcurrentHashMap;

import javax.websocket.CloseReason;
import javax.websocket.OnClose;
import javax.websocket.OnError;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.PathParam;
import javax.websocket.server.ServerEndpoint;

import com.chat.jedis.JedisHandleMessage;
import com.chat.model.ChatMessage;
import com.chat.model.State;
import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

@ServerEndpoint("/FriendWS/{userName}")
public class FriendWS {
	/**記錄1對1對話的使用者**/
	private static Map<String, Session> sessionsMap = new ConcurrentHashMap<>();
	Gson gson = new Gson();

	@OnOpen
	public void onOpen(@PathParam("userName") String userName, Session userSession) throws IOException {
		/* save the new user in the map */
		userSession.setMaxTextMessageBufferSize(1024 * 1024 * 8);
		sessionsMap.put(userName, userSession);
		/* Sends all the connected users to the new user */
		Set<String> userNames = sessionsMap.keySet();
		State stateMessage = new State("open", userName, userNames);
		/**State 轉 json**/
		String stateMessageJson = gson.toJson(stateMessage);
		/**取得sessionMap中的值也就是userSession**/
		Collection<Session> sessions = sessionsMap.values();
		for (Session session : sessions) {
			if (session.isOpen()) {
				/**發送訊息給chat.jsp**/
				session.getAsyncRemote().sendText(stateMessageJson);
			}
		}
		/**%s字串，%n換行**/
		String text = String.format("Session ID = %s, connected; userName = %s%nusers: %s", userSession.getId(),
				userName, userNames);
		System.out.println(text);
	}

	@OnMessage
	public void onMessage(Session userSession, String message) {
		ChatMessage chatMessage = gson.fromJson(message, ChatMessage.class);
		String sender = chatMessage.getSender();
		String receiver = chatMessage.getReceiver();
		String time = chatMessage.getTime();
		String msgtype = chatMessage.getMsgType();
		/**點擊好友開始聊天取得歷史聊天紀錄**/
		if ("history".equals(chatMessage.getType())) {
			List<String> historyData = JedisHandleMessage.getHistoryMsg(sender, receiver);
			/**List 轉 Json格式的字串**/
			String historyMsg = gson.toJson(historyData);
			/** 存放歷史聊天紀錄 **/
			ChatMessage cmHistory = new ChatMessage("history", sender, receiver, historyMsg,time,msgtype);
			/**確認使用者上線**/
			if (userSession != null && userSession.isOpen()) {
				/**聊天室放歷史紀錄**/
				userSession.getAsyncRemote().sendText(gson.toJson(cmHistory));
				System.out.println("history = " + gson.toJson(cmHistory));
				return;
			}
		}

		Session receiverSession = sessionsMap.get(receiver);
		/**確認接收者上線**/
		if (receiverSession != null && receiverSession.isOpen()) {
			String type = chatMessage.getType();
			if(type.contains("question") || type.contains("match") || type.contains("audio")) {
				receiverSession.getAsyncRemote().sendText(message);
				JedisHandleMessage.saveChatMessage(sender, receiver, message);
			}else {				
				receiverSession.getAsyncRemote().sendText(message);
				userSession.getAsyncRemote().sendText(message);
				JedisHandleMessage.saveChatMessage(sender, receiver, message);
			}
		}
		System.out.println("Message received: " + message);
	}

	@OnError
	public void onError(Session userSession, Throwable e) {
		System.out.println("Error: " + e.toString());
	}

	@OnClose
	public void onClose(Session userSession, CloseReason reason) {
		String userNameClose = null;
		Set<String> userNames = sessionsMap.keySet();
		for (String userName : userNames) {
			if (sessionsMap.get(userName).equals(userSession)) {
				userNameClose = userName;
				sessionsMap.remove(userName);
				break;
			}
		}

		if (userNameClose != null) {
			State stateMessage = new State("close", userNameClose, userNames);
			/**State 轉 json**/
			String stateMessageJson = gson.toJson(stateMessage);
			/**取得sessionMap中的值也就是userSession**/
			Collection<Session> sessions = sessionsMap.values();
			for (Session session : sessions) {
				/** 發送訊息 **/
				session.getAsyncRemote().sendText(stateMessageJson);
			}
		}

		String text = String.format("session ID = %s, disconnected; close code = %d%nusers: %s", userSession.getId(),
				reason.getCloseCode().getCode(), userNames);
		System.out.println(text);
	}
}
