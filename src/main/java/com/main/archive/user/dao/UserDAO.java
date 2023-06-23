package com.main.archive.user.dao;

import java.util.List;

import com.main.archive.board.dto.BoardDTO;
import com.main.archive.comment.dto.CommentDTO;
import com.main.archive.user.dto.UserDTO;

public interface UserDAO {
	
	// 로그인
	public UserDTO getLoginById(UserDTO userDTO);

	// 중복확인
	public int idCheck(UserDTO userDTO) throws Exception;

	// 회원가입
	public int signUp(UserDTO userDTO) throws Exception;
	
	
	// 내정보와 일치하는 비밀번호 확인
	public int passCheck(UserDTO userDTO);
	
	// 비밀번호 변경
	public int passChange(UserDTO userDTO);
	
	// 게시글 정보
	public List<BoardDTO> tableInfo(UserDTO userDTO);

	// 댓글 정보
	public List<CommentDTO> commentInfo(UserDTO userDTO);
}
