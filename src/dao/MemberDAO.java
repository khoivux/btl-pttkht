package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import model.Customer;
import model.Member;
import model.Staff;
import model.Manager;

public class MemberDAO extends DAO {
	public MemberDAO() {
        super();
    }

    public Member authenticate(String username, String password) {
        Member member = null;
        String sql = "SELECT id, username, password, fullname, email, phoneNumber FROM tblMember WHERE username = ? AND password = ?";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, username);
            ps.setString(2, password);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    member = new Member();
                    member.setId(rs.getInt("id"));
                    member.setUsername(rs.getString("username"));
                    member.setPassword(rs.getString("password"));
                    member.setFullname(rs.getString("fullname"));
                    member.setEmail(rs.getString("email"));
                    member.setPhoneNumber(rs.getString("phoneNumber"));

                 
                    Staff staff = getStaffByMemberId(member);
                    if (staff != null) {
                        return staff;
                    }

                    Customer customer = getCustomerByMemberId(member);
                    if (customer != null) {
                        return customer;
                    }
                    
                    return member;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    private Staff getStaffByMemberId(Member member) {
        String sql = "SELECT position FROM tblStaff WHERE tblMemberid = ?";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, member.getId());
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    String role = rs.getString("position");
                    if (role != null && role.equalsIgnoreCase("manager")) {
                        Manager mng = new Manager(member);
                        mng.setRole(role);
                        return mng;
                    } else {
                        Staff staff = new Staff(member);
                        staff.setRole(role);
                        return staff;
                    }
                }
            }
        } catch (SQLException e) {
        	 e.printStackTrace();
        }
        return null;
    }

    private Customer getCustomerByMemberId(Member member) {
        String sql = "SELECT tblMemberid FROM tblCustomer WHERE tblMemberid = ?";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, member.getId());
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Customer c = new Customer(member);
                    c.setId(rs.getInt("tblMemberid"));
                    return c;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
}
