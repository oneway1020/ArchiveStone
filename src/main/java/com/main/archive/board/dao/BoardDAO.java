package com.main.archive.board.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.apache.ibatis.session.SqlSession;
import com.main.archive.board.dto.BoardDTO;
import com.main.archive.common.util.search.SearchCriteria;

@Repository
public class BoardDAO {
	
	@Autowired
	private SqlSession sqlSession;
	
	private	static String namespace = "BoardDAO";

	//-----------------------------------------------------------------------------------------------------------
	// 게시판 목록 가져오기
	//-----------------------------------------------------------------------------------------------------------	
	public List<BoardDTO> boardList() {
		List<BoardDTO> boardList = sqlSession.selectList(namespace + ".listAll");
		return boardList;
	}

	//-----------------------------------------------------------------------------------------------------------
	// 게시판 검색 목록 가져오기
	//-----------------------------------------------------------------------------------------------------------		
	public List<BoardDTO> searchGall(String searchGall) {
		
		List<BoardDTO> boardConfigList = sqlSession.selectList(namespace + ".searchGall", searchGall);
		return boardConfigList;
	}
	
	//-----------------------------------------------------------------------------------------------------------
	// 게시판 게시글 목록 가져오기 (페이징 + 조건별 검색)
	//-----------------------------------------------------------------------------------------------------------	
	public List<BoardDTO> boardRecordList(SearchCriteria cri) {
		List<BoardDTO> boardRecordList = sqlSession.selectList(namespace + ".recordList", cri);
		return boardRecordList;
	}

	//-----------------------------------------------------------------------------------------------------------
	// 게시글 등록
	//-----------------------------------------------------------------------------------------------------------	
	public int boardRegister(BoardDTO boardDTO) {
		int result = sqlSession.insert(namespace + ".boardRegister", boardDTO);
		return result;
	}
	
	//-----------------------------------------------------------------------------------------------------------
	// 게시판 게시글 수
	//-----------------------------------------------------------------------------------------------------------
	public int totalBoardRecordCount(SearchCriteria cri) {

		return sqlSession.selectOne(namespace + ".totalBoardRecordCount", cri);
	}

	//-----------------------------------------------------------------------------------------------------------
	// 게시글 조회수 증가
	//-----------------------------------------------------------------------------------------------------------	
	public void updateReadCount(SearchCriteria cri) {
		sqlSession.update(namespace + ".updateReadCount", cri);
		
	}

	//-----------------------------------------------------------------------------------------------------------
	// 게시판 게시글 정보
	//-----------------------------------------------------------------------------------------------------------	
	public BoardDTO boardRecordDetail(SearchCriteria cri) {
		return sqlSession.selectOne(namespace + ".recordDetail", cri);
	}
	
	
	//-----------------------------------------------------------------------------------------------------------
	// 게시글 수정
	//-----------------------------------------------------------------------------------------------------------	
	public int boardRecordUpdate(BoardDTO boardDTO) {
		return sqlSession.update(namespace + ".recordUpdate", boardDTO);
	}

	//-----------------------------------------------------------------------------------------------------------
	// 추천 비추 레코드
	//-----------------------------------------------------------------------------------------------------------
	public void createGbRecord(BoardDTO boardDTO) {
		sqlSession.insert(namespace + ".createGbRecord", boardDTO);
	}

	
	//-----------------------------------------------------------------------------------------------------------
	// 비로그인 게시글 수정 응답
	//-----------------------------------------------------------------------------------------------------------		
	public BoardDTO checkModifyPass(BoardDTO boardDTO) throws Exception {
		return sqlSession.selectOne(namespace + ".checkModifyPass", boardDTO);
	}
	
	//-----------------------------------------------------------------------------------------------------------
	// 추천 insert
	//-----------------------------------------------------------------------------------------------------------
	public void insertGood(BoardDTO boardDTO) {
		sqlSession.insert(namespace + ".insertGood", boardDTO);
	}
	public void updateGoodCount(BoardDTO boardDTO) {
		sqlSession.update(namespace + ".updateGoodCount", boardDTO);
	}
	
	//-----------------------------------------------------------------------------------------------------------
	// 비추 insert
	//-----------------------------------------------------------------------------------------------------------	
	public void insertBad(BoardDTO boardDTO) {
		sqlSession.insert(namespace + ".insertBad", boardDTO);
	}
	public void updateBadCount(BoardDTO boardDTO) {
		sqlSession.update(namespace + ".updateBadCount", boardDTO);
	}	

	//-----------------------------------------------------------------------------------------------------------
	// ip확인
	//-----------------------------------------------------------------------------------------------------------	
	public List<BoardDTO> ipCheck(BoardDTO boardDTO) {
		return sqlSession.selectList(namespace + ".ipCheck", boardDTO);
	}

	
	//-----------------------------------------------------------------------------------------------------------
	// 비로그인 유저 게시글 삭제 비번확인
	//-----------------------------------------------------------------------------------------------------------	
	public BoardDTO checkDeletePass(BoardDTO boardDTO) {
		return sqlSession.selectOne(namespace + ".checkDeletePass", boardDTO);
	}


	//-----------------------------------------------------------------------------------------------------------
	// 게시글 삭제 응답
	//-----------------------------------------------------------------------------------------------------------	
	public int boardRecordDelete(BoardDTO boardDTO) {
		return sqlSession.delete(namespace + ".recordDelete", boardDTO);
	}
	//-----------------------------------------------------------------------------------------------------------
	// 추천 비추 유저정보 삭제
	//-----------------------------------------------------------------------------------------------------------	
	public void boardGoodBadInfoDelete() {
		sqlSession.delete(namespace + ".boardGoodBadInfoDelete");
	}
}
