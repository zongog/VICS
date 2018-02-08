package service.logic;

import java.sql.Date;
import java.util.Calendar;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import domain.QnA;
import service.QnAService;
import store.QnAStore;

@Service
public class QnAServiceLogic implements QnAService{
	
	@Autowired
	private QnAStore qnastore;
	

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
	
	

}
