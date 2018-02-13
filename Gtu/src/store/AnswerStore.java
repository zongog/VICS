package store;

import java.util.List;

import domain.Answer;
import domain.Comment;

public interface AnswerStore {
	
	void createAnswer(Comment comment);
	List<Comment> findAllAnswer(int qna_id);
	void createComment(Answer answer);
	
	void deleteAllComment(int qna_id);
	void deleteComment(int answer_id);

}
