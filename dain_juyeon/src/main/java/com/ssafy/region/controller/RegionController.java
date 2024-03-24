package com.ssafy.region.controller;

import java.io.IOException;
import java.util.List;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.ssafy.region.model.RegionDto;
import com.ssafy.region.model.service.RegionService;
import com.ssafy.region.model.service.RegionServiceImpl;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/region")
public class RegionController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	static RegionService service = RegionServiceImpl.getRegionService();

	@Override
	public void init(ServletConfig config) throws ServletException {
		super.init(config);
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String action = request.getParameter("action");

//		String path = "";
		if ("sido".equals(action)) {
//			path = getAllSido(request, response);
//			forward(request, response, path);
			getAllSido(request, response);
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		doGet(request, response);
	}

	private void forward(HttpServletRequest request, HttpServletResponse response, String path)
			throws ServletException, IOException {
		RequestDispatcher dispatcher = request.getRequestDispatcher(path);
		dispatcher.forward(request, response);
	}

	private void redirect(HttpServletRequest request, HttpServletResponse response, String path) throws IOException {
		response.sendRedirect(request.getContextPath() + path);
	}

	private List<RegionDto> getAllSido(HttpServletRequest request, HttpServletResponse response) {
		try {
			List<RegionDto> list =  service.getAllSido();
//			request.setAttribute("sido", list);
			
			ObjectMapper objectMapper = new ObjectMapper();
			String json = objectMapper.writeValueAsString(list);
			response.setContentType("application/json");
			response.setCharacterEncoding("UTF-8");
			response.getWriter().write(json);
			return null;
			
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("msg", "목록 로드 실패");
//			return "/error/error.jsp";
			return null;
		}
//		return "index.jsp";
	}
}
