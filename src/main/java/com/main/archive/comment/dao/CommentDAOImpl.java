package com.main.archive.comment.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.main.archive.comment.dto.CommentDTO;

@Repository
public class CommentDAOImpl implements CommentDAO {
	
	@Autowired
	private SqlSession sqlSession;
	
	private static String namespace = "CommentDAO";
	
	
	//-----------------------------------------------------------------------------------------------------------
	// 댓글 불러오기
	//-----------------------------------------------------------------------------------------------------------			
	@Override
	public List<CommentDTO> commentLoad(CommentDTO commentDTO) {
//		System.out.println("댓글 불러오기 DAO: " + commentDTO);
		List<CommentDTO> result = sqlSession.selectList(namespace + ".commentLoad", commentDTO);
//		System.out.println("댓글 불러오기 DAO List: " + result);
		return result;
	}


	//-----------------------------------------------------------------------------------------------------------
	// 댓글 등록하기
	//-----------------------------------------------------------------------------------------------------------			
	@Override
	public int commentRegister(CommentDTO commentDTO) {
		return sqlSession.insert(namespace + ".commentRegister", commentDTO);
	}

}
