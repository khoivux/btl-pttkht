package servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.Service;
import dao.ServiceDAO;

@WebServlet("/serviceDetail")
public class ServiceDetailServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String idParam = request.getParameter("id");
        if (idParam == null) {
            request.setAttribute("error", "Không có dịch vụ được chọn!");
        } else {
            try {
                int id = Integer.parseInt(idParam);
                ServiceDAO serviceDAO = new ServiceDAO();
                Service service = serviceDAO.getById(id);
                if (service == null) {
                    request.setAttribute("error", "Không tìm thấy dịch vụ có id=" + id);
                } else {
                    request.setAttribute("service", service);
                }
            } catch (NumberFormatException ex) {
                request.setAttribute("error", "Id dịch vụ không hợp lệ");
            }
        }
        request.getRequestDispatcher("serviceDetail.jsp").forward(request, response);
    }
}
