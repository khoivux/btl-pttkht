package dao;

import java.sql.PreparedStatement;
import java.sql.Date;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import model.CustomerStat;
import model.Member;

public class CustomerStatDAO extends DAO {

    public CustomerStatDAO() {
        super();
    }

    public List<CustomerStat> getCustomerStatList(Date startDate, Date endDate) throws Exception{
        List<CustomerStat> result = new ArrayList<>();

        String sql = 
            "SELECT c.tblMemberid AS id, c.customerId AS customerId, " +
            "       m.username, m.fullname, m.email, m.phoneNumber, " +
            "       IFNULL(SUM(os.quantity * os.salePrice), 0) + " +
            "       IFNULL(SUM(osp.quantity * osp.salePrice), 0) AS totalRevenue " +
            "FROM tblCustomer c " +
            "JOIN tblMember m ON c.tblMemberid = m.id " +
            "LEFT JOIN tblInvoice inv ON inv.tblCustomerid = c.tblMemberid " +
            "LEFT JOIN tblOrderedService os ON os.tblInvoiceid = inv.id " +
            "LEFT JOIN tblOrderedSparePart osp ON osp.tblInvoiceid = inv.id "
        ;

 
        boolean hasStart = (startDate != null);
        boolean hasEnd = (endDate != null);
        if (hasStart && hasEnd) {
            sql += "WHERE inv.createdTime >= ? AND inv.createdTime < DATE_ADD(?, INTERVAL 1 DAY) ";
        } else if (hasStart) {
            sql += "WHERE inv.createdTime >= ? ";
        } else if (hasEnd) {
            sql += "WHERE inv.createdTime < DATE_ADD(?, INTERVAL 1 DAY) ";
        }


        sql += ("GROUP BY c.tblMemberid, m.username, m.fullname, m.email, m.phoneNumber;");

        try (PreparedStatement ps = con.prepareStatement(sql.toString())) {
            int index = 1;
            if (hasStart) {
                ps.setDate(index++, new Date(startDate.getTime()));
            }
            if (hasEnd) {
                ps.setDate(index++, new Date(endDate.getTime()));
            }

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Member member = new Member();
                member.setId(rs.getInt("id"));
                member.setUsername(rs.getString("username"));
                member.setFullname(rs.getString("fullname"));
                member.setEmail(rs.getString("email"));
                member.setPhoneNumber(rs.getString("phoneNumber"));

                CustomerStat stat = new CustomerStat(member);
                stat.setCustomerId(rs.getString("customerId"));
                stat.setTotalRevenue(rs.getFloat("totalRevenue"));
                result.add(stat);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return result;
    }

    /**
     * Get customer stat for a single customer id within optional date range.
     */
    public CustomerStat getCustomerStatById(int customerId, Date startDate, Date endDate) {
        String sql =
            "SELECT c.tblMemberid AS id, c.customerId AS customerId, " +
            "       m.username, m.fullname, m.email, m.phoneNumber, " +
            "       IFNULL(SUM(os.quantity * os.salePrice), 0) + " +
            "       IFNULL(SUM(osp.quantity * osp.salePrice), 0) AS totalRevenue " +
            "FROM tblCustomer c " +
            "JOIN tblMember m ON c.tblMemberid = m.id " +
            "JOIN tblInvoice inv ON inv.tblCustomerid = c.tblMemberid " +
            "LEFT JOIN tblOrderedService os ON os.tblInvoiceid = inv.id " +
            "LEFT JOIN tblOrderedSparePart osp ON osp.tblInvoiceid = inv.id " ;

        boolean hasStart = (startDate != null);
        boolean hasEnd = (endDate != null);

        sql += " WHERE c.tblMemberid = ? ";
        if (hasStart && hasEnd) {
            sql += " AND inv.createdTime >= ? AND inv.createdTime < DATE_ADD(?, INTERVAL 1 DAY) ";
        } else if (hasStart) {
            sql += " AND inv.createdTime >= ? ";
        } else if (hasEnd) {
            sql += " AND inv.createdTime < DATE_ADD(?, INTERVAL 1 DAY) ";
        }

        sql += " GROUP BY c.tblMemberid, m.username, m.fullname, m.email, m.phoneNumber;";

        try (PreparedStatement ps = con.prepareStatement(sql)) {
            int idx = 1;
            ps.setInt(idx++, customerId);
            if (hasStart) ps.setDate(idx++, new Date(startDate.getTime()));
            if (hasEnd) ps.setDate(idx++, new Date(endDate.getTime()));

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Member member = new Member();
                member.setId(rs.getInt("id"));
                member.setUsername(rs.getString("username"));
                member.setFullname(rs.getString("fullname"));
                member.setEmail(rs.getString("email"));
                member.setPhoneNumber(rs.getString("phoneNumber"));

                CustomerStat stat = new CustomerStat(member);
                stat.setCustomerId(rs.getString("customerId"));
                stat.setTotalRevenue(rs.getFloat("totalRevenue"));
                return stat;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }

}
