package kr.bit.service;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.bit.entity.Board;
import kr.bit.repository.BoardRepository;

@Service
public class BoardService implements BoardIService {
	
	@Autowired
	BoardRepository boardRepository;
	
	@Override
	public List<Board> getList() {
		
		List<Board> list = boardRepository.findAll();
		
		return list;
	}

	@Override
	public void register(Board vo) {
		boardRepository.save(vo);
	}

	@Override
	public Board get(long idx) {
		//Optional 데이터가 있는지 유무 확인
		Optional<Board> vo = boardRepository.findById(idx);
		return vo.get();
	}

	@Override
	public void remove(long idx) {
		boardRepository.deleteById(idx);
		
	}

	@Override
	public void update(Board vo) {
		//vo에 id가 없으면 insert로 간주, 있으면 update로 간주
		boardRepository.save(vo);
	}

}
