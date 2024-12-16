package com.membertag.model;

import redis.clients.jedis.Jedis;
import redis.clients.jedis.JedisPool;
import redis.clients.jedis.Pipeline;
import redis.clients.jedis.exceptions.JedisConnectionException;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

import javax.sql.DataSource;

import com.utils.datasource.HikariDataSourceUtil;

public class TagService {

	private static final TagDAO tagDAO = new TagDAO();
	private static final TagCache tagCache = new TagCache();
	private static final DataSource ds = HikariDataSourceUtil.getDataSource();
	private static final JedisPool jedisPool = new JedisPool("localhost", 6379);

	// 🎉 新增標籤到 MySQL 和 Redis
	public void addTag(TagVO tag) throws SQLException {
		try (Connection connection = ds.getConnection()) {
			int tagId = tagDAO.addTag(tag);
			if (tagId != -1) {
				tag.setTagId(tagId);
				tagCache.updateTagInRedis(tag);
			}
		} catch (JedisConnectionException e) {
			System.err.println("【新增標籤失敗】Redis 連接失敗：" + e.getMessage());
		}
	}

	// 🎉 更新標籤
	public void updateTag(TagVO tag) throws SQLException {
		try (Connection connection = ds.getConnection()) {
			tagDAO.updateTag(tag);
			tagCache.updateTagInRedis(tag);
		} catch (JedisConnectionException e) {
			System.err.println("【更新標籤失敗】Redis 連接失敗：" + e.getMessage());
		}
	}

	// 🎉 根據 tagId 獲取單個標籤
	public TagVO getTag(int tagId) throws SQLException {
		TagVO tag = tagCache.getTagFromRedis(tagId);
		if (tag == null) {
			tag = tagDAO.getTagById(tagId);
			if (tag != null) {
				tagCache.updateTagInRedis(tag);
			}
		}
		return tag;
	}

	// 🎉 根據會員 ID 獲取會員的所有標籤
	public List<TagVO> getTags(int memId) throws SQLException {
		List<TagVO> tags = tagCache.getTagsFromRedis(memId);
		if (tags == null || tags.isEmpty()) {
			tags = tagDAO.getTagsByMemberId(memId);
			if (tags != null && !tags.isEmpty()) {
				tagCache.updateTagsInRedis(memId, tags);
			}
		}
		return tags;
	}

	// 🎉 新增會員的標籤
	public void addTagToMember(int memId, int tagId) throws SQLException {
		updateMemberTagRelation(memId, tagId, true);
	}

	// 🎉 刪除會員的標籤
	public void removeTagFromMember(int memId, int tagId) throws SQLException {
		updateMemberTagRelation(memId, tagId, false);
	}

	private void updateMemberTagRelation(int memId, int tagId, boolean isAdd) throws SQLException {
		String sql = isAdd ? "INSERT INTO MEMBER_TAG (MEM_ID, TAG_ID) VALUES (?, ?)"
				: "DELETE FROM MEMBER_TAG WHERE MEM_ID = ? AND TAG_ID = ?";

		try (Connection connection = ds.getConnection();
				PreparedStatement stmt = connection.prepareStatement(sql);
				Jedis jedis = jedisPool.getResource()) {

			stmt.setInt(1, memId);
			stmt.setInt(2, tagId);
			stmt.executeUpdate();

			Pipeline pipeline = jedis.pipelined();
			if (isAdd) {
				pipeline.sadd("MEMBER:" + memId + ":TAGS", String.valueOf(tagId));
				pipeline.sadd("TAG:" + tagId + ":MEMBERS", String.valueOf(memId));
			} else {
				pipeline.srem("MEMBER:" + memId + ":TAGS", String.valueOf(tagId));
				pipeline.srem("TAG:" + tagId + ":MEMBERS", String.valueOf(memId));
			}
			pipeline.sync();
		} catch (JedisConnectionException e) {
			System.err.println("【Redis 連接失敗】" + e.getMessage());
		}
	}

	// 🎉 透過類別 ID 獲取標籤列表
	public List<TagVO> getTagsByCategory(int categoryId) {
		try {
			return tagDAO.getTagsByCategory(categoryId);
		} catch (JedisConnectionException e) {
			System.err.println("【MySQL 獲取標籤類別失敗】類別ID: " + categoryId + "，錯誤訊息：" + e.getMessage());
			throw new RuntimeException(e);
		}
	}

	// 🔍 模糊搜尋標籤名稱，並獲取相關會員
	public Set<Integer> searchMembersByPartialTagName(String partialName) {
	    try (Jedis jedis = jedisPool.getResource()) {
	        // Redis 搜索
	        Set<String> tagIds = jedis.smembers("TAGS_BY_NAME:" + partialName);
	        if (tagIds.isEmpty()) {
	            return Set.of(); // 如果沒有匹配的標籤，返回空集合
	        }

	        // 查找擁有這些標籤的會員
	        String[] tagKeys = tagIds.stream()
	                                 .map(tagId -> "TAG:" + tagId + ":MEMBERS")
	                                 .toArray(String[]::new);
	        Set<String> memberIds = jedis.sinter(tagKeys);

	        // 將會員 ID 從字符串轉換為整數
	        return memberIds.stream().map(Integer::valueOf).collect(Collectors.toSet());
	    } catch (Exception e) {
	        System.err.println("【Redis 搜索失敗】錯誤：" + e.getMessage());
	        System.out.println("回退至資料庫搜尋...");

	        // 使用 DAO 進行資料庫查詢
	        List<Integer> memberIdsFromDB = tagDAO.searchMembersByPartialTagName(partialName);
	        return new HashSet<>(memberIdsFromDB); // 返回 Set<Integer>
	    }
	}

	// 🎉 從 MySQL 中獲取所有標籤
	public List<TagVO> getAllTagsFromMySQL() {
		try {
			return tagDAO.getAllTags();
		} catch (Exception e) {
			throw new RuntimeException("【獲取所有標籤失敗】MySQL 錯誤: " + e.getMessage(), e);
		}
	}

	// 🚀 將所有標籤批量同步到 Redis
	public void syncAllTagsToRedis(List<TagVO> tags) {
		try (Jedis jedis = jedisPool.getResource()) {
			Pipeline pipeline = jedis.pipelined();
			for (TagVO tag : tags) {
				String tagKey = "TAG:" + tag.getTagId();
				pipeline.hset(tagKey, "TAG_NAME", tag.getTagName());
				pipeline.hset(tagKey, "TAG_TYPE_NO", String.valueOf(tag.getTagTypeNo()));
			}
			pipeline.sync();
			System.out.println("【Redis 同步完成】同步標籤數量：" + tags.size());
		} catch (Exception e) {
			System.err.println("【Redis 同步失敗】錯誤：" + e.getMessage());
		}
	}

	// 🔥 關閉資源 (MySQL 連接和 Redis 連接)
	public void close() {
		if (jedisPool != null) {
			jedisPool.close();
		}
	}
}
