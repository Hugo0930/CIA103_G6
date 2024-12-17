package com.chat.jedis;

import redis.clients.jedis.JedisPool;
import redis.clients.jedis.JedisPoolConfig;
/**
 * 最一開始連線池沒有建立，A、B執行緒同時進到getJedisPool()內，進入第1個if內
 * A執行緒先執行synchronized內的程式碼，建立連線池，則B執行緒被擋在外面
 * 等到A執行緒離開synchronized，B執行緒進去synchronized在用第2個if判斷連線池是否建立
 * 
 */
public class JedisPoolUtil {
	private static JedisPool pool = null;

	private JedisPoolUtil() {
	}
	/** 使用單例模式，確保每個執行緒取得相同的連線池 */
	public static JedisPool getJedisPool() {
		if (pool == null) {
			synchronized (JedisPoolUtil.class) {
				if (pool == null) {
					JedisPoolConfig config = new JedisPoolConfig();
					config.setMaxTotal(8);
					config.setMaxIdle(8);
					config.setMaxWaitMillis(10000);
					pool = new JedisPool(config, "localhost", 6379);
				}
			}
		}
		return pool;
	}

	// 可在ServletContextListener的contextDestroyed裡呼叫此方法註銷Redis連線池
	public static void shutdownJedisPool() {
		if (pool != null)
			pool.destroy();
	}
}
