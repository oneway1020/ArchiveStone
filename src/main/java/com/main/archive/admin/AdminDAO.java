package com.main.archive.admin;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.main.archive.user.dto.UserDTO;

@Repository
public class AdminDAO {
	@Autowired
	private SqlSession sqlSession;
	
	private	static String namespace = "AdminDAO";

	//-----------------------------------------------------------------------------------------------------------
	// 회원 리스트
	//-----------------------------------------------------------------------------------------------------------
	public List<UserDTO> userList() {
		return sqlSession.selectList(namespace + ".userListAll");
	}
}
