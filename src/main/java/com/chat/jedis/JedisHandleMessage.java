package com.chat.jedis;

import java.util.List;

import redis.clients.jedis.Jedis;
import redis.clients.jedis.JedisPool;

/**
 * senderKey是sender:receiver
 * receiver是receiver:sender
 */
public class JedisHandleMessage {
	// 此範例key的設計為(發送者名稱:接收者名稱)，實際應採用(發送者會員編號:接收者會員編號)

	private static JedisPool pool = JedisPoolUtil.getJedisPool();
	/**將聊天訊息存redis取出**/
	public static List<String> getHistoryMsg(String sender, String receiver) {
		String key = new StringBuilder(sender).append(":").append(receiver).toString();
		Jedis jedis = null;
		jedis = pool.getResource();
		List<String> historyData = jedis.lrange(key, 0, -1);
		jedis.close();
		return historyData;
	}
	/**將聊天訊息存進redis**/
	public static void saveChatMessage(String sender, String receiver, String message) {
		// 對雙方來說，都要各存著歷史聊天記錄
		String senderKey = new StringBuilder(sender).append(":").append(receiver).toString();
		String receiverKey = new StringBuilder(receiver).append(":").append(sender).toString();
		Jedis jedis = pool.getResource();
		jedis.rpush(senderKey, message); //存下sender給receiver的訊息
		jedis.rpush(receiverKey, message);//存下receiver給sender的訊息

		jedis.close(); //關閉資源
	}

}
