package service.logic;

import java.sql.Date;
import java.util.Calendar;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import domain.Notice;
import service.NoticeService;
import store.NoticeStore;

@Service
public class NoticeServiceLogic implements NoticeService{
	
	@Autowired
	private NoticeStore noticeStore;

	@Override
	public void RegistNotice(Notice notice) {
		Date today = new Date(Calendar.getInstance().getTimeInMillis());
		notice.setN_date(today);
		noticeStore.createNotice(notice);
	}

	@Override
	public List<Notice> searchAll() {
		return noticeStore.findAll();
	}

	@Override
	public Notice searchById(int id) {
		
		Notice notice = noticeStore.findById(id);
		
		notice.setHits(notice.getHits() + 1);
		noticeStore.updateNotice(notice);
		
		return notice;
	}

	@Override
	public void removeNotice(int id) {
		noticeStore.deleteNotice(id);
		
	}

	@Override
	public void modifyNotice(Notice notice) {
		
		noticeStore.updateNotice(notice);
	}

}
