package com.ssafy.member.model.service;

import com.ssafy.member.model.MemberDto;
import com.ssafy.member.model.dao.MemberDao;
import com.ssafy.member.model.dao.MemberDaoImpl;

public class MemberServiceImpl implements MemberService {

	static private MemberService instance = new MemberServiceImpl();
	MemberDao dao = MemberDaoImpl.getMemberDao();

	private MemberServiceImpl() {
	}

	public static MemberService getMemberService() {
		return instance;
	}

	@Override
	public boolean registerMember(MemberDto memberDto) {
		MemberDto member = dao.findMember(memberDto.getUserId());
		if (member == null) {
			return dao.registerMember(memberDto);
		}
		return false;

	}

	@Override
	public MemberDto login(String userId, String userPass) {
		return dao.login(userId, userPass);
	}

	@Override
	public boolean modifyMember(MemberDto memberDto) {
		return dao.modifyMember(memberDto);
	}

	@Override
	public boolean deleteMember(String userId) {
		return dao.deleteMember(userId);
	}

	@Override
	public MemberDto findMember(String userId) {
		return dao.findMember(userId);
	}

	@Override
	public MemberDto findMemberByIdEmail(String id, String email) {
		return dao.findMemberByIdEmail(id, email);
	}



}
