package store.mapper;

import java.util.List;

import domain.Notice;

public interface NoticeMapper {
	
	void createNotice(Notice notice);
	List<Notice> findAll();
	Notice findById(int id);
	void deleteNotice(int id);
	void updateNotice(Notice notice);
	List<Notice> findbytitle(String title);
	List<Notice> findbycontent(String content);
}
