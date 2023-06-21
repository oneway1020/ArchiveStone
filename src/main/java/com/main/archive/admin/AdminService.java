package com.main.archive.admin;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.main.archive.user.dto.UserDTO;

@Service
public class AdminService {
	
	@Autowired
	private AdminDAO adminDAO;

	
	//-----------------------------------------------------------------------------------------------------------
	// 회원 리스트
	//-----------------------------------------------------------------------------------------------------------	
	public List<UserDTO> userList() {
		return adminDAO.userList();
	}
}
