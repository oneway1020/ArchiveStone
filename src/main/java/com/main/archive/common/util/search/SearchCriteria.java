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
	private String	m_pass;		// 게시글 비밀번호
	private String	recommend;	// 추천게시글인지 아닌지 표시
	
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
