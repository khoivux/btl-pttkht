package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import model.SparePart;

public class SparePartDAO extends DAO {
    public SparePartDAO() {
        super();
    }

    public List<SparePart> getSparePartList(String keyword) {
        List<SparePart> result = new ArrayList<>();

        try {
            String SQL_QUERY = "SELECT * FROM tblSparePart";
            if (keyword != null && !keyword.trim().isEmpty()) {
                SQL_QUERY += " WHERE name LIKE ?";
            }

            PreparedStatement stm = con.prepareStatement(SQL_QUERY);
            if (keyword != null && !keyword.trim().isEmpty()) {
                stm.setString(1, "%" + keyword + "%");
            }

            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                SparePart sp = new SparePart();
                sp.setId(rs.getInt("id"));
                sp.setName(rs.getString("name"));
                sp.setPrice( rs.getFloat("price"));
               
                result.add(sp);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return result;
    }

    public SparePart getById(int id) {
        try {
            String sql = "SELECT * FROM tblSparePart WHERE id = ?";
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setInt(1, id);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                int qty = 0;
                try {
                    qty = rs.getInt("quantity");
                } catch (Exception ex) {
                    qty = 0;
                }
                SparePart sp = new SparePart(
                    rs.getInt("id"),
                    rs.getString("name"),
                    rs.getFloat("price"),
                    rs.getString("des"),
                    qty
                );
                return sp;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
}
