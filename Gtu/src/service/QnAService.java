package service;

import java.util.List;

import domain.QnA;

public interface QnAService {
	
	void RegistQnA(QnA qna);
	List<QnA> searchAll();
	QnA searchQnAByid(int id);
	void modify(QnA qna);

}
