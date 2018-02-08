package controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import domain.Answer;
import domain.Comment;
import domain.QnA;
import service.AnswerService;
import service.QnAService;

@Controller
public class AnswerController {
	
	@Autowired
	private AnswerService answerservice;
	@Autowired
	private QnAService qnaservice;
	
	@RequestMapping("/registanswer.do")//->안됨
	   public ModelAndView registanswer(Comment comment, int qna_id) {
		
		answerservice.RegistAnswer(comment);
		
		if(comment.getMember().equals("관리자")) {
			QnA qna = new QnA();
			qna.setQna_id(qna_id);
			qna.setConfirm("완료");
			qnaservice.modify(qna);
		}
		
		List<Comment> list = answerservice.searchAll(qna_id);
		ModelAndView modelAndView = new ModelAndView("qnadetail.jsp");
		modelAndView.addObject("list", list);
		return modelAndView;
	}
	
	@RequestMapping("/registComment.do")
	   public ModelAndView registComment(Answer answer, int qna_id) {
		
		answerservice.RegistComment(answer);
		List<Comment> list = answerservice.searchAll(qna_id);
		ModelAndView modelAndView = new ModelAndView("qnadetail.jsp");
		modelAndView.addObject("list", list);
		return modelAndView;
	}
	
}
