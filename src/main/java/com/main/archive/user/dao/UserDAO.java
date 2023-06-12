package com.main.archive.user.dao;

import com.main.archive.user.dto.UserDTO;

public interface UserDAO {
	
	// 로그인
	UserDTO getLoginById(UserDTO userDTO);

	// 중복확인
	int idCheck(UserDTO userDTO) throws Exception;

	// 회원가입
	int signUp(UserDTO userDTO) throws Exception;
}
