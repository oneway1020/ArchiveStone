package com.main.archive.admin;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.main.archive.board.dto.BoardDTO;
import com.main.archive.common.util.search.PageMaker;
import com.main.archive.common.util.search.SearchCriteria;
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
	public String userList(SearchCriteria cri, Model model) throws Exception {
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		List<UserDTO> userList = adminService.userList(cri);
		model.addAttribute("userList", userList);
		model.addAttribute("pageMaker", pageMaker);
		
		return "/admin/userInfo";
		
	}
	//-----------------------------------------------------------------------------------------------------------
	// 회원 삭제
	//-----------------------------------------------------------------------------------------------------------
	@ResponseBody
	@RequestMapping(value="/deleteUser", method=RequestMethod.POST)
	public int deleteUser(UserDTO userDTO) {
		return adminService.deleteUser(userDTO);
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
	@ResponseBody
	@RequestMapping(value="/createResponse", method=RequestMethod.POST)
	public int createBoardResponse(BoardDTO boardDTO) {
		
		return adminService.createBoard(boardDTO);
	}
}
