package model;

public class Staff extends Member{
	private String role;
	public Staff(Member member) {
    	super(
    	        member.getId(),
    	        member.getUsername(),
    	        member.getPassword(),
    	        member.getFullname(),
    	        member.getEmail(),
    	        member.getPhoneNumber()
 
    	    );
        // role will be set later (fetched from staff table)
        this.role = null;
    }
	public String getRole() {
		return role;
	}
	public void setRole(String role) {
		this.role = role;
	}
	
	
}
