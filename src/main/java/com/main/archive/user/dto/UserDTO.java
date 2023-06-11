package com.main.archive.user.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor	// 기본 생성자
@AllArgsConstructor	// 모든 요소 요구하는 생성자
public class UserDTO {
	
	private int		m_idx;
	private String	m_id;
	private String	m_name;
	private String	m_pass;
	private int		m_level;
	private String	j_ip;
	
}
