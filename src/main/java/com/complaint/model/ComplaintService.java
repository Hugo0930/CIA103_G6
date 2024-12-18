package com.complaint.model;

import java.util.List;

import com.complaintphotos.model.ComplaintPhotosDAO;
import com.complaintphotos.model.ComplaintPhotosVO;

public class ComplaintService {

	private ComplaintDAO_interface dao;
	private ComplaintPhotosDAO photoDao;

	public ComplaintService() {
		dao = new ComplaintDAO();
		photoDao = new ComplaintPhotosDAO();
	}

	// 🚀 僅更新 申訴狀態 和 處理結果
	public ComplaintVO updateStatusAndResult(Integer complaintId, Byte complaintStatus, String complaintResult) {
		ComplaintVO complaintVO = new ComplaintVO();
		complaintVO.setComplaintId(complaintId);
		complaintVO.setComplaintStatus(complaintStatus);
		complaintVO.setComplaintResult(complaintResult);
		dao.updateStatusAndResult(complaintVO);
		return complaintVO;
	}

	// **🚀 查詢單一申訴**
	public ComplaintVO getOneComplaint(Integer complaintId) {
		return dao.findByPrimaryKey(complaintId);
	}

	// **🚀 查詢所有申訴**
	public List<ComplaintVO> getAll() {
		return dao.getAll();
	}

	// **🚀 查詢指定會員的所有申訴**
	public List<ComplaintVO> getAllByMemberId(Integer memberId) {
		return dao.getAllByMemberId(memberId);
	}

	public Integer addComplaintWithPhotos(Integer memberId, Integer caseId, String complaintCon,
			List<ComplaintPhotosVO> photos) {
		ComplaintVO complaintVO = new ComplaintVO();
		complaintVO.setMemberId(memberId);
		complaintVO.setCaseId(caseId);
		complaintVO.setComplaintCon(complaintCon);
		return dao.insertWithPhotos(complaintVO, photos);
	}

	public ComplaintVO getOneComplaintByComIdAndMemId(Integer comId, Integer memberId) {
		return dao.getOneComplaintByComIdAndMemId(comId, memberId);
	}

	// 🚀 查詢申訴相關的所有照片
	public List<ComplaintPhotosVO> getPhotosByComplaintId(Integer complaintId) {
		return photoDao.findPhotosByComplaintId(complaintId);
	}
}
