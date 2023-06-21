package com.main.archive.admin;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.main.archive.user.dto.UserDTO;


@Controller
@RequestMapping(value = "/admin/*")
public class AdminController {
	
	@Autowired
	private AdminService adminService;
	
	//-----------------------------------------------------------------------------------------------------------
	// 관리자 홈
	//-----------------------------------------------------------------------------------------------------------
	@RequestMapping(value="/home", method = RequestMethod.GET)
	public String createBoard(Model model) throws Exception {

		
		return "/admin/adminHome";
		
	}

	
	//-----------------------------------------------------------------------------------------------------------
	// 회원 리스트
	//-----------------------------------------------------------------------------------------------------------
	@RequestMapping(value="/userInfo", method = RequestMethod.GET)
	public String userList(Model model) throws Exception {
		
		List<UserDTO> userList = adminService.userList();
		model.addAttribute("userList", userList);
		
		return "/admin/userInfo";
		
	}
	
	//-----------------------------------------------------------------------------------------------------------
	// 게시판 제작 페이지
	//-----------------------------------------------------------------------------------------------------------
	@RequestMapping(value="/createBoard")
	public String createBoard() {
		
		return "/admin/createBoard";
	}
	
	//-----------------------------------------------------------------------------------------------------------
	// 게시판 제작 응답
	//-----------------------------------------------------------------------------------------------------------
	
}
