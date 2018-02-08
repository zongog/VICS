package service.logic;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import domain.Member;
import service.Member_Service;
import store.Member_Store;

@Service
public class Member_Service_Logic implements Member_Service {

	@Autowired
	private Member_Store store;

	@Override
	public boolean register(Member member) {
		//
		if (!validate(member)) {
			return false;
		} else if (store.read(member.getId()) != null) {
			return false;
		}
		return store.create(member);
	}

	@Override
	public Member login(Member user) {
		//
		Member readedUser = null;
		if (validate(user)) {
			readedUser = store.login(user.getId(), user.getRole(), user.getPw());
		}
		return readedUser;
	}

	private boolean validate(Member member) {
		//
		if (member == null) {
			throw new RuntimeException("사용자 정보가 없습니다.");
		} else if (member.getId() == null || member.getId().isEmpty()) {
			throw new RuntimeException("ID가 없습니다.");
		} else if (member.getPw() == null || member.getPw().isEmpty()) {
			throw new RuntimeException("비밀번호가 없습니다.");
		}
		return true;
	}

	@Override
	public List<Member> search(String name, String mail) {
		return store.searchbymail(name, mail);
	}
	
	@Override
	public List<Member> findpw(String id, String name, String mail) {
		return store.findpwbyemail(id, name, mail);
	}

	@Override
	public Member findbyid(String id) {
		return store.read(id);
	}
}
