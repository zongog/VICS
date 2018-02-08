package store.mapper;


import java.util.List;

import org.apache.ibatis.annotations.Param;

import domain.Member;

public interface MemberMapper {
	
	boolean create(Member member);

	Member cparead(String id);
	Member earead(String id);
	Member veteranread(String id);
	
	Member login(@Param("id")String id,@Param("role") String role, @Param("pw")String pw);
	
	List<Member> findincpa(@Param("username")String name, @Param("usermail")String mail);
	List<Member> findinea(@Param("username")String name, @Param("usermail")String mail);
	List<Member> findinveteran(@Param("username")String name, @Param("usermail")String mail);
	
	
	List<Member> findpwincpa(@Param("userid")String id, @Param("username")String name, @Param("usermail")String mail);
	List<Member> findpwinea(@Param("userid")String id, @Param("username")String name, @Param("usermail")String mail);
	List<Member> findpwinveteran(@Param("userid")String id, @Param("username")String name, @Param("usermail")String mail);
}
