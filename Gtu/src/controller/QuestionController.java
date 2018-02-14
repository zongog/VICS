package controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

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
import domain.QuestionAnswerDTO;
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

//   @RequestMapping(value = "eaList.do")
//   public ModelAndView moveEaList(HttpSession session) {
//      ModelAndView mv = new ModelAndView("/WEB-INF/views/question/ea_list.jsp");
//            
//      Member memberVO = (Member) session.getAttribute("loginedUser");
//      int session_id = memberVO.getSerial_number();
//      List<HashMap<String, String>> answerMapList = questionService.QuestionAnswerList(Integer.toString(session_id));
//      
//        JSONArray jArray = new JSONArray();
//        for (int i = 0; i < answerMapList.size(); i++) {
//           HashMap<String, String> answerHashMap = answerMapList.get(i);
//            JSONObject answerJSON = new JSONObject();
//            answerJSON.putAll(answerHashMap);
//            jArray.add(answerJSON);
//      }
//        mv.addObject("questionAnswerListJson", jArray);
//        System.out.println("JARRAY : " + jArray);
//      return mv;
//   }
   
   @RequestMapping(value = "eaList.do")
	public ModelAndView moveEaList() {
	   ModelAndView mv=new ModelAndView("/WEB-INF/views/question/ea_list.jsp");
	   
		
	   List<QuestionAnswerDTO> questionAnswerList = questionService.QuestionAnswerList();
	   
	   //System.out.println("version_title 출력 확인 : " + questionDTO.getVersion_title());
	   JSONArray jArray = new JSONArray();
	   for(QuestionAnswerDTO questionAnswerDTO : questionAnswerList) {
		   JSONObject questionJSON = new JSONObject();
		   questionJSON.put("version_id", questionAnswerDTO.getVersion_id());
		   questionJSON.put("interviewee_vt_id", questionAnswerDTO.getInterviewee_vt_id());
		   jArray.add(questionJSON);
	   }
	   System.out.println("jArray 출력 : " + jArray);
	   mv.addObject("questionAnswerListJson", jArray);
	   return mv;
	}
   
	/**
	 * EA질의서 관리 게시판->질의서 작성 화면으로 이동
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
		
	   
	   
	   int veteran_answer_id=0;//서버 돌릴 때마다 초기화해줘야 PK 중복되지 않음(ORA-00001 무결성제약에 걸리지 않음)
	   @RequestMapping(value = "saveEA.do" ,method = RequestMethod.POST,  produces = "application/text; charset=utf8")
	   @ResponseBody
		public void saveEa(@RequestBody String data) throws ParseException {
		   JSONParser parser = new JSONParser();
		   JSONObject jsonObj = (JSONObject) parser.parse(data);
		   System.out.println("넘어온 데이터1 : "+jsonObj.toJSONString());
		   JSONArray jsonArray = (JSONArray) parser.parse((String)jsonObj.get("main"));
		   System.out.println("넘어온 데이터2: "+jsonArray.toJSONString());
		   String ea_id = (String)jsonObj.get("EA");
		   String vt_id = (String)jsonObj.get("VETERAN");
		   int version_id = Integer.parseInt(jsonObj.get("version_id").toString());
		   
			
			for (int i = 0; i < jsonArray.size(); i++) {
				JSONObject jsonObject = (JSONObject) jsonArray.get(i);
				String binary_answer=(String) jsonObject.get("key4");
				String q_number = (String) jsonObject.get("head");
				
				// .을 제거해준다
				q_number = q_number.replaceAll("\\.", "");
				
				// 새 QuestionAnswerDTO 객체를 만든다
				QuestionAnswerDTO questionAnswerDTO = new QuestionAnswerDTO();
				
				questionAnswerDTO.setVeteran_answer_id(veteran_answer_id);
				veteran_answer_id++;
				questionAnswerDTO.setVersion_id(version_id);
				questionAnswerDTO.setQ_number(q_number);
				questionAnswerDTO.setBinary_answer(binary_answer);
				questionAnswerDTO.setInterviewee_vt_id(vt_id);
				questionAnswerDTO.setInterviewer_ea_id(ea_id);
				
		
				questionService.createEaList(questionAnswerDTO);
			}
			
		}

	   /**
		 * 질의서 id값과 제목 값을 가져와 List를 출력
		 * @return
		 */
	
   
   /*======================================Veteran================================*/
	/**
	 * Veteran) 자기가 응답한 질의서 목록보기
	 * @param session
	 * @return
	 */
	@RequestMapping(value = "veteranList.do")
	public ModelAndView moveVeteranList(HttpSession session) {
		ModelAndView mv = new ModelAndView("/WEB-INF/views/question/veteran_list.jsp");
				
		Member memberVO = (Member) session.getAttribute("loginedUser");
		int session_id = memberVO.getSerial_number();
		List<HashMap<String, String>> answerMapList = questionService.selectQuestionAnswerList(Integer.toString(session_id));
		
        JSONArray jArray = new JSONArray();
        for (int i = 0; i < answerMapList.size(); i++) {
        	HashMap<String, String> answerHashMap = answerMapList.get(i);
            JSONObject answerJSON = new JSONObject();
            answerJSON.putAll(answerHashMap);
            jArray.add(answerJSON);
		}
        mv.addObject("answerdata", jArray);
        
		return mv;
	}
	
	/**
	 * Veteran) 자기가 응답한 질의서 상세사항 보기
	 * @param version_id
	 * @param session
	 * @return
	 */
	@RequestMapping(value = "questionAnswerDetail.do")
	public ModelAndView questionAnswerDetail(String version_id, String interviewer_ea_id, HttpSession session) {
		ModelAndView mv = new ModelAndView("/WEB-INF/views/question/veteran_detail.jsp");
		
		Member memberVO = (Member) session.getAttribute("loginedUser");
		int session_id = memberVO.getSerial_number();
		List<QuestionDTO> questionDTOList = questionService.selectQuestionListById(Integer.parseInt(version_id));
		List<QuestionAnswerDTO> answerDTOList = questionService.selectQuestionAnswer(Integer.toString(session_id), interviewer_ea_id, version_id);
		
		System.out.println(questionDTOList.toString());
		System.out.println(answerDTOList.toString());
		

	    JSONArray jArray = new JSONArray();
	    for (int i = 0; i < questionDTOList.size(); i++) {
	    	QuestionDTO tempQuestionDTO = questionDTOList.get(i);
	    	QuestionAnswerDTO tempQuestionAnswerDTO = answerDTOList.get(i);
	        JSONObject questionJSON = new JSONObject();

	        // q_number 사이사이에 .추가
	        StringBuffer sb = new StringBuffer(tempQuestionDTO.getQ_number());
	        for (int j = 1; j < (tempQuestionDTO.getQ_number().length() * 2) - 2; j+=2) {
	           sb.insert(j, ".");
	        }
	        // jsonObject 질문번호(q_number) 추가
	        questionJSON.put("q_number", sb.toString());
	        
	        // jsonObject 질문항목(content) 추가
	        questionJSON.put("content", tempQuestionDTO.getContent());
	        
	        // jsonObject 응답 값(binary_answer) 추가
	        questionJSON.put("binary_answer", tempQuestionAnswerDTO.getBinary_answer());
	        
	        // jArray에 추가
	        jArray.add(questionJSON);
		}
		
		mv.addObject("veteranAnswerJson", jArray);
		return mv;
	}
	
}
