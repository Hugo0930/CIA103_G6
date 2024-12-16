package com.complaint.model;

import java.util.*;

import com.complaintphotos.model.ComplaintPhotosVO;

public interface ComplaintDAO_interface {

	// 僅更新 申訴狀態 和 處理結果
	void updateStatusAndResult(ComplaintVO complaintVO);

	// 依主鍵查詢申訴案件
	ComplaintVO findByPrimaryKey(Integer complaintId);

	// 查詢所有申訴
	List<ComplaintVO> getAll();

	// 依會員ID查詢申訴
	List<ComplaintVO> getAllByMemberId(Integer memberId);

	Integer insertWithPhotos(ComplaintVO complaintVO, List<ComplaintPhotosVO> photos);

	ComplaintVO getOneComplaintByComIdAndMemId(Integer comId, Integer memberId);

	// 萬用複合查詢(傳入參數型態Map)(回傳 List)
	// public List<ComplaintVO> getAll(Map<String, String[]> map);
}
