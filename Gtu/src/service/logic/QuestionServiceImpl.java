package service.logic;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import domain.QuestionDTO;
import service.QuestionService;
import store.QuestionDAO;

@Service
public class QuestionServiceImpl implements QuestionService {

	@Resource
	QuestionDAO questionDao;
	
	@Override
	public List<QuestionDTO> selectQuestionList() {
		return questionDao.selectQuestionList();
	}

	@Override
	public void createQuestion(QuestionDTO questionDTO) {
		questionDao.createQuestion(questionDTO);
	}

	@Override
	public int updateQuestion(List<QuestionDTO> questionList) {
		return questionDao.updateQuestion(questionList);
	}

	@Override
	public String selectRecentlyVersionId() {
		return questionDao.selectRecentlyVersionId();
	}

	@Override
	public List<QuestionDTO> selectQuestionListById(int version_id) {
		return questionDao.selectQuestionListById(version_id);
	}

	
}
