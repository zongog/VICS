package store.mapper;

import java.util.List;

import domain.Answer;
import domain.Comment;

public interface AnswerMapper {
	
	void createAnswer(Comment comment);
	List<Comment> findAllAnswer(int qna_id);
	void deleteAllComment(int qna_id);
	void deleteComment(int answer_id);
	
	
	void createComment(Answer answer);

}
