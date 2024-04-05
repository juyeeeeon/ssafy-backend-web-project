package com.ssafy.enjoytrip.model.service;

import java.util.List;

import com.ssafy.enjoytrip.model.AttractionInfoDto;
import com.ssafy.enjoytrip.model.dao.AttractionDao;
import com.ssafy.enjoytrip.model.dao.AttractionDaoImpl;

public class AttractionServiceImpl implements AttractionService {
	private static AttractionDao attractionDao;

	private static AttractionService instance = new AttractionServiceImpl();

	private AttractionServiceImpl() {
		attractionDao = AttractionDaoImpl.getInstance();
	}

	public static AttractionService getInstance() {
		return instance;
	}

	@Override
	public List<AttractionInfoDto> attractionList(AttractionInfoDto attractionInfoDto) {
		return attractionDao.attractionList(attractionInfoDto);
	}

	@Override
	public List<AttractionInfoDto> searchByTitle(String title, int sidoCode) {
		return attractionDao.searchByTitle(title, sidoCode);
	}

}
