package kr.bit.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.bit.entity.Board;
import kr.bit.entity.Criteria;
import kr.bit.entity.Member;
import kr.bit.mapper.BoardMapper;

@Service
public class BoardService implements BoardIService {

	@Autowired
	BoardMapper mapper;
	
	@Override
	public List<Board> getList(Criteria cri) {
		
		List<Board> list = mapper.getList(cri);
		
		return list;
	}

	@Override
	public void insertSelectKey(Board vo) {
		mapper.insertSelectKey(vo);
	}

	@Override
	public Member login(Member vo) {
		
		Member mvo = mapper.login(vo);
		
		return mvo;
	}

	@Override
	public Board get(int idx) {
		
		Board mvo = mapper.read(idx);
		
		return mvo;
	}

	@Override
	public void modify(Board vo) {
		
		mapper.update(vo);
		
	}

	@Override
	public void remove(int idx) {
		mapper.delete(idx);
		
	}

	@Override
	public void reply(Board vo) {
		//답글처리
		// 1. 부모글(원글)의 정보를 가져오기
		Board parent = mapper.read(vo.getIdx());
		// 2. 부모글의 boardGroup의 값을 -> 답글정보에 저장하기
		vo.setBoardGroup(parent.getBoardGroup());
		// 3. 부모글의 boardSequence의 값을 1 더해서 저장하기
		vo.setBoardSequence(parent.getBoardSequence() + 1);
		// 3. 부모글의 boardLeve의 값을 1 더해서 저장하기
		vo.setBoardLevel(parent.getBoardLevel() + 1);
		// 5. 같은 boardGroup에 있는 글 중에서 부모글의 boardSequence
		//	  보다 큰 값들을 모두 1씩 업데이트하기
		mapper.replySeqUpdate(parent);
		// 6. 답글 저장하기
		mapper.replyInsert(vo);
		
	}

	@Override
	public int totalCount(Criteria cri) {
		
		return mapper.totalCount(cri);
	}
	
	

}
