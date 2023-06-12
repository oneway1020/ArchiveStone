package com.main.archive.board.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.main.archive.board.dto.BoardDTO;
import com.main.archive.board.service.BoardService;
import com.main.archive.common.util.search.Criteria;



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

		System.out.println("게시판 목록: " + boardConfigList);
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
	// 해당 게시판 게시글 목록 가져오기
	//-----------------------------------------------------------------------------------------------------------
	@RequestMapping(value = "/record", method= RequestMethod.GET)
	public String boardRecord(String bc_code, Criteria cri) {
		
		System.out.println("bc_code: " + bc_code);
		System.out.println("page: " + cri.getPage());
		return "/board/record";
	}
}
