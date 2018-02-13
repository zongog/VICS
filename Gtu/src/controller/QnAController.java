package controller;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.List;
import java.util.UUID;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import domain.Comment;
import domain.QnA;
import service.AnswerService;
import service.QnAService;

@Controller
public class QnAController {
	
	@Autowired
	private QnAService qnaservice;
	@Autowired
	private AnswerService answerservice;
	
	@RequestMapping(value="/registQnA.do", method = RequestMethod.POST)
	   public ModelAndView registQnA(QnA qna) {
		
	    qnaservice.RegistQnA(qna);
	    
		ModelAndView modelAndView = new ModelAndView("findAllQnA.do");
		return modelAndView;
	}
	
	@RequestMapping("/findQnAbyid.do")
	   public ModelAndView findQnAbyid(int id) {
		
		
		List<Comment> list = answerservice.searchAll(id);
		QnA qna = qnaservice.searchQnAByid(id);
		
		ModelAndView modelAndView = new ModelAndView("qnadetail.jsp");
		modelAndView.addObject("qna", qna);
		modelAndView.addObject("list", list);
		return modelAndView;
	}
	
	@RequestMapping("/findAllQnA.do")
	   public ModelAndView findAllQnA() {
		
		ModelAndView modelAndView = new ModelAndView("QnAList.jsp");
		List<QnA> list = qnaservice.searchAll();
		
		JSONArray jArray = new JSONArray();
		
		for(QnA qna : list) {
			JSONObject questionJSON = new JSONObject();
			questionJSON.put("qna_id", qna.getQna_id());
			questionJSON.put("title", qna.getTitle());
			questionJSON.put("content", qna.getContent());
			questionJSON.put("qnadate", qna.getQnadate());
			questionJSON.put("member", qna.getMember());
			questionJSON.put("secret", qna.getSecret());
			questionJSON.put("attachment", qna.getAttachment());
			questionJSON.put("confirm", qna.getConfirm());
			jArray.add(questionJSON);
			
		}
		modelAndView.addObject("questionListJson", jArray);
		return modelAndView;
	}
	
	@RequestMapping("/findAllmember.do")
	   public ModelAndView findAllmember(String member) {
		
		ModelAndView modelAndView = new ModelAndView("QnAList.jsp");
		List<QnA> list = qnaservice.searchbymember(member);
		
		JSONArray jArray = new JSONArray();
		
		for(QnA qna : list) {
			JSONObject questionJSON = new JSONObject();
			questionJSON.put("qna_id", qna.getQna_id());
			questionJSON.put("title", qna.getTitle());
			questionJSON.put("content", qna.getContent());
			questionJSON.put("qnadate", qna.getQnadate());
			questionJSON.put("member", qna.getMember());
			questionJSON.put("secret", qna.getSecret());
			questionJSON.put("attachment", qna.getAttachment());
			questionJSON.put("confirm", qna.getConfirm());
			jArray.add(questionJSON);
			
		}
		modelAndView.addObject("questionListJson", jArray);
		return modelAndView;
	}
	
	@RequestMapping("/findAlltitle.do")
	   public ModelAndView findAlltitle(String title) {
		
		ModelAndView modelAndView = new ModelAndView("QnAList.jsp");
		List<QnA> list = qnaservice.searchbytitle(title);
		
		JSONArray jArray = new JSONArray();
		
		for(QnA qna : list) {
			JSONObject questionJSON = new JSONObject();
			questionJSON.put("qna_id", qna.getQna_id());
			questionJSON.put("title", qna.getTitle());
			questionJSON.put("content", qna.getContent());
			questionJSON.put("qnadate", qna.getQnadate());
			questionJSON.put("member", qna.getMember());
			questionJSON.put("secret", qna.getSecret());
			questionJSON.put("attachment", qna.getAttachment());
			questionJSON.put("confirm", qna.getConfirm());
			jArray.add(questionJSON);
			
		}
		modelAndView.addObject("questionListJson", jArray);
		return modelAndView;
	}
	
	@RequestMapping("/findAllcontent.do")
	   public ModelAndView findAllcontent(String content) {
		
		ModelAndView modelAndView = new ModelAndView("QnAList.jsp");
		List<QnA> list = qnaservice.searchbycontent(content);
		
		JSONArray jArray = new JSONArray();
		
		for(QnA qna : list) {
			JSONObject questionJSON = new JSONObject();
			questionJSON.put("qna_id", qna.getQna_id());
			questionJSON.put("title", qna.getTitle());
			questionJSON.put("content", qna.getContent());
			questionJSON.put("qnadate", qna.getQnadate());
			questionJSON.put("member", qna.getMember());
			questionJSON.put("secret", qna.getSecret());
			questionJSON.put("attachment", qna.getAttachment());
			questionJSON.put("confirm", qna.getConfirm());
			jArray.add(questionJSON);
			
		}
		modelAndView.addObject("questionListJson", jArray);
		return modelAndView;
	}
	
	@RequestMapping(value="/deleteQnA.do")
	   public ModelAndView deleteQnA(int id) {
			
		qnaservice.remove(id);
	    
		ModelAndView modelAndView = new ModelAndView("findAllQnA.do");
		return modelAndView;
	}
	
	

}
