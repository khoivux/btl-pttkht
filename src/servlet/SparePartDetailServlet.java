package servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.SparePart;
import dao.SparePartDAO;

@WebServlet("/customer/sparePartDetail")
public class SparePartDetailServlet extends HttpServlet {
	@Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String idParam = request.getParameter("id");
        if (idParam == null) {
            request.setAttribute("error", "Không có phụ tùng được chọn!");
        } else {
            try {
                int id = Integer.parseInt(idParam);
                SparePartDAO sparePartDAO = new SparePartDAO();
                SparePart sparePart = sparePartDAO.getById(id);
                if (sparePart == null) {
                    request.setAttribute("error", "Không tìm thấy phụ tùng có id=" + id);
                } else {
                    request.setAttribute("sparePart", sparePart);
                }
            } catch (NumberFormatException ex) {
                request.setAttribute("error", "Id phụ tùng không hợp lệ");
            }
        }
        request.getRequestDispatcher("/customer/sparePartDetailView.jsp").forward(request, response);
    }

}
