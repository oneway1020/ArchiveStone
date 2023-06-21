package com.main.archive.comment.dto;

import java.sql.Timestamp;

import org.springframework.stereotype.Component;

import lombok.Data;

@Component("commentDTO")
@Data
public class CommentDTO {
	private	int		co_idx;
	private String	bc_code;
	private int		b_num;
	private String	m_id;
	private String	m_name;
	private String	m_pass;
	private String	co_content;
	private Timestamp	co_writedate;
	private int		co_depth;
	private	int		co_group;
	private String	m_ip;
}
