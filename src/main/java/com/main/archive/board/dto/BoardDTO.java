package com.main.archive.board.dto;


import java.sql.Timestamp;

import org.springframework.stereotype.Component;

import lombok.Data;

@Component("boardDTO")
@Data
public class BoardDTO {
	
	// bd_board 정보
	private int b_num;			// 게시글 번호
	private String b_reply;		// 댓글 정보
	private String m_id;		// 작성자 id
	private String m_name;		// 작성자 name
	private String m_pass;		// 작성자 pass
	private String m_ip;		// 작성자 ip
	private String title;		// 글 제목
	private String content;		// 글 내용
	private int b_cnt;			// 조회수
	private Timestamp writetime;// 작성시간
	
	
	// bd_board_config와 공유하는 정보
	private String bc_code;		// 게시판 이름 별 code
	
	// bd_board_config 정보
	private String bc_name;		// 게시판 이름
	
	

}
