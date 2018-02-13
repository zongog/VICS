package controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import domain.Member;
import service.Member_Service;

@Controller
public class MemberController {

	@Autowired
	private Member_Service service;

	@RequestMapping("/")
	public String showlogin() {
		return "login.jsp";
	}

	@RequestMapping("/memberlist.do")
	public ModelAndView showMusicChart(){
		List<Member> member = service.findall();
		ModelAndView modelAndView = new ModelAndView("memberlist.jsp");
		modelAndView.addObject("member", member);
		return modelAndView;
	}
	
	@RequestMapping("/main")
	public String showmain(HttpServletRequest req) {
		HttpSession session = req.getSession();

		if (session == null || session.getAttribute("loginedUser") == null) {
			return new String("redirect:login.do");
		}
		return "main.jsp";
	}

	@RequestMapping("/login.do")
	public String showlogin2() {
		return "login.jsp";
	}

	@RequestMapping("/joincpa.do")
	public String showJoincpa() {
		return "joincpa.jsp";
	}
	
	@RequestMapping("/modifymember.do")
	public String showmodifymember() {
		return "modifymember.jsp";
	}
	
	@RequestMapping(value = "/modifymember.do", method = RequestMethod.POST)
	public String modifymember(Member member, HttpServletRequest req) { // 같은 이름으로 매핑 다른이름일 경우 데이터만 안들어가고 에러는 안난다.

		service.modify(member);
		HttpSession session = req.getSession();
		session.setAttribute("loginedUser", member);

		return "main.jsp";
	}

	@RequestMapping(value = "/joincpa.do", method = RequestMethod.POST)
	public String joincpa(Member member) { // 같은 이름으로 매핑 다른이름일 경우 데이터만 안들어가고 에러는 안난다.

		boolean registered = service.register(member);

		if (!registered) {
			return "redirect:joincpa.do";
		}

		return "login.jsp";
	}
	@RequestMapping(value = "/joinea.do", method = RequestMethod.POST)
	public String joinea(Member member) { // 같은 이름으로 매핑 다른이름일 경우 데이터만 안들어가고 에러는 안난다.

		boolean registered = service.register(member);

		if (!registered) {
			return "redirect:joinea.do";
		}

		return "login.jsp";
	}
	@RequestMapping(value = "/joinveteran.do", method = RequestMethod.POST)
	public String joinveteran(Member member) { // 같은 이름으로 매핑 다른이름일 경우 데이터만 안들어가고 에러는 안난다.

		boolean registered = service.register(member);

		if (!registered) {
			return "redirect:joinveteran.do";
		}

		return "login.jsp";
	}


	@RequestMapping(value = "/login.do", method = RequestMethod.POST)
	public String login(Member member, HttpServletRequest req) {

		Member loginedUser = service.login(member);
		
		if (loginedUser != null) {
			HttpSession session = req.getSession();
			session.setAttribute("loginedUser", loginedUser);
		} else {
			HttpSession session = req.getSession();
			session.invalidate();
			return "login.jsp";
		}

		return "redirect:main";
	}

	@RequestMapping("/findbynamemail.do")
	public ModelAndView searchByName(@RequestParam("username") String name, @RequestParam("usermail") String mail) {
		List<Member> member = service.search(name, mail);
		ModelAndView modelAndView = new ModelAndView("findid.jsp");
		modelAndView.addObject("member", member);
		return modelAndView;
	}
	
	@RequestMapping("/findpwbyemail.do")
	public ModelAndView searchpw(@RequestParam("userid") String id, @RequestParam("username") String name, @RequestParam("usermail") String mail) {
		List<Member> member = service.findpw(id, name, mail);
		ModelAndView modelAndView = new ModelAndView("findpw.jsp");
		modelAndView.addObject("member", member);
		return modelAndView;
	}

	@RequestMapping("/checkId.do")
	public ModelAndView idcheck(@RequestParam("id") String id) {
		System.out.println("id" + id);
		Member member=null;
		member = service.findbyid(id);
		String idcheckment;
		if (member == null) {
			idcheckment = "사용 가능한 아이디 입니다.";
		} else {
			idcheckment = "이미 사용하고 있는 아이디입니다.";
		}
		ModelAndView modelAndView = new ModelAndView("checkId.jsp");
		modelAndView.addObject("idcheckment", idcheckment);
		return modelAndView;
	}
	
	@RequestMapping("/joincheckId.do")
	public ModelAndView joinidcheck(@RequestParam("id") String id) {
		System.out.println("id" + id);
		Member member=null;
		member = service.findbyid(id);
		String idcheckment;
		if (member == null) {
			idcheckment = "회원가입을 축하드립니다.";
		} else {
			idcheckment = "이미 사용하고 있는 아이디입니다.";
		}
		ModelAndView modelAndView = new ModelAndView("checkId.jsp");
		modelAndView.addObject("idcheckment", idcheckment);
		return modelAndView;
	}

	@RequestMapping("/logout.do")
	public String showlogout(HttpServletRequest req) {
		HttpSession session = req.getSession();
		session.invalidate();
		return "redirect:login.do";
	}

	@RequestMapping("/findid.do")
	public String showfindid() {
		System.out.println("START");
		return "findid.jsp";
	}
	
	@RequestMapping("/findpw.do")
	public String showfindpw() {
		System.out.println("START");
		return "findpw.jsp";
	}

	@RequestMapping("/joinea.do")
	public String showJoinea() {
		return "joinea.jsp";
	}

	@RequestMapping("/joinveteran.do")
	public String showJoinveteran() {
		return "joinveteran.jsp";
	}

	@RequestMapping("/join.do")
	public String showJoin() {
		return "join.jsp";
	}

}
