package com.ssafy.member.model.service;

import com.ssafy.member.model.MemberDto;

public interface MemberService {

	boolean registerMember(MemberDto memberDto);

	MemberDto login(String userId, String userPass);

	boolean modifyMember(MemberDto memberDto);

	boolean deleteMember(String userId);
	
	MemberDto findMember(String userId);

	MemberDto findMemberByIdEmail(String id, String email);

}
