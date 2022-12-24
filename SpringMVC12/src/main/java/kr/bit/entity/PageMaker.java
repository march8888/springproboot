package kr.bit.entity;

import lombok.Data;

//페이징 처리를 만드는 클래스
@Data
public class PageMaker {
	private Criteria cri;
	private int totalCount; //총 게시글의 수
	private int startPage; //시작페이지 번호
	private int endPage; //끝페이지 번호(조정이 되어야 한다)
	private boolean prev; //이전버튼 노출,비노출
	private boolean next; //다음버튼 노출,비노출
	private int displayPageNum = 3; // 1 2 3 4 5 6 7 8 9 10
	
	//총게시글의 수를 구하는 메서드
	public void setTotalCount(int totalCount) {
		this.totalCount = totalCount;
		makePaging();
	}

	private void makePaging() {
		// 1.화면에 보여질 마지막 페이지 번호 : ceil(소수) - 더 큰 정수
		endPage = (int)(Math.ceil(cri.getPage()/(double)displayPageNum)*displayPageNum);
		// 2.화면에 보여질 시작 페이지 번호
		startPage = (endPage - displayPageNum) + 1;
		if(startPage <= 0) {
			startPage = 1;
		}
		// 3.전체 마지막 페이지 조정
		int tempEndPage = (int)(Math.ceil(totalCount/(double)cri.getPerPageNum()));
		// 4.화면에 보여질 마지막 페이지 유효성 체크
		if(tempEndPage < endPage) {
			endPage = tempEndPage;
		}
		// 5.이전 페이지 버튼(링크)존재 여부
		prev = (startPage == 1) ? false : true;
		// 6.다음 페이지 버튼(링크)존재 여부
		next = (endPage < tempEndPage) ? true : false;
	}
}
