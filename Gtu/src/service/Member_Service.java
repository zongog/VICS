package service;


import java.util.List;

import domain.Member;

public interface Member_Service {
	boolean register(Member member);
	Member login(Member member);
	List<Member> search(String name, String mail);
	List<Member> findpw(String id, String name, String mail);
	Member findbyid(String id);
}
