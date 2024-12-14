package com.advertisement.model;

import java.util.*;



public interface AdvertisementDAO_interface {
	    public void insert(AdvertisementVO AdvertisementVO);
        public void update(AdvertisementVO AdvertisementVO);
        public void delete(Integer advertisementId);
        public AdvertisementVO findByPrimaryKey(Integer advertisementId);
        public List<AdvertisementVO> getAll();
//      public List<AdvertisementVO> getAll(Map<String, String[]> map); 

}
