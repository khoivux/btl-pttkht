package servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.SparePartDAO;
import model.SparePart;

@WebServlet("/customer/sparepart")
public class SearchSparePartServlet extends HttpServlet {
    private SparePartDAO sparePartDAO;

    @Override
    public void init() {
        sparePartDAO = new SparePartDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if ("search".equals(action)) {
            String keyword = request.getParameter("keyword");

            List<SparePart> spareParts = sparePartDAO.getSparePartList(keyword);
            request.setAttribute("spareParts", spareParts);
            request.setAttribute("keyword", keyword);
        }

        request.getRequestDispatcher("/customer/searchSparePartView.jsp").forward(request, response);
    }
}