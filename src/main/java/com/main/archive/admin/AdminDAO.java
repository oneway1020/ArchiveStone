package com.main.archive.admin;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.main.archive.board.dto.BoardDTO;
import com.main.archive.common.util.search.SearchCriteria;
import com.main.archive.user.dto.UserDTO;

@Repository
public class AdminDAO {
	@Autowired
	private SqlSession sqlSession;
	
	private	static String namespace = "AdminDAO";

	//-----------------------------------------------------------------------------------------------------------
	// 회원 리스트
	//-----------------------------------------------------------------------------------------------------------
	public List<UserDTO> userList(SearchCriteria cri) {
		return sqlSession.selectList(namespace + ".userListAll", cri);
	}

	//-----------------------------------------------------------------------------------------------------------
	// 회원 삭제
	//-----------------------------------------------------------------------------------------------------------
	public int deleteUser(UserDTO userDTO) {
		return sqlSession.delete(namespace + ".deleteUser", userDTO);
	}
	
	//-----------------------------------------------------------------------------------------------------------
	// 게시판 만들기
	//-----------------------------------------------------------------------------------------------------------		
	public int createBoard(BoardDTO boardDTO) {
		return sqlSession.insert(namespace + ".createBoard", boardDTO);
	}

}
