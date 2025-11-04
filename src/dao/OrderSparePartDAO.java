package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import model.OrderedSparePart;
import model.SparePart;

public class OrderSparePartDAO extends DAO {
	public OrderSparePartDAO() {
        super();
    }
	
	public List<OrderedSparePart> getOrderSparePartList(int invoiceId) {
	    List<OrderedSparePart> result = new ArrayList<>();
	    String sql =
	        "SELECT osp.id, osp.salePrice, osp.quantity, " +
	        "       sp.id AS sparePartId, sp.name, sp.price, sp.des " +
	        "FROM tblOrderedSparePart osp " +
	        "JOIN tblSparePart sp ON osp.tblSparePartid = sp.id " +
	        "WHERE osp.tblBillInvoiceid = ?";

	    try (PreparedStatement ps = con.prepareStatement(sql)) {
	        ps.setInt(1, invoiceId);
	        try (ResultSet rs = ps.executeQuery()) {
	            while (rs.next()) {
	                SparePart part = new SparePart();
	                part.setId(rs.getInt("sparePartId"));
	                part.setName(rs.getString("name"));
	                part.setPrice(rs.getFloat("price"));
	                part.setDes(rs.getString("des"));

	                OrderedSparePart osp = new OrderedSparePart();
	                osp.setId(rs.getInt("id"));
	                osp.setUnitPrice(rs.getFloat("salePrice"));
	                osp.setQuantity(rs.getInt("quantity"));
	                osp.setTotalPrice(osp.getQuantity() * osp.getUnitPrice());
	                osp.setSparePart(part);

	                result.add(osp);
	            }
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }

	    return result;
	}

}
