package controller;

import java.util.List;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import domain.Notice;
import service.NoticeService;

@Controller
public class NoticeController {
	
	@Autowired
	private NoticeService noticeService;
	
	@RequestMapping("/noticewrite.do")
	   public ModelAndView noticewrite(Notice notice) {
		noticeService.RegistNotice(notice);
		ModelAndView modelAndView = new ModelAndView("noticAll.do");
		return modelAndView;
	}
	
	@RequestMapping("/noticAll.do")
	   public ModelAndView noticView() {
		ModelAndView modelAndView = new ModelAndView("main.jsp");
		List<Notice> list = noticeService.searchAll();
		
		
		JSONArray jArray = new JSONArray();
		
	    for (Notice notice : list)
	    {
	         JSONObject questionJSON = new JSONObject();
	         questionJSON.put("id", notice.getId());
	         questionJSON.put("title", notice.getTitle());
	         questionJSON.put("hits", notice.getHits());
	         questionJSON.put("n_date", notice.getN_date());
	         questionJSON.put("attachment", notice.getAttachment());
	         jArray.add(questionJSON);
	    }
	    
	    modelAndView.addObject("questionListJson", jArray);
		return modelAndView;
	}
	
	@RequestMapping("/noticedetail.do")
	   public ModelAndView noticedetailView(int id) {
		
		
		Notice notice = noticeService.searchById(id);
		ModelAndView modelAndView = new ModelAndView("noticedetail.jsp");
		modelAndView.addObject("notice", notice);
		
		return modelAndView;
	}
	
	@RequestMapping("/deletenotice.do")
	   public ModelAndView deletenoticeView(int id) {
		
		noticeService.removeNotice(id);
		ModelAndView modelAndView = new ModelAndView("noticAll.do");
		return modelAndView;
	}
	
	@RequestMapping("/modifynotice.do")
	   public ModelAndView modifynotice(Notice notice, int id) {
		
		ModelAndView modelAndView = new ModelAndView("noticAll.do");
		return modelAndView;
	}

	@RequestMapping("/findNoticeByid.do")
	   public ModelAndView findNoticeByid(int id) {
		
		Notice notice = noticeService.searchById(id);
		
		ModelAndView modelAndView = new ModelAndView("noticmodify.jsp");
		modelAndView.addObject("notice", notice);
		return modelAndView;
	}
	
	@RequestMapping("/findAllBytitle.do")
	   public ModelAndView findAllBytitle(String title) {
		
			List<Notice> list = noticeService.searchBytitle(title);
			ModelAndView modelAndView = new ModelAndView("main.jsp");
			JSONArray jArray = new JSONArray();
			
		    for (Notice notice : list)
		    {
		         JSONObject questionJSON = new JSONObject();
		         questionJSON.put("id", notice.getId());
		         questionJSON.put("title", notice.getTitle());
		         questionJSON.put("hits", notice.getHits());
		         questionJSON.put("n_date", notice.getN_date());
		         questionJSON.put("attachment", notice.getAttachment());
		         jArray.add(questionJSON);
		    }
		    
		    modelAndView.addObject("questionListJson", jArray);
			return modelAndView;
		}
	
	@RequestMapping("/findAllBycontent.do")
	   public ModelAndView findAllBycontent(String content ) {
			List<Notice> list = noticeService.searchBycontent(content);
			ModelAndView modelAndView = new ModelAndView("main.jsp");
			JSONArray jArray = new JSONArray();
			
		    for (Notice notice : list)
		    {
		         JSONObject questionJSON = new JSONObject();
		         questionJSON.put("id", notice.getId());
		         questionJSON.put("title", notice.getTitle());
		         questionJSON.put("hits", notice.getHits());
		         questionJSON.put("n_date", notice.getN_date());
		         questionJSON.put("attachment", notice.getAttachment());
		         jArray.add(questionJSON);
		    }
		    
		    modelAndView.addObject("questionListJson", jArray);
			return modelAndView;
		}
	
}
