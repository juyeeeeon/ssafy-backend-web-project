package com.ssafy.enjoytrip.model.service;

import java.util.List;

import com.ssafy.enjoytrip.model.AttractionInfoDto;
import com.ssafy.enjoytrip.model.dao.AttractionDaoImpl;

public class AttractionServiceImpl implements AttractionService {

	private static AttractionService instance = new AttractionServiceImpl();

	private AttractionServiceImpl() {
	}

	public static AttractionService getInstance() {
		return instance;
	}

	@Override
	public List<AttractionInfoDto> attractionList(AttractionInfoDto attractionInfoDto) {
		return AttractionDaoImpl.getInstance().attractionList(attractionInfoDto);
	}

	@Override
	public List<AttractionInfoDto> searchByTitle(String title, int sidoCode) {
		return AttractionDaoImpl.getInstance().searchByTitle(title, sidoCode);
	}

}
