package model;

import java.sql.Date;

public class Customer extends Member {

    private String customerId;

    public Customer(Member member) {
        super();
        if (member != null) {
            this.setId(member.getId());
            this.setUsername(member.getUsername());
            this.setPassword(member.getPassword());
            this.setFullname(member.getFullname());
            this.setEmail(member.getEmail());
            this.setPhoneNumber(member.getPhoneNumber());
        }
    }


	public String getCustomerId() {
        return customerId;
    }

    public void setCustomerId(String customerId) {
        this.customerId = customerId;
    }
}
