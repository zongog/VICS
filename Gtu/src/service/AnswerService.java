package service;

import java.util.List;

import domain.Answer;
import domain.Comment;

public interface AnswerService {
	
	void RegistAnswer(Comment comment);
	List<Comment> searchAll(int qna_id);
	void removeAllAnswer(int qna_id);
	void removeAnswer(int answer_id);
	
	
	void RegistComment(Answer answer);

}
