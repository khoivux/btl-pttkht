package servlet;

import java.io.IOException;
import java.sql.Date;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.CustomerStatDAO;
import model.CustomerStat;
import model.Service;
import model.SparePart;

@WebServlet("/customerStat")
public class CustomerStatServlet extends HttpServlet{
	private CustomerStatDAO customerStatDAO;
    public void init() {
    	customerStatDAO = new CustomerStatDAO();
    }
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if ("getstat".equals(action)) {
            try {
                String startDateStr = request.getParameter("startDate");
                String endDateStr = request.getParameter("endDate");

                Date startDate = null;
                Date endDate = null;

                if (startDateStr != null && !startDateStr.isEmpty()) {
                    startDate = Date.valueOf(startDateStr);
                }
                if (endDateStr != null && !endDateStr.isEmpty()) {
                    endDate = Date.valueOf(endDateStr);
                }

                CustomerStatDAO dao = new CustomerStatDAO();
                List<CustomerStat> customerStats = dao.getCustomerStatList(startDate, endDate);
                
                float totalRevenue = 0;
                
                for(CustomerStat cs : customerStats) {
                	totalRevenue += cs.getTotalRevenue();
                }
                
                request.setAttribute("customers", customerStats);
                request.setAttribute("startDate", startDateStr);
                request.setAttribute("endDate", endDateStr);
                request.setAttribute("totalRevenue", totalRevenue);

            } catch (Exception e) {
                e.printStackTrace();
                request.setAttribute("error", "Lỗi khi lấy thống kê khách hàng");
                request.setAttribute("customers", null);
            }

        } else {
            request.setAttribute("customers", null);
        }

        request.getRequestDispatcher("customerStat.jsp").forward(request, response);
    }
}
