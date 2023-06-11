package com.main.archive.user.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.main.archive.user.dao.UserDAO;
import com.main.archive.user.dto.UserDTO;


@Service
public class UserServiceImpl implements UserService {

	@Autowired
	private UserDAO userDAO;
	
	// 로그인 처리
	@Override
	public UserDTO getUserInfo(UserDTO userDTO) {
		
		UserDTO result = userDAO.getLoginById(userDTO);
		if(result != null) { // 아이디가 존재하고
			if(result.getM_pass().equals(userDTO.getM_pass())) { // 비밀번호가 일치하면
				return result;
			}
		}
		
		return null;
	}

}
