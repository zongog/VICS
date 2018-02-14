package store.mapper;


import java.util.List;

import org.apache.ibatis.annotations.Param;

import domain.Member;

public interface MemberMapper {
	
	boolean create(Member member);
	boolean update(Member member);

	Member cparead(String id);
	Member earead(String id);
	Member veteranread(String id);
	List<Member> findallea();
	List<Member> findallcpa();
	List<Member> findallveteran();
	Member login(@Param("id")String id,@Param("role") String role, @Param("pw")String pw);
	
	List<Member> findincpa(@Param("username")String name, @Param("usermail")String mail);
	List<Member> findinea(@Param("username")String name, @Param("usermail")String mail);
	List<Member> findinveteran(@Param("username")String name, @Param("usermail")String mail);
	
	
	List<Member> findpwincpa(@Param("userid")String id, @Param("username")String name, @Param("usermail")String mail);
	List<Member> findpwinea(@Param("userid")String id, @Param("username")String name, @Param("usermail")String mail);
	List<Member> findpwinveteran(@Param("userid")String id, @Param("username")String name, @Param("usermail")String mail);
	void deleteincpa(String id);
	void deleteinea(String id);
	void deleteinveteran(String id);
	
	void changepermissionea(String id);
	void changepermissioncpa(String id);
	void changepermissionveteran(String id);
	
}
