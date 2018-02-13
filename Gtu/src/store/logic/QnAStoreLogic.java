package store.logic;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import domain.QnA;
import store.QnAStore;
import store.mapper.QnAMapper;

@Repository
public class QnAStoreLogic implements QnAStore{

	@Override
	public void createQnA(QnA qna) {
		
		SqlSession session = Gtu_session_factory.getinstance().getSession();
		
		try {
			QnAMapper mapper = session.getMapper(QnAMapper.class);
			mapper.createQnA(qna);
			session.commit();
		}finally {
			session.close();
		}
	}

	@Override
	public List<QnA> findAllQnA() {
		
		SqlSession session = Gtu_session_factory.getinstance().getSession();
		List<QnA> list = null;
		
		try {
			QnAMapper mapper = session.getMapper(QnAMapper.class);
			list = mapper.findAllQnA();
			
		}finally {
			session.close();
		}
		
		return list;
	}

	@Override
	public QnA findQnAByid(int id) {
		
		SqlSession session = Gtu_session_factory.getinstance().getSession();
		QnA qna = null;
		
		try {
			QnAMapper mapper = session.getMapper(QnAMapper.class);
			qna = mapper.findQnAByid(id);
		}finally {
			session.close();
		}
		return qna;
	}

	@Override
	public void update(QnA qna) {
		
		SqlSession session = Gtu_session_factory.getinstance().getSession();
		
		try {
			QnAMapper mapper = session.getMapper(QnAMapper.class);
			mapper.update(qna);
			session.commit();
		}finally {
			session.close();
		}
	}

	@Override
	public List<QnA> findbytitle(String title) {
		
		SqlSession session = Gtu_session_factory.getinstance().getSession();
		List<QnA> list = null;
		
		try {
			QnAMapper mapper = session.getMapper(QnAMapper.class);
			list = mapper.findbytitle(title);
		}finally {
			session.close();
		}
		return list;
	}

	@Override
	public List<QnA> findbyconetent(String content) {
		
		SqlSession session = Gtu_session_factory.getinstance().getSession();
		List<QnA> list = null;
		
		try {
			QnAMapper mapper = session.getMapper(QnAMapper.class);
			list = mapper.findbyconetent(content);
		}finally {
			session.close();
		}
		
		return list;
	}

	@Override
	public List<QnA> findbymember(String member) {
		
		SqlSession session = Gtu_session_factory.getinstance().getSession();
		List<QnA> list = null;
		
		try {
			QnAMapper mapper = session.getMapper(QnAMapper.class);
			list = mapper.findbymember(member);
		}finally {
			session.close();
		}
		return list;
	}

	@Override
	public void delete(int id) {
		
		
		SqlSession session = Gtu_session_factory.getinstance().getSession();
		
		try {
			QnAMapper mapper = session.getMapper(QnAMapper.class);
			mapper.delete(id);
			session.commit();
		}finally {
			session.close();
		}
	}

}
