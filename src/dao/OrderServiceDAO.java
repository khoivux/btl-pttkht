package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import model.OrderedService;
import model.Service;

public class OrderServiceDAO extends DAO{
	public OrderServiceDAO() {
        super();
    }
	
	
	public List<OrderedService> getOrderServiceList(int invoiceId) {
        List<OrderedService> result = new ArrayList<>();
        
        String sql = 
                "SELECT os.id, os.quantity, os.salePrice, " +
                "       s.id AS serviceId, s.name, s.price, s.des " +
                "FROM tblOrderedService os " +
                "JOIN tblService s ON os.tblServiceid = s.id " +
                "WHERE os.tblInvoiceid = ?";
        
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, invoiceId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Service service = new Service();
                    service.setId(rs.getInt("serviceId"));
                    service.setName(rs.getString("name"));
                    service.setPrice(rs.getFloat("price"));
                    service.setDes(rs.getString("des"));

                    OrderedService os = new OrderedService();
                    os.setId(rs.getInt("id"));
                    os.setQuantity(rs.getInt("quantity"));
                    os.setUnitPrice(rs.getFloat("salePrice"));
                    os.setTotalPrice(os.getQuantity() * os.getUnitPrice());
                    os.setService(service);

                    result.add(os);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return result;
    }
}
