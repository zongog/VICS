package store;

import java.util.List;

import domain.Notice;

public interface NoticeStore {
	
	void createNotice(Notice notice);
	List<Notice> findAll();
	Notice findById(int id);
	void deleteNotice(int id);
	void updateNotice(Notice notice);

}
