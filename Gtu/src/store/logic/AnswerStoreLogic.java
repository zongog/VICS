package store.logic;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import domain.Answer;
import domain.Comment;
import store.AnswerStore;
import store.mapper.AnswerMapper;

@Repository
public class AnswerStoreLogic implements AnswerStore{

	@Override
	public void createAnswer(Comment comment) {
		SqlSession session = Gtu_session_factory.getinstance().getSession();
		
		try {
			AnswerMapper mapper = session.getMapper(AnswerMapper.class);
			mapper.createAnswer(comment);
			session.commit();
		}finally {
			session.close();
		}
		
	}

	@Override
	public List<Comment> findAllAnswer(int qna_id) {
		
		SqlSession session = Gtu_session_factory.getinstance().getSession();
		List<Comment> list = null;
		
		try {
			AnswerMapper mapper = session.getMapper(AnswerMapper.class);
			list = mapper.findAllAnswer(qna_id);
			
		}finally {
			session.close();
		}
		
		return list;
	}

	@Override
	public void createComment(Answer answer) {
		
		SqlSession session = Gtu_session_factory.getinstance().getSession();
		
		try {
			
			AnswerMapper mapper = session.getMapper(AnswerMapper.class);
			mapper.createComment(answer);
			session.commit();
		}finally {
			session.close();
		}
		
	}

	@Override
	public void deleteAllComment(int qna_id) {
		
		SqlSession session = Gtu_session_factory.getinstance().getSession();
		
		try {
			AnswerMapper mapper = session.getMapper(AnswerMapper.class);
			mapper.deleteAllComment(qna_id);
			session.commit();
		}finally {
			session.close();
		}
		
	}

	@Override
	public void deleteComment(int answer_id) {
		
		SqlSession session = Gtu_session_factory.getinstance().getSession();
		
		try {
			AnswerMapper mapper = session.getMapper(AnswerMapper.class);
			mapper.deleteComment(answer_id);
			session.commit();
		}finally {
			session.close();
		}
		
	}
	
	

}
