package service.logic;

import java.sql.Date;
import java.util.Calendar;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import domain.Answer;
import domain.Comment;
import service.AnswerService;
import store.AnswerStore;

@Service
public class AnswerServiceLogic implements AnswerService{
	
	@Autowired
	private AnswerStore answerStore;

	@Override
	public void RegistAnswer(Comment comment) {
		
		Date today = new Date(Calendar.getInstance().getTimeInMillis());
		comment.setAnswer_date(today);
		
		answerStore.createAnswer(comment);
		
	}

	@Override
	public List<Comment> searchAll(int qna_id) {
		return answerStore.findAllAnswer(qna_id);
	}

	@Override
	public void RegistComment(Answer answer) {
		
		Date today = new Date(Calendar.getInstance().getTimeInMillis());
		answer.setComment_date(today);
		
		answerStore.createComment(answer);
		
	}

	@Override
	public void removeAllAnswer(int qna_id) {
		answerStore.deleteAllComment(qna_id);
	}

	@Override
	public void removeAnswer(int answer_id) {
		answerStore.deleteComment(answer_id);
	}

}
