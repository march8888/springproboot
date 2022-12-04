package kr.bit.service;

import java.util.List;

import kr.bit.entity.Board;

public interface BoardIService {
	public List<Board> getList();	//전체리스트
	public void register(Board vo);	//글등록
	public Board get(long idx);
	public void remove(long idx);
	public void update(Board vo);
}
