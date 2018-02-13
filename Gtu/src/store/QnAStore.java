package store;

import java.util.List;

import domain.QnA;

public interface QnAStore {
	
	void createQnA(QnA qna);
	List<QnA> findAllQnA();
	QnA findQnAByid(int id);
	void update(QnA qna);
	void delete(int id);
	
	List<QnA> findbytitle(String title);
	List<QnA> findbyconetent(String content);
	List<QnA> findbymember(String member);

}
