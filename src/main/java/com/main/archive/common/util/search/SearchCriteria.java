package com.main.archive.common.util.search;

//-----------------------------------------------------------------------------------------------------------
//public class SearchCriteria
//검색의 기준을 마련한다.
//-----------------------------------------------------------------------------------------------------------
public class SearchCriteria extends Criteria {
	
	// Criteria에서 가져오는 변수들
	// private int page;
	// private int perPageNum;
	
	private	String	searchType;	// 검색 타입
	private	String	keyword;	// 검색 키워드
	
	// 받아와야함
	private String	bc_code;	// 게시판 종류
	private int		b_num;		// 게시글 번호
	private int		q_num;		// 게시글 번호 (QnA)

	private String	m_pass;		// 게시글 비밀번호
	private String	recommend;	// 추천게시글인지 아닌지 표시
	private String	m_id;		// 아이디가 누구인지
	private int		m_level;	// 해당 아이디 등급이 무엇인지
	private int		m_idx;		// 유저 개별 정보
	
	
	
	public int getQ_num() {
		return q_num;
	}

	public void setQ_num(int q_num) {
		this.q_num = q_num;
	}

	public int getM_idx() {
		return m_idx;
	}

	public void setM_idx(int m_idx) {
		this.m_idx = m_idx;
	}

	public int getM_level() {
		return m_level;
	}
	
	public void setM_level(int m_level) {
		this.m_level = m_level;
	}
	
	public String getM_id() {
		return m_id;
	}

	public void setM_id(String m_id) {
		this.m_id = m_id;
	}

	public String getRecommend() {
		return recommend;
	}
	
	public void setRecommend(String recommend) {
		this.recommend = recommend;
	}
	
	
	public String getM_pass() {
		return m_pass;
	}
	
	public void setM_pass(String m_pass) {
		this.m_pass = m_pass;
	}

	
	public String getBc_code() {
		return bc_code;
	}
	public void setBc_code(String bc_code) {
		this.bc_code = bc_code;
	}
	public int getB_num() {
		return b_num;
	}
	public void setB_num(int b_num) {
		this.b_num = b_num;
	}
	
	public String getSearchType() {
		return searchType;
	}
	public void setSearchType(String searchType) {
		this.searchType = searchType;
	}
	public String getKeyword() {
		return keyword;
	}
	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}
	
	@Override
	public String toString() {
		return "SearchCriteria [searchType=" + searchType + ", keyword=" + keyword + ", bc_code=" + bc_code + "]";
	}

} // End - public class SearchCriteria
