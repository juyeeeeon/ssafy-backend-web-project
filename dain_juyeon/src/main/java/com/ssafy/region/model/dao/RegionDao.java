package com.ssafy.region.model.dao;

import java.sql.SQLException;
import java.util.List;

import com.ssafy.region.model.RegionDto;

public interface RegionDao {
	List<RegionDto> getAllSido() throws SQLException;
}
