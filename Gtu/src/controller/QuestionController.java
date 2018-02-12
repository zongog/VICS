package controller;

import java.util.List;

import javax.annotation.Resource;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import domain.Member;
import domain.QuestionDTO;
import service.Member_Service;
import service.QuestionService;

@Controller
public class QuestionController {
	
	@Resource
	private QuestionService questionService;
	
	@Autowired
	private Member_Service memberService;

	/**
	 * 공지사항 리스트 화면으로 이동
	 * @return
	 */
	@RequestMapping(value = "notice.do")
	public String index() {
		return "noticAll.do";
	}
	
	/**
	 * 질의서 id값과 제목 값을 가져와 List를 출력
	 * @return
	 */
	@RequestMapping(value = "questionList.do")
	public ModelAndView showJoincpa() {
		ModelAndView mv = new ModelAndView("/WEB-INF/views/question/question_list.jsp");
		
		List<QuestionDTO> questionList = questionService.selectQuestionList();//QuestionDTO 받아오기
		
		
		// JSONObject jObject = new JSONObject();
	    JSONArray jArray = new JSONArray();
	    for (QuestionDTO questionDTO : questionList)
	    {
	         JSONObject questionJSON = new JSONObject();
	         questionJSON.put("version_id", questionDTO.getVersion_id());
	         questionJSON.put("version_title", questionDTO.getVersion_title());
	         jArray.add(questionJSON);
	    }
	    // jObject.put("StudentList", jArray);
		mv.addObject("questionListJson", jArray);
		return mv;
	}
	
	//EA_list에 DB에 있는 질의서 답변항목들을 출력
	/*@RequestMapping(value = "getEAList.do")
	public ModelAndView showEAList() {
		ModelAndView mv = new ModelAndView("/WEB-INF/views/question/question_list.jsp");
		
		List<QuestionDTO> questionList = questionService.selectQuestionList();//QuestionDTO 받아오기
		
	    JSONArray jArray = new JSONArray();
	    for (QuestionDTO questionDTO : questionList)
	    {
	         JSONObject questionJSON = new JSONObject();
	         questionJSON.put("version_id", questionDTO.getVersion_id());
	         questionJSON.put("version_title", questionDTO.getVersion_title());
	         jArray.add(questionJSON);
	    }
	    // jObject.put("StudentList", jArray);
		mv.addObject("EAListJson", jArray);
		return mv;
	}*/
	
	/**
	 * Admin 질의서 작성 화면으로 이동
	 * @return
	 */
	@RequestMapping(value = "createQuestionPage.do")
	public String createQuestionPage() {
		 return "/WEB-INF/views/question/adminpage.jsp"; 
	}

	/**
	 * Admin 질의서 작성 후 List 화면으로 이동
	 * @param data
	 * @throws ParseException
	 */
	@RequestMapping(value = "createQuestion.do", method = RequestMethod.POST,  produces = "application/text; charset=utf8")
	@ResponseBody
	public void createQuestion(@RequestBody String data) throws ParseException {
		JSONParser parser = new JSONParser();
		JSONObject jsonObj = (JSONObject) parser.parse(data);
		JSONArray jsonArray = (JSONArray) parser.parse((String)jsonObj.get("main"));
		String version_title = (String) jsonObj.get("version_title");
		
		// 가장 최근 version_id값 가져오기
		String version_id_s = questionService.selectRecentlyVersionId();
		System.out.println("version_id_s: " + version_id_s);
		int version_id = 0;
		if(version_id_s == null)	// 값이 아예 없을 경우(첫 insert)
			version_id = 1;
		else 						// 값이 있을 경우 그 값의 +1
			version_id = Integer.parseInt(version_id_s) + 1;
		System.out.println("version_id: " + version_id);
		for (int i = 0; i < jsonArray.size(); i++) {
			JSONObject jsonObject = (JSONObject) jsonArray.get(i);
			String q_number = (String) jsonObject.get("q_number");
			String content = (String) jsonObject.get("content");
			
			// .을 제거해준다
			q_number = q_number.replaceAll("\\.", "");
			
			// 새 QuestionDTO 객체를 만든다
			QuestionDTO questionDTO = new QuestionDTO();
			questionDTO.setContent(content);
			questionDTO.setQ_number(q_number);
			questionDTO.setVersion_title(version_title);
			questionDTO.setVersion_id(version_id);
			
			questionService.createQuestion(questionDTO);
		}
	}
	

	/*
	* Admin 질의서 디테일 페이지 이동
    * @return
    */
   @RequestMapping(value = "selectQuestionDetail.do")
   public ModelAndView selectQuestionDetail(String version_id) {
      ModelAndView mv = new ModelAndView("/WEB-INF/views/question/admin_detail.jsp");
      
      List<QuestionDTO> questionList = questionService.selectQuestionListById(Integer.parseInt(version_id));
      mv.addObject("version_title", questionList.get(0).getVersion_title());
      
       JSONArray jArray = new JSONArray();
       for (QuestionDTO questionDTO : questionList)
       {
            JSONObject questionJSON = new JSONObject();
            questionJSON.put("version_id", questionDTO.getVersion_id());
            questionJSON.put("version_title", questionDTO.getVersion_title());
            // q_number 사이사이에 .추가
            String q_number = questionDTO.getQ_number();
            StringBuffer sb = new StringBuffer(q_number);
            for (int i = 1; i < (q_number.length() * 2) - 2; i+=2) {
               sb.insert(i, ".");
            }
            questionJSON.put("q_number", sb.toString());
            questionJSON.put("content", questionDTO.getContent());
            jArray.add(questionJSON);
       }
       System.out.println(jArray.toString());
      mv.addObject("questionListJson", jArray);
      return mv;
   }
   
	/*@RequestMapping(value = "/joincpa.do", method = RequestMethod.POST)
	public String showjoincpa(MemberDTO member) {

		boolean registered = service.register(member);

		if (!registered) {
			return  "redirect:join.do";
		}

		return "login.jsp";
	}*/
/*======================================EA================================*/
   /**
	 * EA질의서 관리 게시판 화면으로 이동
	 * @return
	 */
	@RequestMapping(value = "eaList.do")
	public String moveEaList() {
		 return "/WEB-INF/views/question/ea_list.jsp"; 
	}
	
	  /**
		 * EA질의서 관리 게시판 화면으로 이동
		 * @return
		 */
		@RequestMapping(value = "ea.detail")
		public ModelAndView movetest() {
			ModelAndView mv = new ModelAndView("/WEB-INF/views/question/ea_detail.jsp");
			List<QuestionDTO> questionList = questionService.selectQuestionList();
			mv.addObject("questionList", questionList);
			return mv; 
		}


	   @RequestMapping(value = "getReport.do", produces = "application/text; charset=utf8")
	@ResponseBody
	   public String getReport(String title) {
	      // ModelAndView mv = new ModelAndView("/WEB-INF/views/question/ea_detail.jsp");
	      List<QuestionDTO> questionList = questionService.selectQuestionListByTitle(title);
	      JSONArray jArray = new JSONArray();
	      for (QuestionDTO questionDTO : questionList)
	      {
	           JSONObject questionJSON = new JSONObject();
	           questionJSON.put("version_id", questionDTO.getVersion_id());
	           questionJSON.put("version_title", questionDTO.getVersion_title());
	           // q_number 사이사이에 .추가
	           String q_number = questionDTO.getQ_number();
	           StringBuffer sb = new StringBuffer(q_number);
	           for (int i = 1; i < (q_number.length() * 2) - 2; i+=2) {
	              sb.insert(i, ".");
	           }
	           
	           questionJSON.put("content", questionDTO.getContent());
	           questionJSON.put("q_number", sb.toString());
	           jArray.add(questionJSON);
	      }
//	      System.out.println(jArray.toString());
	      String a = jArray.toJSONString();
	      System.out.println(a);
	      return a;
	   }
		
		
	/**
	* EA질의서 관리 게시판->디테일 페이지 이동
    * @return
    */
//   @RequestMapping(value = "eaListDetail.do")
//   public ModelAndView selectEaDetail(String version_id) {
//      ModelAndView mv = new ModelAndView("/WEB-INF/views/question/ea_detail.jsp");
//      
//      List<QuestionDTO> questionList = questionService.selectQuestionListById(Integer.parseInt(version_id));
//      
//      mv.addObject("version_title", questionList.get(0).getVersion_title());
//      
//       JSONArray jArray = new JSONArray();
//       for (QuestionDTO questionDTO : questionList)
//       {
//            JSONObject questionJSON = new JSONObject();
//            questionJSON.put("version_id", questionDTO.getVersion_id());
//            questionJSON.put("version_title", questionDTO.getVersion_title());
//            // q_number 사이사이에 .추가
//            String q_number = questionDTO.getQ_number();
//            StringBuffer sb = new StringBuffer(q_number);
//            for (int i = 1; i < (q_number.length() * 2) - 2; i+=2) {
//               sb.insert(i, ".");
//            }
//            questionJSON.put("q_number", sb.toString());
//            questionJSON.put("content", questionDTO.getContent());
//            jArray.add(questionJSON);
//       }
//       System.out.println(jArray.toString());
//      mv.addObject("questionListJson", jArray);
//      return mv;
//   }
   
   /*======================================Veteran================================*/
	@RequestMapping(value = "veteranList.do")
	public String moveVeteranList() {
		 return "/WEB-INF/views/question/veteran_list.jsp"; 
	}
	
}
