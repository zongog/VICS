package store.logic;

import java.util.List;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

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

}
