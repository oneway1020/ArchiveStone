package com.main.archive.comment.dto;

import java.sql.Timestamp;

import org.springframework.stereotype.Component;

import lombok.Data;

@Component("QnACommentDTO")
@Data
public class QnACommentDTO {
	private int			qo_idx;
	private int			q_num;
	private String		m_id;
	private String		m_name;
	private String		qo_content;
	private Timestamp	qo_writetime;
	
	private int			m_idx;
	private int			m_level;
	private int			adminCommentCount;
}
