package com.advertisement.model;

import java.util.*;



public interface AdvertisementDAO_interface {
	    public void insert(AdvertisementVO AdvertisementVO);
        public void update(AdvertisementVO AdvertisementVO);
        public void delete(Integer AD_ID);
        public AdvertisementVO findByPrimaryKey(Integer AD_ID);
        public List<AdvertisementVO> getAll();
//      public List<AdvertisementVO> getAll(Map<String, String[]> map); 

}
