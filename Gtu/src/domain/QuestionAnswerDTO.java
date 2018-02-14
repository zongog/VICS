package domain;

public class QuestionAnswerDTO {
	private int veteran_answer_id; 
	private int version_id;
	private String Q_number;
	private String binary_answer;
	private String interviewee_vt_id;
	private String interviewer_ea_id;
	private String question_date;
	
	public int getVeteran_answer_id() {
		return veteran_answer_id;
	}
	public void setVeteran_answer_id(int veteran_answer_id) {
		this.veteran_answer_id = veteran_answer_id;
	}
	public int getVersion_id() {
		return version_id;
	}
	public void setVersion_id(int version_id) {
		this.version_id = version_id;
	}
	public String getQ_number() {
		return Q_number;
	}
	public void setQ_number(String q_number) {
		Q_number = q_number;
	}
	public String getBinary_answer() {
		return binary_answer;
	}
	public void setBinary_answer(String binary_answer) {
		this.binary_answer = binary_answer;
	}
	public String getInterviewee_vt_id() {
		return interviewee_vt_id;
	}
	public void setInterviewee_vt_id(String interviewee_vt_id) {
		this.interviewee_vt_id = interviewee_vt_id;
	}
	public String getInterviewer_ea_id() {
		return interviewer_ea_id;
	}
	public void setInterviewer_ea_id(String interviewer_ea_id) {
		this.interviewer_ea_id = interviewer_ea_id;
	}
	public String getQuestion_date() {
		return question_date;
	}
	public void setQuestion_date(String question_date) {
		this.question_date = question_date;
	}
	@Override
	public String toString() {
		return "QuestionAnswerDTO [veteran_answer_id=" + veteran_answer_id + ", version_id=" + version_id
				+ ", Q_number=" + Q_number + ", binary_answer=" + binary_answer + ", interviewee_vt_id="
				+ interviewee_vt_id + ", interviewer_ea_id=" + interviewer_ea_id + ", question_date=" + question_date
				+ "]";
	}
}
