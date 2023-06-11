package com.main.archive.user.dao;

import com.main.archive.user.dto.UserDTO;

public interface UserDAO {
	
	
	UserDTO getLoginById(UserDTO userDTO);
}
