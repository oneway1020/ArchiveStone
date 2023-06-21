package com.main.archive.admin;


import org.springframework.stereotype.Component;


import lombok.Data;

@Component("adminDTO")
@Data
public class AdminDTO {
	
	// 유저정보 (member)
	private int		m_idx;
	private String	m_id;
	private String	m_name;
	private String	m_pass;
	private int		m_level;
	private String	j_ip;
	
	// 게시판 제작 (bd_board_config)
	private String bc_code;
	private String bc_name;
	
}
