package domain;

public class QuestionDTO {
	private int version_id;
	private String version_title;
	private String q_number;
	private String content;

	public int getVersion_id() {
		return version_id;
	}

	public void setVersion_id(int version_id) {
		this.version_id = version_id;
	}

	public String getVersion_title() {
		return version_title;
	}

	public void setVersion_title(String version_title) {
		this.version_title = version_title;
	}

	public String getQ_number() {
		return q_number;
	}

	public void setQ_number(String q_number) {
		this.q_number = q_number;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	@Override
	public String toString() {
		return "QuestionDTO [version_id=" + version_id + ", version_title=" + version_title + ", q_number=" + q_number
				+ ", content=" + content + "]";
	}

}
