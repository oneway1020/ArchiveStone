package com.main.archive.board.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.main.archive.board.dao.BoardDAO;
import com.main.archive.board.dto.BoardDTO;
import com.main.archive.common.util.search.SearchCriteria;


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
	
	//-----------------------------------------------------------------------------------------------------------
	// 게시판 게시글 목록 가져오기 (페이징 처리 + 조건별 검색)
	//-----------------------------------------------------------------------------------------------------------	
	public List<BoardDTO> boardRecordList(SearchCriteria cri) {
		List<BoardDTO> result = boardDAO.boardRecordList(cri);
		
		for(BoardDTO boardDTO : result) {
			
			String ip = boardDTO.getM_ip();
			String [] splitIp = ip.split("\\.");

			
			String twoIP = splitIp[0] + "." + splitIp[1];
			
			boardDTO.setM_ip(twoIP);
		}
		
		return result;
	}

	//-----------------------------------------------------------------------------------------------------------
	// 게시글 등록
	//-----------------------------------------------------------------------------------------------------------
	@Transactional(rollbackFor = {Exception.class})
	public int boardRegister(BoardDTO boardDTO) throws Exception {
		// 게시글 만들면서 추천 비추 레코드 만들기
		
		int result = boardDAO.boardRegister(boardDTO);
//		System.out.println("게시글 등록 service result: " + result);
		boardDAO.createGbRecord(boardDTO);
		
		return result;
	}
	
	//-----------------------------------------------------------------------------------------------------------
	// 게시판 게시글 수
	//-----------------------------------------------------------------------------------------------------------		
	public int totalBoardRecordCount(SearchCriteria cri) {
		return boardDAO.totalBoardRecordCount(cri);
	}

	//-----------------------------------------------------------------------------------------------------------
	// 누른 게시글 정보 + 해당 게시판 게시글 목록 가져오기
	//-----------------------------------------------------------------------------------------------------------
	@Transactional(rollbackFor = {Exception.class})
	public BoardDTO boardRecordDetail(SearchCriteria cri) throws Exception {
		// 조회수 증가
		boardDAO.updateReadCount(cri);
		BoardDTO result = boardDAO.boardRecordDetail(cri);
		
		String ip = result.getM_ip();
		String [] splitIp = ip.split("\\.");
		String twoIP = splitIp[0] + "." + splitIp[1];
		result.setM_ip(twoIP);
		
		return result;
	}
	
	//-----------------------------------------------------------------------------------------------------------
	// 게시글 수정
	//-----------------------------------------------------------------------------------------------------------	
	public int boardRecordUpdate(BoardDTO boardDTO) {
		return boardDAO.boardRecordUpdate(boardDTO);
		
	}

	
	//-----------------------------------------------------------------------------------------------------------
	// 비로그인 게시글 수정 응답
	//-----------------------------------------------------------------------------------------------------------		
	public BoardDTO checkModifyPass(BoardDTO boardDTO) throws Exception {
		return boardDAO.checkModifyPass(boardDTO);
	}

	//-----------------------------------------------------------------------------------------------------------
	// 추천 비추 체크기능
	//-----------------------------------------------------------------------------------------------------------
	@Transactional(rollbackFor = {Exception.class})
	public BoardDTO boardGoodBad(BoardDTO boardDTO) throws Exception {
		
		
		List<BoardDTO> list = boardDAO.ipCheck(boardDTO);
		// 입력받은 값이 good 이라면
		if(boardDTO.getGood() == 1) {
			
			boardDTO.setBad(0);
			// 입력받은 boardDTO의 ip와 DB속 ip가 일치한다면
			for(BoardDTO board : list) {
				if(board.getM_ip().equals(boardDTO.getM_ip())) {
					return null;
				}	
			}
			boardDAO.insertGood(boardDTO);
			boardDAO.updateGoodCount(boardDTO);
			return boardDTO;
		} else if(boardDTO.getBad() == 1) {	// 입력값이 bad 라면
			
			boardDTO.setGood(0);
			// 입력받은 boardDTO의 ip와 DB속 ip가 일치한다면
			for(BoardDTO board : list) {
				if(board.getM_ip().equals(boardDTO.getM_ip())) {
					return null;
				}
			}
			boardDAO.insertBad(boardDTO);
			boardDAO.updateBadCount(boardDTO);
			return boardDTO;
		} else {
			return null;
		}
	}

	
	//-----------------------------------------------------------------------------------------------------------
	// 비로그인 유저 게시글 삭제 비번확인
	//-----------------------------------------------------------------------------------------------------------
	public BoardDTO checkDeletePass(BoardDTO boardDTO) throws Exception {
		return boardDAO.checkDeletePass(boardDTO);
	}

	//-----------------------------------------------------------------------------------------------------------
	// 게시글 삭제 응답
	//-----------------------------------------------------------------------------------------------------------
	@Transactional(rollbackFor = {Exception.class})
	public int boardRecordDelete(BoardDTO boardDTO) {
		int result = boardDAO.boardRecordDelete(boardDTO);
		
		// 추천 비추 유저정보도 삭제
		boardDAO.boardGoodBadInfoDelete();
		
		return result;
	}

}











































