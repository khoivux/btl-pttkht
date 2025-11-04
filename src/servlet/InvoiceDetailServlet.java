package servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.InvoiceDAO;
import model.CustomerStat;
import model.Invoice;
import model.OrderedService;
import model.OrderedSparePart;
@WebServlet("/invoiceDetail")
public class InvoiceDetailServlet extends HttpServlet {


	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String idParam = request.getParameter("id");
        
		if (idParam != null) {
			try {
				int id = Integer.parseInt(idParam);
				
				InvoiceDAO invoiceDAO = new InvoiceDAO();
				Invoice invoice = invoiceDAO.getById(id);
				request.setAttribute("invoice", invoice);
			} catch (NumberFormatException ex) {
				request.setAttribute("invoice", null);
			}
		} else {
			request.setAttribute("invoice", null);
		}
		request.getRequestDispatcher("invoiceDetail.jsp").forward(request, response);
	}
}
