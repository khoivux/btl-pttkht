package model;

public class Assignment {
	private int id;
	private TechnicalStaff technicalStaff;
	public Assignment(int id, TechnicalStaff technicalStaff) {
		super();
		this.id = id;
		this.technicalStaff = technicalStaff;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public TechnicalStaff getTechnicalStaff() {
		return technicalStaff;
	}
	public void setTechnicalStaff(TechnicalStaff technicalStaff) {
		this.technicalStaff = technicalStaff;
	}
	
}
