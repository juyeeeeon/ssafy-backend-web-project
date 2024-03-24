package com.ssafy.member.model;

public class MemberDto {

	private String userId;
	private String userPass;
	private String userEmail;
	private String userName;
	private String joinDate;

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getUserPass() {
		return userPass;
	}

	public void setUserPass(String userPass) {
		this.userPass = userPass;
	}

	public String getJoinDate() {
		return joinDate;
	}

	public void setJoinDate(String joinDate) {
		this.joinDate = joinDate;
	}

	public String getUserEmail() {
		return userEmail;
	}

	public void setUserEmail(String userEmail) {
		this.userEmail = userEmail;
	}

	@Override
	public String toString() {
		return "MemberDto [userId=" + userId + ", userPass=" + userPass + ", userEmail=" + userEmail + ", userName="
				+ userName + ", joinDate=" + joinDate + "]";
	}

	

}
