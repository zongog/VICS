package store;

import java.util.List;

import domain.QuestionDTO;

public interface QuestionDAO {
	List<QuestionDTO> selectQuestionList();

	void createQuestion(QuestionDTO questionDTO);

	int updateQuestion(List<QuestionDTO> questionList);

	String selectRecentlyVersionId();

	List<QuestionDTO> selectQuestionListById(int version_id);

	List<QuestionDTO> selectQuestionListByTitle(String title);
}
