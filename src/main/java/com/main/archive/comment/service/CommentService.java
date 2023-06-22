package com.main.archive.comment.service;

import java.util.List;

import com.main.archive.comment.dto.CommentDTO;

public interface CommentService {

	// 댓글 로딩
	public List<CommentDTO> commentLoad(CommentDTO commentDTO);

	// 댓글 등록
	public int commentRegister(CommentDTO commentDTO);

	// 댓글 삭제
	public int commentDelete(CommentDTO commentDTO);
	
	// 댓글 비밀번호 확인
	public int commentPassCheck(CommentDTO commentDTO);

}
