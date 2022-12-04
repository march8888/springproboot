package kr.bit.entity;

import java.util.Collection;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.AuthorityUtils;
import org.springframework.security.core.userdetails.User;

import lombok.Data;

@Data
//사용자 정보 저장
public class CustomUser extends User{

	private Member member;
	
	public CustomUser(Member member) {
		//권한정보
		super(member.getUsername(), member.getPassword(), 
				AuthorityUtils.createAuthorityList("ROLE_" + member.getRole().toString()));
		
		//커스텀
		this.member = member;
	}

}
