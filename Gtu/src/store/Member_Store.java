package store;

import java.util.List;

import domain.Member;

public interface Member_Store {
	boolean create(Member member);
	List<Member> searchbymail(String name, String mail);
	List<Member> findpwbyemail(String id, String name, String mail);
	Member read(String id);
	Member login(String id, String role, String pw);

}
