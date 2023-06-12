package com.main.archive.user.controller;


import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.main.archive.common.util.ClientUtils;
import com.main.archive.common.util.JwtService;
import com.main.archive.user.dto.UserDTO;
import com.main.archive.user.service.UserService;

@Controller
@RequestMapping(value="/accounts/*")
public class UserController {
	
	@Autowired
	UserService userService;
	
	@Autowired
	JwtService jwtService;
	
	
	
	
	//-----------------------------------------------------------------------------------------------------------
	// 로그인 폼
	//-----------------------------------------------------------------------------------------------------------	
	@RequestMapping(value="/loginForm")
	public String loginForm(HttpSession session) {
		
		if(session.getAttribute("user") != null) {
			return "home";
		}
		
		return "/user/login";
	}
	
	//-----------------------------------------------------------------------------------------------------------
	// 로그인 처리
	//-----------------------------------------------------------------------------------------------------------
	@RequestMapping(value="/login", method = RequestMethod.POST)	// 로그인으로 토큰을 생성하는 경로
	public String login(UserDTO userInfo, Model model, HttpServletResponse response, HttpSession session) throws IOException {		
		
		UserDTO user = userService.getUserInfo(userInfo);
		
		if(user == null) {
			response.setContentType("text/html; charset=UTF-8");
            PrintWriter out = response.getWriter();
            out.println("<script>alert('아이디 또는 비밀번호가 잘못되었습니다.'); location.replace('/accounts/loginForm');</script>");
            out.flush();

			out.close();
			return "user/login";
		} else {		
			// 로그인 성공 시 정보담기
			
			// 토큰 발행
			String token = jwtService.createJwt(user.getM_idx());
			response.setHeader("X-ACCESS-TOKEN", token);
			
			//세션에 개인정보를 담는 방식
			session.setAttribute("user", user);
			// model.addAttribute("UserNAME", user.getM_name());
			
			return "redirect:/";
		}
		
	}
	
	//-----------------------------------------------------------------------------------------------------------
	// 회원가입 폼
	//-----------------------------------------------------------------------------------------------------------
	@RequestMapping(value="/signUpForm")
	public String signUpForm(HttpSession session) {
		
		if(session.getAttribute("user") != null) {
			return "home";
		}
		return "/user/signup";
	}

	//-----------------------------------------------------------------------------------------------------------
	// 아이디 중복검사
	//-----------------------------------------------------------------------------------------------------------
	@ResponseBody
	@RequestMapping(value="/checkID", method= RequestMethod.POST)
	public int idCheck(UserDTO userDTO) throws Exception {
		
		// System.out.println("userDTO m_id: " + userDTO.getM_id());
		int result = userService.idCheck(userDTO);
		// System.out.println("result: " + result);
		return result;
	}
	
	//-----------------------------------------------------------------------------------------------------------
	// 회원가입 진행
	//-----------------------------------------------------------------------------------------------------------
	@ResponseBody
	@RequestMapping(value="/signUp", method= RequestMethod.POST)
	public int signUp(UserDTO userDTO, HttpServletRequest request, HttpSession session) throws Exception {
		
		String ip = ClientUtils.getRemoteIP(request);
		userDTO.setJ_ip(ip);
		
		// System.out.println("회원가입 dto: " + userDTO);
		int result = userService.signUp(userDTO);
		// System.out.println("회원가입 result: " + result);
		if(result == 1) {
			UserDTO user = userService.getUserInfo(userDTO);
			session.setAttribute("user", user);
		}
		
		return result;
		
	}

	//-----------------------------------------------------------------------------------------------------------
	// 로그아웃 처리
	//-----------------------------------------------------------------------------------------------------------
	@RequestMapping(value="/logout", method=RequestMethod.POST) 
	public String logout(HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		
		// 세션삭제
		session.removeAttribute("user");
		
		return "redirect:/";
	}
	
	
}
