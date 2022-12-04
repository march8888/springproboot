package kr.bit.entity;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

import lombok.Data;

@Entity	//실제 데이터베이스의 table
@Data
public class Board {	//VO <--ORM--> Table
	@Id	//PK
	@GeneratedValue(strategy = GenerationType.IDENTITY) //자동증가
	private Long idx;
	private String title;
	private String content;
	@Column(updatable = false)
	private String writer;
	//컬럼상세      삽입x              업데이트 x                디폴트값 설정
	@Column(insertable = false, updatable = false, columnDefinition = "datetime default now()")
	private Date indate; // now()
	@Column(insertable = false, updatable = false, columnDefinition = "int default 0")
	private Long count;
}
