package com.main.archive.board.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.apache.ibatis.session.SqlSession;
import com.main.archive.board.dto.BoardDTO;

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

}
