package domain;

import java.sql.Date;
import java.util.List;

public class QnA {
	
	private int qna_id;
	private String title;
	private String content;
	private Date qnadate;
	private String secret;
	private String attachment;
	private String confirm;
	private String member;
	
	private List<Comment> comments;
	
	
	public QnA() {}
	
	

	public List<Comment> getComments() {
		return comments;
	}



	public void setComments(List<Comment> comments) {
		this.comments = comments;
	}



	public int getQna_id() {
		return qna_id;
	}

	public void setQna_id(int qna_id) {
		this.qna_id = qna_id;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public Date getQnadate() {
		return qnadate;
	}

	public void setQnadate(Date qnadate) {
		this.qnadate = qnadate;
	}

	public String getSecret() {
		return secret;
	}

	public void setSecret(String secret) {
		this.secret = secret;
	}

	

	public String getAttachment() {
		return attachment;
	}

	public void setAttachment(String attachment) {
		this.attachment = attachment;
	}

	public String getConfirm() {
		return confirm;
	}
	
	

	public String getMember() {
		return member;
	}

	public void setMember(String member) {
		this.member = member;
	}

	public void setConfirm(String confirm) {
		this.confirm = confirm;
	};
	

}
