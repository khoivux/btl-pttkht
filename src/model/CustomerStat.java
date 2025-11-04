package model;

public class CustomerStat extends Customer {
	public CustomerStat(Member member) {
		super(member);
		// TODO Auto-generated constructor stub
	}
	
	private float totalRevenue;
	
	public float getTotalRevenue() {
		return totalRevenue;
	}
	public void setTotalRevenue(float totalRevenue) {
		this.totalRevenue = totalRevenue;
	}
	
}
