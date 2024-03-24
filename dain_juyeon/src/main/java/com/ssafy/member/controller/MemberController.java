package com.ssafy.member.controller;

import java.io.IOException;

import com.ssafy.member.model.MemberDto;
import com.ssafy.member.model.service.MemberService;
import com.ssafy.member.model.service.MemberServiceImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/member")
public class MemberController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static MemberService service = MemberServiceImpl.getMemberService();

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		process(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		request.setCharacterEncoding("UTF-8");
		process(request, response);
	}

	protected void process(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String action = request.getParameter("action");
		if ("regist".equals(action)) {
			doRegist(request, response);
		} else if ("login".equals(action)) {
			doLogin(request, response);
		} else if ("logout".equals(action)) {
			doLogout(request, response);
		} else if ("update".equals(action)) {
			doUpdate(request, response);
		} else if ("findPassword".equals(action)) {
			doFindPassword(request, response);
		} else if ("delete".equals(action)) {
			doDeleteMember(request, response);
		}
	}

	private void doDeleteMember(HttpServletRequest request, HttpServletResponse response) throws IOException {
		
		String userId = request.getParameter("user_id");
		service.deleteMember(userId);

		request.getSession().invalidate();

		response.setContentType("text/plain");
		response.setCharacterEncoding("UTF-8");
		response.getWriter().write("deleted");
	}

	protected void doRegist(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		MemberDto member = new MemberDto();
		member.setUserId(request.getParameter("id"));
		member.setUserPass(request.getParameter("password"));
		member.setUserEmail(request.getParameter("email"));
		member.setUserName(request.getParameter("name"));
		service.registerMember(member);

//		response.setContentType("application/json");
//		String jsonResponse = "{\"message\": \"회원가입이 성공적으로 완료되었습니다.\"}";
//		response.getWriter().write(jsonResponse);

		response.sendRedirect("/04_EnjoyTrip_Back/user/login.jsp");
	}

	protected void doLogin(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		MemberDto member = service.login(request.getParameter("login_id"), request.getParameter("login_password"));
		if (member == null) {
			request.getSession().invalidate();
			response.sendRedirect("/04_EnjoyTrip_Back/user/login.jsp");
		} else {
			request.getSession().setAttribute("user", member);
			String rememberId = request.getParameter("remember_id");
			if ("remember".equals(rememberId)) {
				Cookie cookie = new Cookie("user_id", request.getParameter("login_id"));
				cookie.setPath(request.getContextPath());
				cookie.setMaxAge(60 * 60 * 24 * 365 * 40);
				response.addCookie(cookie);
			} else {

				Cookie cookies[] = request.getCookies();
				if (cookies != null) {
					for (Cookie cookie : cookies) {
						if ("user_id".equals(cookie.getName())) {
							cookie.setMaxAge(0);
							response.addCookie(cookie);
							break;
						}
					}
				}
			}

			response.sendRedirect("/04_EnjoyTrip_Back/index.jsp");
		}
	}

	protected void doLogout(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.getSession().invalidate();
		response.sendRedirect("/04_EnjoyTrip_Back/index.jsp");
	}

	protected void doUpdate(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		MemberDto member = new MemberDto();
		member.setUserId(request.getParameter("info_id"));
		member.setUserPass(request.getParameter("info_password"));
		member.setUserEmail(request.getParameter("info_email"));
		member.setUserName(request.getParameter("info_name"));
		request.getSession().setAttribute("user", member);
		service.modifyMember(member);

		response.sendRedirect("/04_EnjoyTrip_Back/index.jsp");
	}

	private void doFindPassword(HttpServletRequest request, HttpServletResponse response) {
		String id = request.getParameter("find_id");
		String email = request.getParameter("find_email");

		MemberDto member = service.findMemberByIdEmail(id, email);
		if (member == null) {
			try {
				response.setContentType("text/plain");
				response.setCharacterEncoding("UTF-8");
				response.getWriter().write("no");
			} catch (IOException e) {
				e.printStackTrace();
			}
		} else {
			try {
				response.setContentType("text/plain");
				response.setCharacterEncoding("UTF-8");
				response.getWriter().write(member.getUserPass());
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}
}
