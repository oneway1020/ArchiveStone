package com.main.archive.user.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

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

}
