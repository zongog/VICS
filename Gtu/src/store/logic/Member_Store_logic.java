package store.logic;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import domain.Member;
import store.Member_Store;
import store.mapper.MemberMapper;

@Repository
public class Member_Store_logic implements Member_Store {

	@Override
	public boolean create(Member member) {

		SqlSession session = Gtu_session_factory.getinstance().getSession();
		boolean flag = false;

		try {
			MemberMapper mapper = session.getMapper(MemberMapper.class);
			flag = mapper.create(member);

			if (flag == true) {
				session.commit();
			} else {
				session.rollback();
			}
			return flag;
		} finally {
			session.close();
		}
	}


	
	@Override
	public List<Member> searchbymail(String name, String mail) {
		SqlSession session = Gtu_session_factory.getinstance().getSession();
		List<Member> member = null;
		System.out.println("name:"+name);
		System.out.println("mail:"+mail);
		System.out.println("logic");
		try {
			MemberMapper mapper = session.getMapper(MemberMapper.class);
			if (mapper.findincpa(name, mail) != null) {
				member = mapper.findincpa(name, mail);
				System.out.println("name:"+name);
				System.out.println("mail:"+mail);
				System.out.println("cpa");
			} else if (mapper.findinea(name, mail) != null) {
				member = mapper.findinea(name, mail);
				System.out.println("name:"+name);
				System.out.println("mail:"+mail);
				System.out.println("ea");
			} else {
				member = mapper.findinveteran(name, mail);
				System.out.println("name:"+name);
				System.out.println("mail:"+mail);
				System.out.println("veteran");
			}
		} finally {
			session.close();
		}
		return member;
	}
	
	@Override
	public List<Member> findpwbyemail(String id, String name, String mail) {
		SqlSession session = Gtu_session_factory.getinstance().getSession();
		List<Member> member = null;
		System.out.println("name:"+name);
		System.out.println("mail:"+mail);
		System.out.println("logic");
		try {
			MemberMapper mapper = session.getMapper(MemberMapper.class);
			if (mapper.findpwincpa(id, name, mail) != null) {
				member = mapper.findpwincpa(id, name, mail);
				System.out.println("name:"+name);
				System.out.println("mail:"+mail);
				System.out.println("cpa");
			} else if (mapper.findpwinea(id,name, mail) != null) {
				member = mapper.findpwinea(id,name, mail);
				System.out.println("name:"+name);
				System.out.println("mail:"+mail);
				System.out.println("ea");
			} else {
				member = mapper.findpwinveteran(id, name, mail);
				System.out.println("name:"+name);
				System.out.println("mail:"+mail);
				System.out.println("veteran");
			}
		} finally {
			session.close();
		}
		return member;
	}


	@Override
	public Member read(String id) {
		System.out.println("id" + id);
		SqlSession session = Gtu_session_factory.getinstance().getSession();
		Member user = null;

		try {
			MemberMapper mapper = session.getMapper(MemberMapper.class);
			if (mapper.cparead(id) != null) {
				user = mapper.cparead(id);
			} else if (mapper.earead(id) != null) {
				user = mapper.earead(id);
			} else {
				user = mapper.veteranread(id);
			}
		} finally {
			session.close();
		}
		return user;
	}

	@Override
	public Member login(String id, String role, String pw) {
		SqlSession session = Gtu_session_factory.getinstance().getSession();
		Member user = null;

		try {
			MemberMapper mapper = session.getMapper(MemberMapper.class);
			user = mapper.login(id, role, pw);
		} finally {
			session.close();
		}
		return user;
	}

}
