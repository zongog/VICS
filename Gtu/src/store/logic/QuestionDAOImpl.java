package store.logic;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import domain.QuestionAnswerDTO;
import domain.QuestionDTO;
import store.QuestionDAO;

@Repository
public class QuestionDAOImpl implements QuestionDAO{

	@Resource
	private SqlSessionTemplate template;
	
	@Override
	public List<QuestionDTO> selectQuestionList() {
		return template.selectList("question.selectQuestionList");
	}

	@Override
	public void createQuestion(QuestionDTO questionDTO) {
		template.insert("createQuestion", questionDTO);
	}

	@Override
	public int updateQuestion(List<QuestionDTO> questionList) {
		return template.update("updateQuestion", questionList);
	}

	@Override
	public String selectRecentlyVersionId() {
		return template.selectOne("selectRecentlyVersionId");
	}

	@Override
	public List<QuestionDTO> selectQuestionListById(int version_id) {
		return template.selectList("question.selectQuestionListById", version_id);
	}

	@Override
	public List<QuestionDTO> selectQuestionListByTitle(String title) {
		return template.selectList("question.selectQuestionListByTitle",  title);
	}

	@Override
	public List<HashMap<String, String>> selectQuestionAnswerList(String session_id) {
		return template.selectList("question.selectQuestionAnswerList", session_id);
	}

	@Override
	public List<QuestionAnswerDTO> selectQuestionAnswer(HashMap<String, String> hashMap) {
		return template.selectList("question.selectQuestionAnswer", hashMap);
	}
	
	@Override	
	public void createEaList(QuestionAnswerDTO questionAnswerDTO) {
		template.insert("createEaList", questionAnswerDTO);
	}

	@Override
	public List<QuestionAnswerDTO> QuestionAnswerList() {
		// TODO Auto-generated method stub
		return template.selectList("question.QuestionAnswerList");
	}

}
