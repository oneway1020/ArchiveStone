package com.main.archive.board.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.main.archive.board.dao.BoardDAO;
import com.main.archive.board.dto.BoardDTO;


@Service
public class BoardService {
	
	@Autowired
	BoardDAO boardDAO;

	
	//-----------------------------------------------------------------------------------------------------------
	// 게시판 목록 가져오기
	//-----------------------------------------------------------------------------------------------------------	
	public List<BoardDTO> boardList() throws Exception {
		
		return boardDAO.boardList();
		
	}

	//-----------------------------------------------------------------------------------------------------------
	// 게시판 검색 목록 가져오기
	//-----------------------------------------------------------------------------------------------------------	
	public List<BoardDTO> searchGall(String searchGall) {
		
		return boardDAO.searchGall(searchGall);
		
	}

}
