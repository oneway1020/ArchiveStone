package com.main.archive.board.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.main.archive.board.dto.BoardDTO;
import com.main.archive.board.service.BoardService;



// 게시글 관련 컨트롤러
@Controller
@RequestMapping(value = "/board/*")
public class BoardController {
	
	@Autowired
	private	BoardService boardService;
	
	//-----------------------------------------------------------------------------------------------------------
	// 게시글 목록 가져오기
	//-----------------------------------------------------------------------------------------------------------
	@RequestMapping(value = "/lists", method = RequestMethod.GET)
	// 메서드 타입이 void면 RequestMapping 주소값의 view로 이동한다.
	public void boardList(Model model) throws Exception {
		
		
		List<BoardDTO> boardList = boardService.boardList();

		
		model.addAttribute("boardList", boardList);
		
	}
}
