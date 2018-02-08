package store.mapper;

import java.util.List;

import domain.QnA;

public interface QnAMapper {
	
	void createQnA(QnA qna);
	List<QnA> findAllQnA();
	QnA findQnAByid(int id);
	void update(QnA qna);

}
