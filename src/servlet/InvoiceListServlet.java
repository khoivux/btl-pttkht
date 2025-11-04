package servlet;

import java.io.IOException;
import java.sql.Date;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.InvoiceDAO;
import dao.CustomerStatDAO;
import model.Customer;
import model.CustomerStat;
import model.Invoice;
@WebServlet("/invoiceList")
public class InvoiceListServlet extends HttpServlet{
	private InvoiceDAO invoiceDAO;
    private CustomerStatDAO customerStatDAO;
    public void init() {
    	invoiceDAO = new InvoiceDAO();
    	customerStatDAO = new CustomerStatDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    	String action = request.getParameter("action");
        
        if ("view".equals(action)) {
            String customerIdStr = request.getParameter("customerId");
            String startDateStr = request.getParameter("startDate");
            String endDateStr = request.getParameter("endDate");

            Date startDate = null;
            Date endDate = null;
            Integer customerId = null;

            if (startDateStr != null && !startDateStr.isEmpty()) {
                startDate = Date.valueOf(startDateStr);
            }
            if (endDateStr != null && !endDateStr.isEmpty()) {
                endDate = Date.valueOf(endDateStr);
            }

            if (customerIdStr != null && !customerIdStr.isEmpty()) {
                try {
                    customerId = Integer.parseInt(customerIdStr);
                } catch (NumberFormatException nfe) {
                    customerId = null;
                }
            }

            CustomerStat customerStat = null;
            if (customerId != null) {
                customerStat = customerStatDAO.getCustomerStatById(customerId.intValue(), startDate, endDate);
            }

            request.setAttribute("customer", customerStat);
            request.setAttribute("startDate", startDate);
            request.setAttribute("endDate", endDate);

            if (customerStat != null) {
                List<Invoice> invoices = invoiceDAO.getInvoiceList(customerStat.getId(), startDate, endDate);
                request.setAttribute("invoices", invoices);
            } else {
                request.setAttribute("invoices", null);
            }
        } else {
            request.setAttribute("invoices", null);
        }
        request.getRequestDispatcher("invoiceList.jsp").forward(request, response);
    }
}
