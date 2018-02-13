package service.logic;

import java.sql.Date;
import java.util.Calendar;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import domain.QnA;
import service.QnAService;
import store.AnswerStore;
import store.QnAStore;

@Service
public class QnAServiceLogic implements QnAService{
	
	@Autowired
	private QnAStore qnastore;
	@Autowired
	private AnswerStore answerstore;

	@Override
	public void RegistQnA(QnA qna) {
		
		Date today = new Date(Calendar.getInstance().getTimeInMillis());
		qna.setQnadate(today);
		qnastore.createQnA(qna);
	}


	@Override
	public List<QnA> searchAll() {
		return qnastore.findAllQnA();
	}


	@Override
	public QnA searchQnAByid(int id) {
		return qnastore.findQnAByid(id);
	}


	@Override
	public void modify(QnA qna) {
		
		qnastore.update(qna);
		
	}


	@Override
	public List<QnA> searchbytitle(String title) {
		return qnastore.findbytitle(title);
	}


	@Override
	public List<QnA> searchbycontent(String content) {
		return qnastore.findbyconetent(content);
	}


	@Override
	public List<QnA> searchbymember(String member) {
		return qnastore.findbymember(member);
	}


	@Override
	public void remove(int id) {
		qnastore.delete(id);
		answerstore.deleteAllComment(id);
	}
	
	

}
