package com.main.archive.comment.dto;

import java.sql.Timestamp;

import org.springframework.stereotype.Component;

import lombok.Data;

@Component("commentDTO")
@Data
public class CommentDTO {
	private	int			co_idx;
	private String		bc_code;
	private int			b_num;
	private String		m_id;
	private String		m_name;
	private String		m_pass;
	private String		co_content;
	private Timestamp	co_writedate;
	private int			co_depth;
	private	int			co_group;
	private String		m_ip;
	
	
	
	private String		path;	// 대댓글의 계층을 구별하기 위함
	private String		msg;	// 삭제된 댓글 바로 아래댓글 구분
	private int			commentCount;	// selectKey를 통해 업데이트 후 댓글수를 담을 변수
	
	
	// bd_board_config 정보
	private String		bc_name;		// 게시판 이름
	
	// bd_board 정보
	private String		title;			// 게시글 제목
	
	// member 정보
	private int			m_idx;			// 유저 개별 정보
}
