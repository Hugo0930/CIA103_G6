package com.advertisement.model;

import java.sql.Date;
import java.util.List;

public class AdvertisementService {

	private AdvertisementDAO_interface dao;

	public AdvertisementService() {
		dao = new AdvertisementJDBCDAO();
	}

	public AdvertisementVO addAdvertisement(Integer advertisementId, Integer adminId, String title, String descript, String imgUrl,
			String targetUrl, Date strDate, Date endDate) {

		AdvertisementVO AdvertisementVO = new AdvertisementVO();

		AdvertisementVO.setAdvertisementId(advertisementId);
		AdvertisementVO.setAdminId(adminId);
		AdvertisementVO.setTitle(title);
		AdvertisementVO.setDescript(descript);
		AdvertisementVO.setImgUrl(imgUrl);
		AdvertisementVO.setTargetUrl(targetUrl);
		AdvertisementVO.setStrDate(strDate);
		AdvertisementVO.setEndDate(endDate);
		
		
		dao.insert(AdvertisementVO);

		return AdvertisementVO;
	}

	public AdvertisementVO updateAdvertisement(Integer advertisementId, Integer adminId, String title, String descript, String imgUrl,
			String targetUrl, Date strDate, Date endDate) {

		AdvertisementVO AdvertisementVO = new AdvertisementVO();

		AdvertisementVO.setAdvertisementId(advertisementId);
		AdvertisementVO.setAdminId(adminId);
		AdvertisementVO.setTitle(title);
		AdvertisementVO.setDescript(descript);
		AdvertisementVO.setImgUrl(imgUrl);
		AdvertisementVO.setTargetUrl(targetUrl);
		AdvertisementVO.setStrDate(strDate);
		AdvertisementVO.setEndDate(endDate);
		dao.update(AdvertisementVO);

		return AdvertisementVO;
	}

	public void deleteAdvertisement(Integer advertisementId) {
		dao.delete(advertisementId);
	}

	public AdvertisementVO getOneAdvertisement(Integer advertisementId) {
		return dao.findByPrimaryKey(advertisementId);
	}

	public List<AdvertisementVO> getAll() {
		return dao.getAll();
	}
}
