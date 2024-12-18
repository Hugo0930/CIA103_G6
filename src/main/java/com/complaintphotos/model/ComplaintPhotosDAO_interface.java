package com.complaintphotos.model;

	import java.util.List;

import com.complaint.model.ComplaintVO;

public interface ComplaintPhotosDAO_interface {
	    
		public void insert(ComplaintPhotosVO vo);
	    public void update(ComplaintPhotosVO vo);
	    public List<ComplaintPhotosVO> findAll();
	    public List<ComplaintPhotosVO> findPhotosByComplaintId(Integer complaintId);

	}

