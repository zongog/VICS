package service;

import java.util.HashMap;
import java.util.List;

import domain.QuestionAnswerDTO;
import domain.QuestionDTO;

public interface QuestionService {
	List<QuestionDTO> selectQuestionList();
	void createQuestion(QuestionDTO questionDTO);
	int updateQuestion(List<QuestionDTO> questionList);
	String selectRecentlyVersionId();
	List<QuestionDTO> selectQuestionListById(int version_id);
	List<QuestionDTO> selectQuestionListByTitle(String title);
	List<HashMap<String, String>> selectQuestionAnswerList(String session_id);
	List<QuestionAnswerDTO> selectQuestionAnswer(String interviewee_vt_id, String interviewer_ea_id, String version_id);
}
