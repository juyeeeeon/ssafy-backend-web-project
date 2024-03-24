package com.ssafy.region.model.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.ssafy.region.model.RegionDto;
import com.ssafy.util.DBUtil;

public class RegionDaoImpl implements RegionDao {
	static public RegionDao instance = new RegionDaoImpl();

	private RegionDaoImpl() {
	}

	public static RegionDao getRegionDao() {
		return instance;
	}

	@Override
	public List<RegionDto> getAllSido() throws SQLException {
		DBUtil instance = DBUtil.getInstance();
		List<RegionDto> list = new ArrayList<RegionDto>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			conn = instance.getConnection();
			String sql = "select * from sido";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				RegionDto r = new RegionDto();
				r.setSidoCode(Integer.parseInt(rs.getString("sido_code")));
				r.setSidoName(rs.getString("sido_name"));
				list.add(r);
			}
		} finally {
			instance.close(rs, pstmt, conn);
		}

		return list;
	}

}
