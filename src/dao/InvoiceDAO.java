package dao;

import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import model.Customer;
import model.Invoice;
import model.Member;
import model.SaleStaff;
// OrderServiceDAO and OrderSparePartDAO are in the same package (dao); no import needed
import model.OrderedService;
import model.OrderedSparePart;
import model.Service;
import model.SparePart;


public class InvoiceDAO  extends DAO{
	public InvoiceDAO() {
        super();
    }
    
    public Invoice getById(int invoiceId) {
        String sql = 
            "SELECT inv.id, inv.createdTime, inv.status, inv.licensePlate, inv.totalPrice, " +
            "       cu.tblMemberid AS customerId, m.fullname AS customerName, m.email AS email, m.phoneNumber AS phoneNumber, cu.customerId AS customerIdCode, " +
            "       ss.tblMemberid AS saleStaffId, sm.fullname AS saleStaffName " +
            "FROM tblInvoice inv " +
            "JOIN tblCustomer cu ON inv.tblCustomerid = cu.tblMemberid " +
            "JOIN tblMember m ON cu.tblMemberid = m.id " +
            "JOIN tblSaleStaff ss ON inv.tblSaleStaffid = ss.tblMemberid " +
            "JOIN tblMember sm ON ss.tblMemberid = sm.id " +
            "WHERE inv.id = ?";

        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, invoiceId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    // customer
                    Member member = new Member();
                    member.setId(rs.getInt("customerId"));
                    member.setFullname(rs.getString("customerName"));
                    member.setEmail(rs.getString("email"));
                    member.setPhoneNumber(rs.getString("phoneNumber"));
                    Customer customer = new Customer(member);
                    customer.setCustomerId(rs.getString("customerIdCode"));

                    // sale staff
                    Member saleMember = new Member();
                    saleMember.setId(rs.getInt("saleStaffId"));
                    saleMember.setFullname(rs.getString("saleStaffName"));
                    SaleStaff saleStaff = new SaleStaff(saleMember);

                    Invoice invoice = new Invoice();
                    invoice.setCustomer(customer);
                    invoice.setId(rs.getInt("id"));
                    invoice.setCreatedTime( rs.getTimestamp("createdTime"));
                    invoice.setLicensePlate(rs.getString("licensePlate"));
                    invoice.setStatus(rs.getString("status"));
                    invoice.setTotalPrice(0f);
                    invoice.setSaleStaff(saleStaff);
                    invoice.setTotalPrice(rs.getFloat("totalPrice"));


                    String sqlItems =
                        "SELECT os.id AS orderId, os.quantity AS quantity, os.salePrice AS salePrice, " +
                        "s.id AS serviceId, NULL AS spareId, s.name AS itemName, s.price AS itemPrice, s.des AS itemDes " +
                        "FROM tblOrderedService os JOIN tblService s ON os.tblServiceid = s.id " +
                        "WHERE os.tblInvoiceid = ? " +
                        "UNION ALL " +
                        "SELECT osp.id AS orderId, osp.quantity AS quantity, osp.salePrice AS salePrice, " +
                        "NULL AS serviceId, sp.id AS spareId, sp.name AS itemName, sp.price AS itemPrice, sp.des AS itemDes " +
                        "FROM tblOrderedSparePart osp JOIN tblSparePart sp ON osp.tblSparePartid = sp.id " +
                        "WHERE osp.tblInvoiceid = ?";

                    List<OrderedService> serviceList = new ArrayList<>();
                    List<OrderedSparePart> spareList = new ArrayList<>();

                    try (PreparedStatement psItems = con.prepareStatement(sqlItems)) {
                        psItems.setInt(1, invoiceId);
                        psItems.setInt(2, invoiceId);
                        try (ResultSet rsItems = psItems.executeQuery()) {
                            while (rsItems.next()) {
                                Object svcIdObj = rsItems.getObject("serviceId");
                                if (svcIdObj != null) {
                                    Service serviceObj = new Service();
                                    serviceObj.setId(rsItems.getInt("serviceId"));
                                    serviceObj.setName(rsItems.getString("itemName"));
                                    serviceObj.setPrice(rsItems.getFloat("itemPrice"));
                                    serviceObj.setDes(rsItems.getString("itemDes"));

                                    OrderedService os = new OrderedService();
                                    os.setId(rsItems.getInt("orderId"));
                                    os.setQuantity(rsItems.getInt("quantity"));
                                    os.setUnitPrice(rsItems.getFloat("salePrice"));
                                    os.setTotalPrice(os.getQuantity() * os.getUnitPrice());
                                    os.setService(serviceObj);
                                    serviceList.add(os);
                                } else {
                                    SparePart spareObj = new SparePart();
                                    spareObj.setId(rsItems.getInt("spareId"));
                                    spareObj.setName(rsItems.getString("itemName"));
                                    spareObj.setPrice(rsItems.getFloat("itemPrice"));
                                    spareObj.setDes(rsItems.getString("itemDes"));

                                    OrderedSparePart osp = new OrderedSparePart();
                                    osp.setId(rsItems.getInt("orderId"));
                                    osp.setQuantity(rsItems.getInt("quantity"));
                                    osp.setUnitPrice(rsItems.getFloat("salePrice"));
                                    osp.setTotalPrice(osp.getQuantity() * osp.getUnitPrice());
                                    osp.setSparePart(spareObj);
                                    spareList.add(osp);
                                }
                            }
                        }
                    }

                    float servicePrice = 0f;
                    for (OrderedService os : serviceList) servicePrice += os.getTotalPrice();
                    float sparePrice = 0f;
                    for (OrderedSparePart osp : spareList) sparePrice += osp.getTotalPrice();

                    invoice.setServiceList(serviceList);
                    invoice.setSparePartList(spareList);
                    invoice.setServicePrice(servicePrice);
                    invoice.setSparePartPrice(sparePrice);
                    

                    return invoice;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }
	public List<Invoice> getInvoiceList(int customerId, Date startDate, Date endDate) {
        List<Invoice> result = new ArrayList<>();

        String sql = 
                "SELECT inv.id, inv.createdTime, inv.status, inv.licensePlate, inv.totalPrice, " + 
                "       cu.tblMemberid AS customerId, m.fullname AS customerName, m.email AS email, m.phoneNumber AS phoneNumber, cu.customerId AS customerIdCode, " +
                "       ss.tblMemberid AS saleStaffId, sm.fullname AS saleStaffName " +
                "FROM tblInvoice inv " +
                "JOIN tblCustomer cu ON inv.tblCustomerid = cu.tblMemberid " +
                "JOIN tblMember m ON cu.tblMemberid = m.id " +
                "JOIN tblSaleStaff ss ON inv.tblSaleStaffid = ss.tblMemberid " +
                "JOIN tblMember sm ON ss.tblMemberid = sm.id " +
                "WHERE inv.tblCustomerid = ? ";

            boolean hasStart = (startDate != null);
            boolean hasEnd = (endDate != null);
            if (hasStart && hasEnd) {
                sql += "AND inv.createdTime >= ? AND inv.createdTime < DATE_ADD(?, INTERVAL 1 DAY) ";
            } else if (hasStart) {
                sql += "AND inv.createdTime >= ? ";
            } else if (hasEnd) {
                sql += "AND inv.createdTime < DATE_ADD(?, INTERVAL 1 DAY) ";
            }
            
            sql += " ORDER BY inv.createdTime ASC";

        try (PreparedStatement ps = con.prepareStatement(sql)) {
            int index = 1;
            ps.setInt(index++, customerId);
            if (hasStart) {
                ps.setDate(index++, new Date(startDate.getTime()));
            }
            if (hasEnd) {
                ps.setDate(index++, new Date(endDate.getTime()));
            }

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                // customer
                Member member = new Member();
                member.setId(rs.getInt("customerId"));
                member.setFullname(rs.getString("customerName"));
                member.setEmail(rs.getString("email"));
                member.setPhoneNumber(rs.getString("phoneNumber"));
                Customer customer = new Customer(member);
                customer.setCustomerId(rs.getString("customerIdCode"));

                // sale staff
 
                Member saleMember = new Member();
                saleMember.setId(rs.getInt("saleStaffId"));
                saleMember.setFullname(rs.getString("saleStaffName"));
                SaleStaff saleStaff = new SaleStaff(saleMember);

                // invoice
                Invoice invoice = new Invoice(
                    rs.getInt("id"),
                    rs.getTimestamp("createdTime"),
                    rs.getString("status"),
                    rs.getString("licensePlate"),
                    rs.getFloat("totalPrice"),
                    customer,
                    saleStaff,
                    null, // serviceList
                    null  // sparePartList
                );

                result.add(invoice);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return result;
    }
}
