package com.membertag.model;

import java.util.ArrayList;
import java.util.List;
import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import com.utils.datasource.HikariDataSourceUtil;

public class TagDAO {

	// 取得資料庫連線的 DataSource (HikariDataSource)
	private static final DataSource ds = HikariDataSourceUtil.getDataSource();

	// SQL 語句
	private static final String SELECT_ALL_TAGS = "SELECT TAG_ID, TAG_NAME, TAG_TYPE_NO FROM TAG";

	private static final String INSERT_TAG = "INSERT INTO TAG (TAG_NAME, TAG_TYPE_NO) VALUES (?, ?)";

	private static final String SELECT_TAG_BY_ID = "SELECT TAG_ID, TAG_NAME, TAG_TYPE_NO FROM TAG WHERE TAG_ID = ?";

	private static final String SELECT_TAGS_BY_MEMBER_ID = "SELECT t.TAG_ID, t.TAG_NAME, t.TAG_TYPE_NO FROM TAG t "
			+ "JOIN MEMBER_TAGS mt ON t.TAG_ID = mt.TAG_ID " + "WHERE mt.MEMBER_ID = ?";

	private static final String UPDATE_TAG = "UPDATE TAG SET TAG_NAME = ?, TAG_TYPE_NO = ? WHERE TAG_ID = ?";

	private static final String SELECT_TAGS_BY_CATEGORY = "SELECT TAG_ID, TAG_NAME, TAG_TYPE_NO FROM TAG WHERE TAG_TYPE_NO = ?";

	/**
	 * 查詢所有標籤
	 */
	public List<TagVO> getAllTags() {
		List<TagVO> tagList = new ArrayList<>();
		try (Connection connection = ds.getConnection();
				PreparedStatement pstmt = connection.prepareStatement(SELECT_ALL_TAGS);
				ResultSet rs = pstmt.executeQuery()) {

			while (rs.next()) {
				TagVO tag = new TagVO(rs.getInt("TAG_ID"), rs.getInt("TAG_TYPE_NO"), rs.getString("TAG_NAME"));
				tagList.add(tag);
			}
		} catch (SQLException e) {
			System.err.println("查詢所有標籤失敗，錯誤訊息: " + e.getMessage());
			throw new RuntimeException(e);
		}
		return tagList;
	}

	/**
	 * 新增標籤
	 */
	public int addTag(TagVO tag) {
		try (Connection connection = ds.getConnection();
				PreparedStatement pstmt = connection.prepareStatement(INSERT_TAG, Statement.RETURN_GENERATED_KEYS)) {

			pstmt.setString(1, tag.getTagName());
			pstmt.setInt(2, tag.getTagTypeNo());
			pstmt.executeUpdate();

			try (ResultSet rs = pstmt.getGeneratedKeys()) {
				if (rs.next()) {
					return rs.getInt(1);
				}
			}
		} catch (SQLException e) {
			System.err.println("新增標籤失敗: " + e.getMessage());
			throw new RuntimeException(e);
		}
		return -1;
	}

	/**
	 * 根據標籤ID查詢標籤
	 */
	public TagVO getTagById(int tagId) {
		try (Connection connection = ds.getConnection();
				PreparedStatement pstmt = connection.prepareStatement(SELECT_TAG_BY_ID)) {

			pstmt.setInt(1, tagId);
			try (ResultSet rs = pstmt.executeQuery()) {
				if (rs.next()) {
					return new TagVO(tagId, rs.getInt("TAG_TYPE_NO"), rs.getString("TAG_NAME"));
				}
			}
		} catch (SQLException e) {
			System.err.println("查詢標籤失敗，TAG_ID: " + tagId + "，錯誤訊息: " + e.getMessage());
			throw new RuntimeException(e);
		}
		return null;
	}

	/**
	 * 查詢會員的所有標籤
	 */
	public List<TagVO> getTagsByMemberId(int memId) {
		List<TagVO> tags = new ArrayList<>();
		try (Connection connection = ds.getConnection();
				PreparedStatement pstmt = connection.prepareStatement(SELECT_TAGS_BY_MEMBER_ID)) {

			pstmt.setInt(1, memId);
			try (ResultSet rs = pstmt.executeQuery()) {
				while (rs.next()) {
					tags.add(new TagVO(rs.getInt("TAG_ID"), rs.getInt("TAG_TYPE_NO"), rs.getString("TAG_NAME")));
				}
			}
		} catch (SQLException e) {
			System.err.println("查詢會員標籤失敗: " + e.getMessage());
			throw new RuntimeException(e);
		}
		return tags;
	}

	/**
	 * 更新標籤
	 */
	public void updateTag(TagVO tag) {
		try (Connection connection = ds.getConnection();
				PreparedStatement pstmt = connection.prepareStatement(UPDATE_TAG)) {

			pstmt.setString(1, tag.getTagName());
			pstmt.setInt(2, tag.getTagTypeNo());
			pstmt.setInt(3, tag.getTagId());

			int rowCount = pstmt.executeUpdate();
			if (rowCount == 0) {
				throw new SQLException("更新失敗，標籤ID: " + tag.getTagId() + " 不存在");
			}
		} catch (SQLException e) {
			System.err.println("更新標籤失敗: " + e.getMessage());
			throw new RuntimeException(e);
		}
	}

	/**
	 * 透過類別查詢標籤
	 */
	public List<TagVO> getTagsByCategory(int categoryId) {
		List<TagVO> tagList = new ArrayList<>();
		try (Connection connection = ds.getConnection();
				PreparedStatement pstmt = connection.prepareStatement(SELECT_TAGS_BY_CATEGORY)) {

			pstmt.setInt(1, categoryId);
			try (ResultSet rs = pstmt.executeQuery()) {
				while (rs.next()) {
					tagList.add(new TagVO(rs.getInt("TAG_ID"), rs.getInt("TAG_TYPE_NO"), rs.getString("TAG_NAME")));
				}
			}
		} catch (SQLException e) {
			System.err.println("查詢標籤類別失敗: " + e.getMessage());
			throw new RuntimeException(e);
		}
		return tagList;
	}

	public List<Integer> searchMembersByPartialTagName(String partialName) {
		String sql = "SELECT DISTINCT mt.MEM_ID FROM member_tag mt " + "JOIN tag t ON mt.TAG_ID = t.TAG_ID "
				+ "WHERE t.TAG_NAME LIKE ?";
		List<Integer> memberIds = new ArrayList<>();

		try (Connection connection = ds.getConnection(); PreparedStatement pstmt = connection.prepareStatement(sql)) {

			pstmt.setString(1, "%" + partialName + "%");

			try (ResultSet rs = pstmt.executeQuery()) {
				while (rs.next()) {
					memberIds.add(rs.getInt("MEM_ID"));
				}
			}
		} catch (SQLException e) {
			throw new RuntimeException("資料庫模糊搜尋失敗，錯誤訊息：" + e.getMessage(), e);
		}

		return memberIds;
	}

	public static void main(String[] args) {
		TagService tagService = new TagService();
		try {
			int categoryId = 2; // 例如，這是標籤類別 "語言" 的 ID
			List<TagVO> tags = tagService.getTagsByCategory(categoryId);

			System.out.println("【標籤列表】 類別ID: " + categoryId);
			for (TagVO tag : tags) {
				System.out.println(tag);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			tagService.close();
		}
	}
}
