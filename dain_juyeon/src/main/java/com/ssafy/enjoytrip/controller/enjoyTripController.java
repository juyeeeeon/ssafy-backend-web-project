package com.ssafy.enjoytrip.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.ssafy.enjoytrip.model.AttractionInfoDto;
import com.ssafy.enjoytrip.model.service.AttractionService;
import com.ssafy.enjoytrip.model.service.AttractionServiceImpl;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;


@WebServlet("/enjoyTrip")
public class enjoyTripController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	static AttractionService service = AttractionServiceImpl.getInstance();

	@Override
	public void init(ServletConfig config) throws ServletException {
		super.init(config);

	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String action = request.getParameter("action");
		System.out.println(action);
		
		
		String path = "";
		if ("map".equals(action)) {
			path = map(request, response);
			forward(request, response, path);
		}  else{
//			search(request, response);
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
		BufferedReader reader = request.getReader();
        StringBuilder requestBody = new StringBuilder();
        String line;
        while ((line = reader.readLine()) != null) {
            requestBody.append(line);
        }
        // 요청 본문 내용 출력 (테스트용)
        System.out.println("요청 본문: " + requestBody.toString());
        search(request, response, requestBody.toString());
	}

	private void forward(HttpServletRequest request, HttpServletResponse response, String path)
			throws ServletException, IOException {
		RequestDispatcher dispatcher = request.getRequestDispatcher(path);
		dispatcher.forward(request, response);
	}

	private void redirect(HttpServletRequest request, HttpServletResponse response, String path) throws IOException {
		response.sendRedirect(request.getContextPath() + path);
	}

	private String indexSearch(HttpServletRequest request, HttpServletResponse response) {
		try {
			AttractionInfoDto info = new AttractionInfoDto();
			info.setAddr1(request.getParameter(""));
			service.attractionList(info);
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("msg", "목록 로드 실패");
			return "/error/error.jsp";
		}
		return "/map/map.jsp";
	}
	
	private String search(HttpServletRequest request, HttpServletResponse response, String str) {
		try {
			List<AttractionInfoDto> list = new ArrayList<>();

	        JSONParser jsonParser = new JSONParser();
	        Object obj = jsonParser.parse(str);

	        AttractionInfoDto att = new AttractionInfoDto();
	        if (obj instanceof JSONObject) {
	            JSONObject jsonObject = (JSONObject) obj;
	            
	            att.setSidoCode(Integer.parseInt((String) jsonObject.get("areaCode")));
	            att.setContentTypeId(Integer.parseInt((String) jsonObject.get("contentTypeId")));
	            att.setTitle((String) jsonObject.get("keyword"));
	        }

	        list = service.attractionList(att);
	        
			ObjectMapper objectMapper = new ObjectMapper();
			String json = objectMapper.writeValueAsString(list);
			response.setContentType("application/json");
			response.setCharacterEncoding("UTF-8");
			response.getWriter().write(json);
			return null;
			
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("msg", "목록 로드 실패");
			return null;
		}
	}
	private String map(HttpServletRequest request, HttpServletResponse response) {

		return "/map/map.jsp";
	}
}
