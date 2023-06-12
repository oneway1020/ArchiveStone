package com.main.archive.common.util.search;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.util.UriComponents;
import org.springframework.web.util.UriComponentsBuilder;

//==========================================
//public class PageMaker
//==========================================
public class PageMaker {
	
	private Criteria cri;
	private int totalCount;	// 전체 데이터 개수
	private int startPage;	// 화면 하단에 보여지는 시작 페이지 번호
	private int endPage;	// 화면 하단에 보여지는 끝 페이지 번호
	private boolean prev;	// 이전
	private boolean next;	// 다음
	private int displayPageNum = 10;	// 화면 하단에 보여줄 페이지의 개수
	
	private static final Logger logger = LoggerFactory.getLogger(PageMaker.class);
	
	
	public String makeSearch(Integer page) {
     
 	//---------------------------------------------------------------
		// URI를 동적으로 생성해주는 클래스다. 
		// 파라미터가 조합된 URI를 손쉽게 만들어 주어서 코드상에서 직접 문자열을 조합할 때 생기는 실수를 방지할 수 있다.
		//---------------------------------------------------------------
		/*
		UriComponents uriComponents = UriComponentsBuilder.newInstance()
				.scheme("https").host("www.naver.com").path("/board")
				.queryParam("id", "a100"),
				.queryParam("name", "홍길동").build();
		*/
		
		UriComponents uriComponents = UriComponentsBuilder.newInstance()
         .queryParam("page", page)
         .queryParam("perPageNum", cri.getPerPageNum())
         .build();
		
			logger.info("makeSearch(Integer page) ==> " + uriComponents.toUriString());
			// INFO : com.edu.common.util.PageMaker - makeSearch(Integer page) ==> ?page=11&perPageNum=10
			
     return uriComponents.toUriString();
 }
	
	//==========================================================================================
	public Criteria getCri() {
		return cri;
	}

	public void setCri(Criteria cri) {
		this.cri = cri;
	}

	//==========================================================================================
	public int getTotalCount() {
		return totalCount;
	}

	public void setTotalCount(int totalCount) {
		this.totalCount = totalCount;
		// 총 데이터건수를 가지고 페이지를 계산한다.
		
		calculatePages();
	}

	//==========================================================================================
	// 총 데이터건수를 가지고 페이지를 계산
	// cri.getPage() : 현재 화면 하단에서 클릭한 페이지 번호
	// displayPageNum : 화면 하단에 보여줄 페이지 개수
	//
	// (int) (Math.ceil(cri.getPage() / (double) displayPageNum) * displayPageNum);
	// [1]를 선택했으면 1page / 1 => 0.1
	// Math.ceil(0.1page) => 1page
	// endPage = 1page x displayPageNum = 10이 화면 하단의 마지막 페이지가 된다.
	//==========================================================================================
	private void calculatePages() {
		// Math.ceil => 올림해서 정수로 만든다. ex) Math.ceil(13.1) == 14
		endPage = (int) (Math.ceil(cri.getPage() / (double) displayPageNum) * displayPageNum);
	    
		
		// 화면 하단에 10개씩 page를 보여준다면,
		// 시작 페이지는 (endPage - displayPageNum) + 1; => (보여줄 마지막 페이지 - 보여줄 페이지 개수) + 1
	    startPage = (endPage - displayPageNum) + 1;
	    
	    // 마지막 page 번호가 [10]보다 작으면 시작 page는 무조건 1page로 한다.
	    if(startPage <= 0) startPage = 1;	// 시작 페이지는 0이하가 나오면 1로 만든다.
	    
	    // tempEndPage : 실제 가지고 있는 페이지의 개수를 저장하는 변수
	    int tempEndPage = (int) (Math.ceil(totalCount / (double) cri.getPerPageNum()));
	    
	    
	    // 실제로 가지고 있는 마지막 page가 10단위를 채우지 못한다면,
	    // 마지막 page는 실제 가지고 있는 총 페이지 개수로 한다.
	    if (endPage > tempEndPage) {
	       endPage = tempEndPage;
	    }
	    
	    // 시작 페이지가 1이 아닌 경우에만 [prev] 버튼을 보여준다.
	    prev = startPage == 1 ? false : true;
	    
	    // 마지막 페이지 번호 x 10 < 총 데이터 건수이면,
	    // 화면 하단에 나타나는 페이지의 개수를 넘어가므로 [next]버튼을 보여준다.
	    next = endPage * cri.getPerPageNum() < totalCount ? true : false;
	    
	}
	
	//==========================================================================================
	public int getStartPage() {
		return startPage;
	}

	public void setStartPage(int startPage) {
		this.startPage = startPage;
	}

	//==========================================================================================
	public int getEndPage() {
		return endPage;
	}

	public void setEndPage(int endPage) {
		this.endPage = endPage;
	}

	//==========================================================================================
	public boolean isPrev() {
		return prev;
	}

	public void setPrev(boolean prev) {
		this.prev = prev;
	}

	//==========================================================================================
	public boolean isNext() {
		return next;
	}

	public void setNext(boolean next) {
		this.next = next;
	}

	//==========================================================================================
	public int getDisplayPageNum() {
		return displayPageNum;
	}

	//==========================================================================================
	public void setDisplayPageNum(int displayPageNum) {
		this.displayPageNum = displayPageNum;
	}



	
	//==========================================================================================
	@Override
	public String toString() {
		return "PageMaker [cri=" + cri + ", totalCount=" + totalCount + ", startPage=" + startPage + ", endPage="
				+ endPage + ", prev=" + prev + ", next=" + next + ", displayPageNum=" + displayPageNum + "]";
	}
	
	
	
	

}	// End - public class PageMaker
