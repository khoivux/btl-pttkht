package servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.ServiceDAO;
import model.Service;


@WebServlet("/customer/service")
public class SearchServiceServlet extends HttpServlet{
	private ServiceDAO serviceDAO;
    public void init() {
    	serviceDAO = new ServiceDAO();
    }
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	String action = request.getParameter("action");
    	if("search".equals(action)) {
    		 String keyword = request.getParameter("keyword");
    	     List<Service> services = serviceDAO.getServiceList(keyword);
    	     request.setAttribute("services", services);
    	     request.setAttribute("keyword", keyword);
    	} else {
            request.setAttribute("services", null);
            request.setAttribute("keyword", "");
        }
    	request.getRequestDispatcher("/customer/searchServiceView.jsp").forward(request, response);
    }
}
