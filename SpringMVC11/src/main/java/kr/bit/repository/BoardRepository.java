package kr.bit.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import kr.bit.entity.Board;

@Repository								//CRUD          테이블,  id키 타입	
public interface BoardRepository extends JpaRepository<Board, Long> {
	
	//CRUD Method
	//쿼리메서드
	public Board findByWriter(String writer);
	//-> select * from Board where writer = #{writer}
}
