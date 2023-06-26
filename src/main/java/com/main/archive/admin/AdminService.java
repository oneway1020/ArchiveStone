package com.main.archive.admin;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.main.archive.board.dto.BoardDTO;
import com.main.archive.common.util.search.SearchCriteria;
import com.main.archive.user.dto.UserDTO;

@Service
public class AdminService {
	
	@Autowired
	private AdminDAO adminDAO;

	
	//-----------------------------------------------------------------------------------------------------------
	// 회원 리스트
	//-----------------------------------------------------------------------------------------------------------	
	public List<UserDTO> userList(SearchCriteria cri) {
		return adminDAO.userList(cri);
	}

	//-----------------------------------------------------------------------------------------------------------
	// 회원 삭제
	//-----------------------------------------------------------------------------------------------------------	
	public int deleteUser(UserDTO userDTO) {
		return adminDAO.deleteUser(userDTO);
	}
	
	//-----------------------------------------------------------------------------------------------------------
	// 게시판 만들기
	//-----------------------------------------------------------------------------------------------------------	
	public int createBoard(BoardDTO boardDTO) {
		return adminDAO.createBoard(boardDTO);
	}


}
