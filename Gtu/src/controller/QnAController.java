package controller;

import java.util.List;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
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
	
	@RequestMapping("/registQnA.do")
	   public ModelAndView registQnA(QnA qna) {
		
		if(qna.getSecret().equals("no")) {
			qna.setTitle("[비밀글]" + qna.getTitle());
		}
		
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

}
