package kr.bit.entity;

import lombok.Data;

@Data
public class Criteria {
	private int page; //현재 페이지 번호
	private int perPageNum; //한 페이지에 보여줄 게시글의 수
	//검색기능
	private String type;
	private String keyword;
	
	public Criteria() {
		this.page = 1;
		this.perPageNum = 3;
	}
	// 현재 페이지의 게시글의 시작 번호
	public int getPageStart() {
		return (page - 1) * perPageNum; // limit 0,10 -> 0~9, limit(DB)는 0부터 시작이다
	}
	
	
	
}
