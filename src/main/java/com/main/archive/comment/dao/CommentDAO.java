package com.main.archive.comment.dao;

import java.util.List;

import com.main.archive.comment.dto.CommentDTO;

public interface CommentDAO {
	
	// 댓글 로딩
	public List<CommentDTO> commentLoad(CommentDTO commentDTO);
	
	// 댓글 등록
	public int commentRegister(CommentDTO commentDTO);

}