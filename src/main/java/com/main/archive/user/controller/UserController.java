package com.main.archive.user.controller;


import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.main.archive.board.dto.BoardDTO;
import com.main.archive.comment.dto.CommentDTO;
import com.main.archive.common.util.ClientUtils;
import com.main.archive.common.util.JwtService;
import com.main.archive.common.util.search.PageMaker;
import com.main.archive.common.util.search.SearchCriteria;
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
	//-----------------------------------------------------------------------------------------------------------
	// 회원탈퇴 처리
	//-----------------------------------------------------------------------------------------------------------
	@ResponseBody
	@RequestMapping(value="/myInfo/removeID", method=RequestMethod.GET)
	public int removeID(HttpServletRequest request, HttpSession session) {
		UserDTO userDTO = (UserDTO)session.getAttribute("user");
//		System.out.println("userDTO: " + userDTO);
		int result = userService.removeID(userDTO);
//		System.out.println("회원탈퇴 result: " + result);
		if(result != 0) {
			session.removeAttribute("user");
			return result;
		} else {
			return result;			
		}
	}
	
	
	//-----------------------------------------------------------------------------------------------------------
	// 내정보
	//-----------------------------------------------------------------------------------------------------------	
	@RequestMapping(value={"/myInfo/{m_id}", "/myInfo/"}, method=RequestMethod.GET)
	public String myInfo(@PathVariable(required = false) String m_id, Model model, HttpSession session) {
		UserDTO userDTO = (UserDTO)session.getAttribute("user");
//		System.out.println(userDTO.getM_id());
		if(m_id == null || !m_id.equals(userDTO.getM_id())) {
			return "/user/unKnownPage";
		}

		if(userDTO.getM_id().equals("admin")) {
			return "/admin/adminInfo";
		}
		// 로그인 정보 (member 테이블)
		model.addAttribute("user", userDTO);
		
		// 게시글 정보 (bd_board 테이블)
		List<BoardDTO> boardDTO = userService.tableInfo(userDTO);
		// 가져오는 게시글 레코드가 5개 초과로 존재하면
		if(boardDTO.size() > 5) {
			boardDTO = boardDTO.subList(0, 5);
		}
//		System.out.println("게시글 정보: " + boardDTO);
		// 댓글 정보	(bd_comment 테이블)
		List<CommentDTO> commentDTO = userService.commentInfo(userDTO);
		// 가져오는 댓글 레코드가 5개 초과로 존재하면
		if(commentDTO.size() > 5) {
			commentDTO = commentDTO.subList(0, 5);
		}
//		System.out.println("댓글 정보: " + commentDTO);
		// 가져와야할 것. 내 정보 (member테이블), 내가 쓴 글 (bd_board), 내가쓴 댓글
		model.addAttribute("recordList", boardDTO);
		model.addAttribute("commentList", commentDTO);
		return "/user/myInfo";
	}

	//-----------------------------------------------------------------------------------------------------------
	// 내정보 -> 게시글 전체정보 페이지
	//-----------------------------------------------------------------------------------------------------------	
	@RequestMapping(value="/myInfo/recordList")
	public String recordListForm(
			SearchCriteria cri, Model model, HttpSession session) {
		UserDTO userDTO = (UserDTO)session.getAttribute("user");
		cri.setM_id(userDTO.getM_id());
		PageMaker pageMaker	= new PageMaker();
		pageMaker.setCri(cri);
		// 유저 게시글 총 레코드 수
		pageMaker.setTotalCount(userService.totalUserRecordCount(cri));
		// 게시글 정보 (bd_board 테이블)
		List<BoardDTO> boardDTO = userService.tableInfo(cri);		
		model.addAttribute("user", userDTO);
		model.addAttribute("recordList", boardDTO);
		model.addAttribute("pageMaker", pageMaker);
		return "/user/recordListForm";
	}
	//-----------------------------------------------------------------------------------------------------------
	// 내정보 -> 댓글 전체정보 페이지
	//-----------------------------------------------------------------------------------------------------------
	@RequestMapping(value="/myInfo/commentList")
	public String commentListForm(SearchCriteria cri, Model model, HttpSession session) {
		UserDTO userDTO = (UserDTO)session.getAttribute("user");
		cri.setM_id(userDTO.getM_id());
		PageMaker pageMaker	= new PageMaker();
		pageMaker.setCri(cri);
		// 유저 댓글 총 레코드 수
		pageMaker.setTotalCount(userService.totalUserCommentCount(cri));
		// 댓글 정보	(bd_comment 테이블)
		List<CommentDTO> commentDTO = userService.commentInfo(cri);
		model.addAttribute("user", userDTO);
		model.addAttribute("commentList", commentDTO);
		model.addAttribute("pageMaker", pageMaker);
		return "/user/commentListForm";
	}
	
	
	//-----------------------------------------------------------------------------------------------------------
	// 내 정보 비밀번호 변경 뷰
	//-----------------------------------------------------------------------------------------------------------	
	@RequestMapping(value="/myInfo/changePass")
	public String changePassForm(Model model, HttpSession session) {
		UserDTO userDTO = (UserDTO)session.getAttribute("user");
		
		model.addAttribute("user", userDTO);
		return "/user/changePass";
		
	}
	//-----------------------------------------------------------------------------------------------------------
	// 회원탈퇴 확인 뷰
	//-----------------------------------------------------------------------------------------------------------	
	@RequestMapping(value="/myInfo/removeIDPassCheck")
	public String removeIDPassCheckForm(Model model, HttpSession session) {
		UserDTO userDTO = (UserDTO)session.getAttribute("user");
		
		model.addAttribute("user", userDTO);
		return "/user/removeCheck";
		
	}
	//-----------------------------------------------------------------------------------------------------------
	// 내 정보 비밀번호 확인 결과
	//-----------------------------------------------------------------------------------------------------------	
	@ResponseBody
	@RequestMapping(value="/myInfo/PassCheck", method=RequestMethod.POST)
	public int changePassCheck(UserDTO userDTO, HttpSession session) {
		UserDTO sessionInfo = (UserDTO)session.getAttribute("user");
		userDTO.setM_id(sessionInfo.getM_id());
//		System.out.println("입력정보 userDTO: " + userDTO);
		int result = userService.passCheck(userDTO);
		
		return result;
	}
	//-----------------------------------------------------------------------------------------------------------
	// 비밀번호 변경
	//-----------------------------------------------------------------------------------------------------------	
	@ResponseBody
	@RequestMapping(value="/myInfo/PassChange", method=RequestMethod.POST)
	public int passChangeOK(UserDTO userDTO, HttpSession session) {
		UserDTO sessionInfo = (UserDTO)session.getAttribute("user");
		userDTO.setM_id(sessionInfo.getM_id());
		int result = userService.passChange(userDTO);
		
		return result;
	}
}
