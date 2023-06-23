package com.main.archive.user.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.main.archive.board.dto.BoardDTO;
import com.main.archive.comment.dto.CommentDTO;
import com.main.archive.user.dto.UserDTO;

@Repository
public class UserDAOImpl implements UserDAO {
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	private static final String NAMESPACE = "UserDAO";

	
	// 로그인 처리
	@Override
	public UserDTO getLoginById(UserDTO userDTO) {
		return sqlSession.selectOne(NAMESPACE + ".getUser", userDTO);
	}

	// 아이디 중복검사
	@Override
	public int idCheck(UserDTO userDTO) throws Exception {
		
		
		return sqlSession.selectOne(NAMESPACE + ".idCheck", userDTO);
	}

	// 회원가입
	@Override
	public int signUp(UserDTO userDTO) throws Exception {
		
		int result = sqlSession.insert(NAMESPACE + ".signUp", userDTO);
		return result;
	}

	// 내정보와 일치하는 비밀번호 확인
	@Override
	public int passCheck(UserDTO userDTO) {
		
		return sqlSession.selectOne(NAMESPACE + ".passCheck", userDTO);
	}

	// 비밀번호 변경
	@Override
	public int passChange(UserDTO userDTO) {
		return sqlSession.update(NAMESPACE + ".passChange", userDTO);
	}

	// 게시글 정보
	@Override
	public List<BoardDTO> tableInfo(UserDTO userDTO) {
		return sqlSession.selectList(NAMESPACE + ".tableInfo", userDTO);
	}

	// 댓글 정보
	@Override
	public List<CommentDTO> commentInfo(UserDTO userDTO) {
		return sqlSession.selectList(NAMESPACE + ".commentInfo", userDTO);
	}

}
