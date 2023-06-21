package com.main.archive.board.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.util.List;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.google.gson.JsonObject;
import com.main.archive.board.dto.BoardDTO;
import com.main.archive.board.service.BoardService;
import com.main.archive.common.util.ClientUtils;
import com.main.archive.common.util.MediaUtils;
import com.main.archive.common.util.search.PageMaker;
import com.main.archive.common.util.search.SearchCriteria;
import com.main.archive.user.dto.UserDTO;

import io.jsonwebtoken.io.IOException;



// 게시판 관련 컨트롤러
@Controller
@RequestMapping(value = "/board/*")
public class BoardController {
	
	@Autowired
	private	BoardService boardService;
	
	//-----------------------------------------------------------------------------------------------------------
	// 게시판 목록 가져오기
	//-----------------------------------------------------------------------------------------------------------
	@RequestMapping(value = "/lists", method = RequestMethod.GET)
	// 메서드 타입이 void면 RequestMapping 주소값의 view로 이동한다.
	public String boardList(Model model) throws Exception {
		
		
		List<BoardDTO> boardConfigList = boardService.boardList();

		// System.out.println("게시판 목록: " + boardConfigList);
		model.addAttribute("boardConfigList", boardConfigList);
		model.addAttribute("totalCount", boardConfigList.size());
		
		return "/board/lists";
		
	}
	
	//-----------------------------------------------------------------------------------------------------------
	// 게시판 검색 목록 가져오기
	//-----------------------------------------------------------------------------------------------------------
	@RequestMapping(value = "/search", method= RequestMethod.GET)
	public String searchBoard(String searchGall, Model model) throws Exception {
		
		List<BoardDTO> boardConfigList = boardService.searchGall(searchGall);
		
		// System.out.println("게시판 수: " + boardConfigList.size());
		
		model.addAttribute("boardConfigList", boardConfigList);
		model.addAttribute("totalCount", boardConfigList.size());
		
		return "/board/lists";
	}
	
	//-----------------------------------------------------------------------------------------------------------
	// 해당 게시판 게시글 목록 가져오기 + 페이징, 검색기능 추가
	//-----------------------------------------------------------------------------------------------------------
	@RequestMapping(value = "/record", method= RequestMethod.GET)
	public String boardRecord(SearchCriteria cri, Model model) {
		
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		// 페이지메이커에 총 레코드 개수 넣어준다.
		pageMaker.setTotalCount(boardService.totalBoardRecordCount(cri));
		List<BoardDTO> recordList = boardService.boardRecordList(cri);
		
//		List<BoardDTO> recordList = boardService.boardRecordList(bc_code);
//		System.out.println("recordList: " + recordList);
		
		model.addAttribute("title", cri.getBc_code());
		model.addAttribute("recordList", recordList);
		model.addAttribute("pageMaker", pageMaker);
		// System.out.println(pageMaker);
		return "/board/record";
	}
	
	//-----------------------------------------------------------------------------------------------------------
	// 누른 게시글 정보 + 해당 게시판 게시글 목록 가져오기
	//-----------------------------------------------------------------------------------------------------------
	@RequestMapping(value = "/view", method = RequestMethod.GET)
	public String boardView(SearchCriteria cri, Model model, HttpSession session) throws Exception {
		
		UserDTO user = (UserDTO)session.getAttribute("user");
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		// 페이지메이커에 총 레코드 개수 넣어준다.
		pageMaker.setTotalCount(boardService.totalBoardRecordCount(cri));
		// 전체 게시글 정보
		List<BoardDTO> recordList = boardService.boardRecordList(cri);
		// 누른 게시글 정보
		BoardDTO recordOne = boardService.boardRecordDetail(cri);
		
		
		model.addAttribute("recordOne", recordOne);
		model.addAttribute("recordList", recordList);
		model.addAttribute("pageMaker", pageMaker);
		model.addAttribute("user", user);
		
		return "board/view";
	}
	
	//-----------------------------------------------------------------------------------------------------------
	// 글쓰기 화면 불러오기
	//-----------------------------------------------------------------------------------------------------------
	@RequestMapping(value = "/register")
	public String registerForm(String bc_code, Model model) {
		model.addAttribute("bc_code", bc_code);
		return "/board/boardRegister";
	}
	
	//-----------------------------------------------------------------------------------------------------------
	// 게시글 등록-작성-업로드
	//-----------------------------------------------------------------------------------------------------------	
	@ResponseBody
	@RequestMapping(value="/boardRegister", method=RequestMethod.POST)
	public int boardRegister(BoardDTO boardDTO, HttpServletRequest request, HttpSession session) throws Exception {
		
		String ip = ClientUtils.getRemoteIP(request);
		boardDTO.setM_ip(ip);
		// System.out.println("게시글 등록 boardDTO: " + boardDTO);
		int result = boardService.boardRegister(boardDTO);
		
		return result;
		
	}
	
	//-----------------------------------------------------------------------------------------------------------
	// 게시글 이미지 등록-작성-업로드
	//-----------------------------------------------------------------------------------------------------------	
	@ResponseBody
	@RequestMapping(value="/fileupload")
	public String fileUpload(HttpServletRequest request, HttpServletResponse response,
			MultipartHttpServletRequest multiFile) throws Exception {
		// JSON 객체생성
		JsonObject json = new JsonObject();
		// JSON 객체를 출력하기 위해 PrintWriter 생성
		PrintWriter printWriter = null;
		OutputStream out = null;
		
		// 파일을 가져오기 위해 MultipartHttpServletRequest의 getFile메서드 사용
		MultipartFile file = multiFile.getFile("upload");
		// 파일이 비어있지 않고(비어있다면 null 반환)
		if(file != null) {
			// 파일 사이즈가 0보다 크고, 파일이름이 공백이 아닐때
			if(file.getSize() > 0 && StringUtils.isNotBlank(file.getName())) {
				if(file.getContentType().toLowerCase().startsWith("image/")) {
					try {
						// 파일 이름 설정
						String fileName = file.getName();
						//바이트 타입 설정
						byte[] bytes;
						// 파일을 바이트 타입으로 변경
						bytes = file.getBytes();
						// 파일이 실제로 저장되는 경로
						// MedailUtils.calculatePath를 이용함으로써 날짜경로에 디렉토리를 만들어준다.
						String uploadPath = MediaUtils.calculatePath(request.getSession().getServletContext().getRealPath("/resources/ckimage/"));
//								request.getSession().getServletContext().getRealPath("/resources/ckimage/");
//						저장되는 파일에 경로 설정
//						File uploadFile = new File(uploadPath);
//						if(!uploadFile.exists() ) {
//							uploadFile.mkdirs();
//						}
						// 랜덤한 파일이름 생성
						fileName = UUID.randomUUID().toString();
						// 업로드 경로 + 파일이름을 줘서 데이터를 서버에 전송
						uploadPath = uploadPath + "/" + fileName;
//						System.out.println("업로드경로: " + uploadPath);
						out = new FileOutputStream(new File(uploadPath));
						out.write(bytes);
						
						// 클라이언트에 이벤트 추가
						printWriter = response.getWriter();
						response.setContentType("text/html");
						
						// "/resources"전의 String을 잘라내고 /resources를 포함하는 경로만 추출한다.
						String uploadPathResources = uploadPath.substring(uploadPath.lastIndexOf("\\resources"));
						
						// 파일이 연결되는 Url 주소 설정
						String fileUrl = request.getContextPath() + uploadPathResources;
//						System.out.println("fileUrl: " + fileUrl);
						// Json 데이터로 등록
						// {"uploaded": 1, "fileName": "test.jpg", "url": "/img/test/jpg"}
						// 이런 형태로 return 값 나가야한다.
						json.addProperty("uploaded", 1);
						json.addProperty("fileName", fileName);
						json.addProperty("url", fileUrl);
						
						printWriter.println(json);
						
					} catch(IOException e) {
						e.printStackTrace();
					} finally {
						if(out != null) {
							out.close();
						}
						if(printWriter != null) {
							printWriter.close();
						}
					}
				}
			}
		}
		return null;
	}
	
	
	//-----------------------------------------------------------------------------------------------------------
	// 게시글 수정 뷰
	//-----------------------------------------------------------------------------------------------------------	
	@RequestMapping(value="/modify", method=RequestMethod.GET)
	public String recordModify(SearchCriteria cri, Model model, HttpSession session) throws Exception {
		
		BoardDTO recordOne = boardService.boardRecordDetail(cri);
		UserDTO user = (UserDTO)session.getAttribute("user");
		//	System.out.println("user: " + user);
		//	유저정보가 없거나 유저세션 m_id와 게시글 m_id가 다르다면
		if(user == null || !user.getM_id().equals(recordOne.getM_id())) {
			return "/board/modifyForm";
		}

		model.addAttribute("recordOne", recordOne);
		return "/board/modify";			
	}
	
	//-----------------------------------------------------------------------------------------------------------
	// 게시글 수정 응답
	//-----------------------------------------------------------------------------------------------------------	
	@ResponseBody
	@RequestMapping(value="/recordUpdate", method=RequestMethod.POST)
	public int recordUpdate(BoardDTO boardDTO) {
		return boardService.boardRecordUpdate(boardDTO);
	}
	
	//-----------------------------------------------------------------------------------------------------------
	// 비로그인 게시글 수정 비밀번호 응답
	//-----------------------------------------------------------------------------------------------------------
	@ResponseBody
	@RequestMapping(value="/checkModifyPass", method=RequestMethod.POST)
	public BoardDTO checkModifyPass(BoardDTO boardDTO) throws Exception {
		BoardDTO record = boardService.checkModifyPass(boardDTO);
//		System.out.println("boardDTO 정보: " + boardDTO);
//		System.out.println("레코드 정보: " + record);
		
		return record;
	}
	
	//-----------------------------------------------------------------------------------------------------------
	// 비로그인 게시글 수정 뷰
	//-----------------------------------------------------------------------------------------------------------
	@RequestMapping(value="/nonMemberModify", method=RequestMethod.POST)
	public String nonMemberModify(SearchCriteria cri, Model model) throws Exception {
		
		BoardDTO recordOne = boardService.boardRecordDetail(cri);
		
		if(!cri.getM_pass().equals(recordOne.getM_pass())) {
			return "/board/modifyForm";
		}
		
		
		model.addAttribute("recordOne", recordOne);
		return "/board/nonMemberModify";
	}
	
	//-----------------------------------------------------------------------------------------------------------
	// 추천 비추 체크기능
	//-----------------------------------------------------------------------------------------------------------
	@ResponseBody
	@RequestMapping(value="/goodBadCheck", method=RequestMethod.POST)
	public BoardDTO goodBadCheck(BoardDTO boardDTO, HttpServletRequest request) throws Exception {
		
		String ip = ClientUtils.getRemoteIP(request);
		boardDTO.setM_ip(ip);
		BoardDTO result = boardService.boardGoodBad(boardDTO);
		
		System.out.println("추천눌렀을때 결과물: " + result);
		return result;
	}
	
	//-----------------------------------------------------------------------------------------------------------
	// 게시글 삭제 뷰
	//-----------------------------------------------------------------------------------------------------------	
	@RequestMapping(value="/delete", method=RequestMethod.GET)
	public String recordDelete(SearchCriteria cri, Model model, HttpSession session) throws Exception {
		
		BoardDTO recordOne = boardService.boardRecordDetail(cri);
		UserDTO user = (UserDTO)session.getAttribute("user");
		//	System.out.println("user: " + user);
		//	유저정보가 없거나 유저세션 m_id와 게시글 m_id가 다르다면
		if(user == null || !user.getM_id().equals(recordOne.getM_id())) {
			return "/board/deleteForm";
		}

		model.addAttribute("recordOne", recordOne);
		return "/board/deleteFormForLoginUser";			
	}	
	
	//-----------------------------------------------------------------------------------------------------------
	// 게시글 삭제 비밀번호 확인
	//-----------------------------------------------------------------------------------------------------------	
	@ResponseBody
	@RequestMapping(value="/checkDeletePass", method=RequestMethod.POST)
	public BoardDTO checkDeletePass(BoardDTO boardDTO) throws Exception {
		return boardService.checkDeletePass(boardDTO);
	}

	//-----------------------------------------------------------------------------------------------------------
	// 게시글 삭제 응답
	//-----------------------------------------------------------------------------------------------------------	
	@ResponseBody
	@RequestMapping(value="/deleteData", method=RequestMethod.POST)
	public int deleteData(BoardDTO boardDTO) {
		System.out.println("삭제 boardDTO b_num= " + boardDTO.getB_num() + "bc_code= " + boardDTO.getBc_code());
		return boardService.boardRecordDelete(boardDTO);
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
