package store;

import java.util.List;

import domain.QnA;

public interface QnAStore {
	
	void createQnA(QnA qna);
	List<QnA> findAllQnA();
	QnA findQnAByid(int id);
	void update(QnA qna);

}
