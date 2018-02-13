package service;

import java.util.List;

import domain.Notice;

public interface NoticeService {
	
	void RegistNotice(Notice notice);
	List<Notice> searchAll();
	Notice searchById(int id);
	void removeNotice(int id);
	void modifyNotice(Notice notice);
	
	List<Notice> searchBytitle(String title);
	List<Notice> searchBycontent(String content);
}
