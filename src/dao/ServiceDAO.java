package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import model.Service;

public class ServiceDAO extends DAO{
	public ServiceDAO() {
		super();
	}
	

    public List<Service> getServiceList(String keyword) {
        List<Service> result = new ArrayList<>();

        try {
            String sql = "SELECT * FROM tblService";
            if (keyword != null && !keyword.trim().isEmpty()) {
            	sql += " WHERE name LIKE ?";
            }

            PreparedStatement stm = con.prepareStatement(sql);
            
            if (keyword != null && !keyword.trim().isEmpty()) {
                stm.setString(1, "%" + keyword + "%");
            }

            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Service s = new Service(
                    rs.getInt("id"),
                    rs.getString("name"),
                    rs.getFloat("price"),
                    rs.getString("des")
                );
                result.add(s);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return result;
    }

    public Service getById(int id) {
        try {
            String sql = "SELECT * FROM tblService WHERE id = ?";
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setInt(1, id);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                Service s = new Service(
                    rs.getInt("id"),
                    rs.getString("name"),
                    rs.getFloat("price"),
                    rs.getString("des")
                );
                return s;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
}
