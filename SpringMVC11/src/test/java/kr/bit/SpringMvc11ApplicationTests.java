package kr.bit;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.context.annotation.Bean;
import org.springframework.security.crypto.password.PasswordEncoder;

import kr.bit.entity.Member;
import kr.bit.entity.Role;
import kr.bit.repository.MemberRepository;

@SpringBootTest
class SpringMvc11ApplicationTests {

	@Autowired
	private MemberRepository memberRepository;
	@Autowired
	private PasswordEncoder encoder;
	
	@Test
	void createMember() {
		Member m = new Member();
		m.setUsername("poseidon2");
		m.setPassword(encoder.encode("1234"));
		m.setName("poseidon2");
		m.setRole(Role.ADMIN);
		m.setEnabled(true);
		memberRepository.save(m);
	}

}
