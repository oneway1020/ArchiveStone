package com.main.archive.board.dto;

import java.sql.Timestamp;

import org.springframework.stereotype.Component;

import lombok.Data;

@Component("QnABoardDTO")
@Data
public class QnABoardDTO {
	private int			q_idx;
	private int			q_num;
	private int			q_reply;
	private String		m_id;
	private String		m_name;
	private String		m_ip;
	private String		title;
	private String		content;
	private Timestamp	writetime;
	
	private int			m_idx;				// 유저정보 분별 저장용
}
