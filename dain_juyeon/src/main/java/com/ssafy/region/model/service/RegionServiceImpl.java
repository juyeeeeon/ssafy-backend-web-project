package com.ssafy.region.model.service;

import java.util.List;

import com.ssafy.region.model.RegionDto;
import com.ssafy.region.model.dao.RegionDaoImpl;

public class RegionServiceImpl implements RegionService{
	
	static public RegionService instance = new RegionServiceImpl();

	private RegionServiceImpl() { }

	public static RegionService getRegionService() {
		return instance;
	}
	
	@Override
	public List<RegionDto> getAllSido() throws Exception{
		return RegionDaoImpl.getRegionDao().getAllSido();
	}
}
