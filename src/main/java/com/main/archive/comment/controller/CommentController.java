package com.main.archive.comment.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.main.archive.comment.dto.CommentDTO;
import com.main.archive.comment.service.CommentService;
import com.main.archive.common.util.ClientUtils;
import com.main.archive.user.dto.UserDTO;

@Controller
@RequestMapping(value="/comment/*")
public class CommentController {
	
	@Autowired
	private CommentService commentService;
	//-----------------------------------------------------------------------------------------------------------
	// 댓글 불러오기
	//-----------------------------------------------------------------------------------------------------------		
	@RequestMapping(value="/commentLoad", method=RequestMethod.GET)
	public String commentLoad(CommentDTO commentDTO, Model model, HttpSession session) {
		// 유저 정보 담기
		UserDTO user = (UserDTO)session.getAttribute("user");
		
		
		List<CommentDTO> commentList = commentService.commentLoad(commentDTO);
		
		System.out.println("댓글 불러오기 결과물: " + commentList);
		int listSize = commentList.size();
		model.addAttribute("commentList", commentList);
		model.addAttribute("user", user);
		model.addAttribute("liseSize", listSize);
		return "/common/ajaxComment";
	}
	
	//-----------------------------------------------------------------------------------------------------------
	// 댓글 등록하기
	//-----------------------------------------------------------------------------------------------------------		
	@ResponseBody
	@RequestMapping(value="/commentRegister", method=RequestMethod.POST)
	public int commentRegister(CommentDTO commentDTO, HttpServletRequest request, HttpSession session ) {
		UserDTO user = (UserDTO)session.getAttribute("user");
		String ip = ClientUtils.getRemoteIP(request);
		commentDTO.setM_ip(ip);
		if(user != null) {
			commentDTO.setM_pass(user.getM_pass());			
		}
		return commentService.commentRegister(commentDTO);
	}
}
