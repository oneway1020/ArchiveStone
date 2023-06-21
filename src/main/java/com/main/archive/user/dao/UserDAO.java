package com.main.archive.user.dao;

import com.main.archive.user.dto.UserDTO;

public interface UserDAO {
	
	// 로그인
	public UserDTO getLoginById(UserDTO userDTO);

	// 중복확인
	public int idCheck(UserDTO userDTO) throws Exception;

	// 회원가입
	public int signUp(UserDTO userDTO) throws Exception;
}
