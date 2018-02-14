package service.logic;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import domain.QuestionAnswerDTO;
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

	@Override
	public List<QuestionDTO> selectQuestionListByTitle(String title) {
		return questionDao.selectQuestionListByTitle(title);
	}

	@Override
	public List<HashMap<String, String>> selectQuestionAnswerList(String session_id) {
		return questionDao.selectQuestionAnswerList(session_id);
	}

	@Override
	public List<QuestionAnswerDTO> selectQuestionAnswer(String interviewee_vt_id, String interviewer_ea_id, String version_id) {
		HashMap<String, String> hashMap = new HashMap<>();
		hashMap.put("interviewee_vt_id", interviewee_vt_id);
		hashMap.put("interviewer_ea_id", interviewer_ea_id);
		hashMap.put("version_id", version_id);
		return questionDao.selectQuestionAnswer(hashMap);
	}

	
}
