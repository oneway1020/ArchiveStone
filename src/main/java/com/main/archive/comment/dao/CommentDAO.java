package com.main.archive.comment.dao;

import java.util.List;

import com.main.archive.comment.dto.CommentDTO;

public interface CommentDAO {
	
	// 댓글 로딩
	public List<CommentDTO> commentLoad(CommentDTO commentDTO);
	
	// 댓글 등록
	public int commentRegister(CommentDTO commentDTO);

	// 댓글 삭제
	public int commentDelete(CommentDTO commentDTO);

	// 댓글 비밀번호 확인
	public int commentPassCheck(CommentDTO commentDTO);

	// 댓글 개수 업데이트
	public void updateCommentCount(CommentDTO commentDTO);

	// 댓글 개수 한 개 감소
	public void deleteCommentCount(CommentDTO commentDTO);

}
