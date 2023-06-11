package com.main.archive.user.controller;


import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

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
	
	@RequestMapping(value="/login", method = RequestMethod.POST)	// 로그인으로 토큰을 생성하는 경로
	public String login(UserDTO userInfo, Model model, HttpServletResponse response, HttpSession session) throws IOException {		
		
		// 로그인 처리
		UserDTO user = userService.getUserInfo(userInfo);
		
		if(user == null) {
			model.addAttribute("message", "아이디 또는 비밀번호가 일치하지 않습니다.");
			return "user/loginForm";
		} else {		
			// 로그인 성공 시 정보담기
			
			// 토큰 발행
			String token = jwtService.createJwt(user.getM_idx());
			response.setHeader("X-ACCESS-TOKEN", token);
			
			//세션에 담는 방식
			session.setAttribute("user", user);
			// model.addAttribute("UserNAME", user.getM_name());
			
			return "redirect:/";
		}
		
	}
	
	@RequestMapping(value="/logout", method=RequestMethod.POST) 
	public String logout(HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		
		session.removeAttribute("user");
		
		return "redirect:/";
	}
	
	
}
