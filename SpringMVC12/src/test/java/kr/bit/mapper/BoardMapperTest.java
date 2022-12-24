package kr.bit.mapper;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import kr.bit.entity.Board;
import lombok.extern.log4j.Log4j;

@Log4j
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
public class BoardMapperTest {
	
	@Autowired
	BoardMapper mapper;
	
//	public void testGetList() {
//		List<Board> list = mapper.getList();
//		
//		for(Board vo : list) {
//			System.out.println(vo);
//		}
//	}
	@Test
	public void testInsert() {
		Board vo = new Board();
		vo.setMemID("b3");
		vo.setTitle("3");
		vo.setContent("new3");
		vo.setWriter("m3");
		mapper.insertSelectKey(vo);
		log.info(vo);
	}
}
