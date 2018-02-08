package store;

import java.util.List;

import domain.Answer;
import domain.Comment;

public interface AnswerStore {
	
	void createAnswer(Comment comment);
	List<Comment> findAllAnswer(int qna_id);
	void createComment(Answer answer);
	

}
