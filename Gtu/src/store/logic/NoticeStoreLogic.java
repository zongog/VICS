package store.logic;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import domain.Notice;
import store.NoticeStore;
import store.mapper.NoticeMapper;

@Repository
public class NoticeStoreLogic implements NoticeStore{

	@Override
	public void createNotice(Notice notice) {
		
		SqlSession session = Gtu_session_factory.getinstance().getSession();
		
		try {
			NoticeMapper mapper = session.getMapper(NoticeMapper.class);
			mapper.createNotice(notice);
			session.commit();
		}finally {
			session.close();
		}
	}

	@Override
	public List<Notice> findAll() {
		
		SqlSession session = Gtu_session_factory.getinstance().getSession();
		List<Notice> list = null;
		try {
			NoticeMapper mapper = session.getMapper(NoticeMapper.class);
			list = mapper.findAll();
			
		}finally {
			session.close();
		}
		
		return list;
	}

	@Override
	public Notice findById(int id) {
		
		SqlSession session = Gtu_session_factory.getinstance().getSession();
		Notice notice = null;
		
		try {
			NoticeMapper mapper = session.getMapper(NoticeMapper.class);
			notice = mapper.findById(id);
		}finally {
			session.close();
		}
		
		return notice;
	}

	@Override
	public void deleteNotice(int id) {
		
		SqlSession session = Gtu_session_factory.getinstance().getSession();
		
		try {
			NoticeMapper mapper = session.getMapper(NoticeMapper.class);
			mapper.deleteNotice(id);
			session.commit();
		}finally {
			session.close();
		}
	}

	@Override
	public void updateNotice(Notice notice) {
		
		SqlSession session = Gtu_session_factory.getinstance().getSession();
		
		try {
			NoticeMapper mapper = session.getMapper(NoticeMapper.class);
			mapper.updateNotice(notice);
			session.commit();
		}finally {
			session.close();
		}
		
	}
}
