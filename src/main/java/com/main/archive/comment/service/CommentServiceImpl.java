package com.main.archive.comment.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.main.archive.comment.dao.CommentDAO;
import com.main.archive.comment.dto.CommentDTO;

@Service
public class CommentServiceImpl implements CommentService {
	
	@Autowired
	CommentDAO commentDAO;

	//-----------------------------------------------------------------------------------------------------------
	// 댓글 불러오기
	//-----------------------------------------------------------------------------------------------------------			
	@Override
	@Transactional(rollbackFor = {Exception.class})
	public List<CommentDTO> commentLoad(CommentDTO commentDTO) {
//		System.out.println("댓글 불러오기 Service: " + commentDTO);
		List<CommentDTO> result = commentDAO.commentLoad(commentDTO);

		for(CommentDTO comment : result) {
			
			String ip = comment.getM_ip();
			String [] splitIp = ip.split("\\.");
			
			String twoIP = splitIp[0] + "." + splitIp[1];
			
			comment.setM_ip(twoIP);
		}
		
		return result;
	}

	//-----------------------------------------------------------------------------------------------------------
	// 댓글 등록하기
	//-----------------------------------------------------------------------------------------------------------			
	@Override
	@Transactional(rollbackFor = {Exception.class})
	public int commentRegister(CommentDTO commentDTO) {
		int result = commentDAO.commentRegister(commentDTO); 
		// bd_board의 b_reply 개수 업데이트
		commentDAO.updateCommentCount(commentDTO);
		
		return result;
	}

	//-----------------------------------------------------------------------------------------------------------
	// 댓글 삭제하기
	//-----------------------------------------------------------------------------------------------------------			
	@Override
	@Transactional(rollbackFor = {Exception.class})
	public int commentDelete(CommentDTO commentDTO) {
		// bd_board의 b_reply수 한 개 감소
		commentDAO.deleteCommentCount(commentDTO);
		return commentDAO.commentDelete(commentDTO);
	}


	//-----------------------------------------------------------------------------------------------------------
	// 댓글 비밀번호 확인
	//-----------------------------------------------------------------------------------------------------------			
	@Override
	public int commentPassCheck(CommentDTO commentDTO) {
		return commentDAO.commentPassCheck(commentDTO);
	}
	
	

}
