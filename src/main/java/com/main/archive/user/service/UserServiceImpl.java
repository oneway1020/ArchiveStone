package com.main.archive.user.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.main.archive.board.dto.BoardDTO;
import com.main.archive.comment.dto.CommentDTO;
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

	// 아이디 중복검사
	@Override
	public int idCheck(UserDTO userDTO) throws Exception {
		int result = userDAO.idCheck(userDTO);
		return result;
	}

	// 회원가입
	@Override
	public int signUp(UserDTO userDTO) throws Exception {
		
		int result = userDAO.signUp(userDTO);
		return result;
	}
	
	// 내정보와 일치하는 비밀번호 확인
	@Override
	public int passCheck(UserDTO userDTO) {
		return userDAO.passCheck(userDTO);
	}
	
	// 비밀번호 변경
	@Override
	public int passChange(UserDTO userDTO) {
		return userDAO.passChange(userDTO);
	}
	
	// 게시글 정보
	@Override
	public List<BoardDTO> tableInfo(UserDTO userDTO) {
		return userDAO.tableInfo(userDTO);
	}
	
	// 댓글 정보
	@Override
	public List<CommentDTO> commentInfo(UserDTO userDTO) {
		return userDAO.commentInfo(userDTO);
	}

}
