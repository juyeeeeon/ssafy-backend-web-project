package com.ssafy.member.model.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.ssafy.member.model.MemberDto;
import com.ssafy.util.DBUtil;

public class MemberDaoImpl implements MemberDao {

	static private MemberDao instance = new MemberDaoImpl();

	private MemberDaoImpl() {
	}

	static public MemberDao getMemberDao() {
		return instance;
	}

	@Override
	public boolean registerMember(MemberDto memberDto) {
		DBUtil instance = DBUtil.getInstance();
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = DBUtil.getInstance().getConnection();
			pstmt = conn.prepareStatement(
					"insert into members " + "(user_id, user_password, email_id, user_name)"
							+ "values (?, ?, ?, ?);");

			pstmt.setString(1, memberDto.getUserId());
			pstmt.setString(2, memberDto.getUserPass());
			pstmt.setString(3, memberDto.getUserEmail());
			pstmt.setString(4, memberDto.getUserName());
			if (pstmt.executeUpdate() == 0) {
				return false;
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			instance.close(conn, pstmt);
		}
		return true;
	}

	@Override
	public MemberDto login(String userId, String userPass) {
		System.out.println(userId+" "+userPass);
		MemberDto memberDto = findMember(userId);
		System.out.println(memberDto.getUserId()+" " + memberDto.getUserPass());
		if (memberDto == null)
			return null;
		if (!userPass.equals(memberDto.getUserPass()))
			return null;

		return memberDto;
	}

	@Override
	public boolean modifyMember(MemberDto memberDto) {
		DBUtil instance = DBUtil.getInstance();
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = DBUtil.getInstance().getConnection();
			pstmt = conn.prepareStatement("update members set user_password = ?, email_id = ?, user_name = ? where user_id = ?;");
			pstmt.setString(1, memberDto.getUserPass());
			pstmt.setString(2, memberDto.getUserEmail());
			pstmt.setString(3, memberDto.getUserName());
			pstmt.setString(4, memberDto.getUserId());
			if (pstmt.executeUpdate() == 0) {
				return false;
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			instance.close(conn, pstmt);
		}

		return true;
	}

	@Override
	public boolean deleteMember(String userId) {
		DBUtil instance = DBUtil.getInstance();
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = instance.getConnection();
			pstmt = conn.prepareStatement("delete from members where user_id = ?;");
			pstmt.setString(1, userId);
			if (pstmt.executeUpdate() == 0) {
				return false;
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			instance.close(conn, pstmt);
		}
		return true;
	}

	public MemberDto findMember(String userId) {
		DBUtil instance = DBUtil.getInstance();
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = DBUtil.getInstance().getConnection();
			pstmt = conn.prepareStatement("select * from members where user_id = ?;");
			pstmt.setString(1, userId);

			ResultSet rs = pstmt.executeQuery();

			MemberDto memberDto = new MemberDto();

			if (rs.next()) {
				memberDto.setUserId(rs.getString("user_id"));
				memberDto.setUserPass(rs.getString("user_password"));
				memberDto.setUserEmail(rs.getString("email_id"));
				memberDto.setUserName(rs.getString("user_name"));
				memberDto.setJoinDate(rs.getString("join_date"));
			} else
				return null;

			return memberDto;

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			instance.close(conn, pstmt);
		}
		return null;
	}

	@Override
	public MemberDto findMemberByIdEmail(String id, String email) {
		DBUtil instance = DBUtil.getInstance();
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = DBUtil.getInstance().getConnection();
			pstmt = conn.prepareStatement("select * from members where user_id = ? and email_id = ?;");
			pstmt.setString(1, id);
			pstmt.setString(2, email);

			ResultSet rs = pstmt.executeQuery();

			MemberDto memberDto = new MemberDto();

			if (rs.next()) {
				memberDto.setUserId(rs.getString(1));
				memberDto.setUserPass(rs.getString(2));
				memberDto.setUserEmail(rs.getString(3));
				memberDto.setUserName(rs.getString(4));
				memberDto.setJoinDate(rs.getString(5));
			} else
				return null;

			return memberDto;

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			instance.close(conn, pstmt);
		}
		return null;
	}

}
