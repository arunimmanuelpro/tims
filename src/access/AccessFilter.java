package access;

import general.Scheduler;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class AccessFilter implements Filter {

	@SuppressWarnings({ "unchecked" })
	public void doFilter(ServletRequest req, ServletResponse resp,
			FilterChain chain) throws IOException, ServletException {
		// TODO Auto-generated method stub
		// place your code here
		
		try {
			Scheduler.start();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		HttpServletRequest request = (HttpServletRequest) req;
		HttpServletResponse response = (HttpServletResponse) resp;

		String current_file = request.getServletPath();

		String requestedUri = ((HttpServletRequest) request).getRequestURI();
	
		if (current_file.equalsIgnoreCase("/index.jsp")
				|| current_file.equalsIgnoreCase("/LoginAuthService")
				|| current_file.equalsIgnoreCase("/logout.jsp")
				|| current_file.equalsIgnoreCase("/forgotpassword.jsp")
				|| requestedUri.contains("/Accounts")
				|| requestedUri.matches(".*(css|jpg|png|gif|js)")) {

		} else {

			HttpSession ses = request.getSession();

			if (ses == null) {
				response.sendRedirect(request.getContextPath() + "/index.jsp?msg=Session_Invalid");
				return;
			} else {
				String user = (String) ses.getAttribute("user");
				Integer userid = (Integer) ses.getAttribute("id");
				String accesslevel = (String) ses.getAttribute("access");
				ArrayList<String> roles = (ArrayList<String>) ses.getAttribute("roles");

				if (user == null || userid == 0 || accesslevel == null) {
					response.sendRedirect(request.getContextPath()+"/index.jsp?msg=Invalid_Access");
					return;
				}

				request.setAttribute("user", user);
				request.setAttribute("userid", userid);
				request.setAttribute("level", accesslevel);
				request.setAttribute("roles", roles);
			}
		}
		chain.doFilter(request, response);
	}

	public void init(FilterConfig fConfig) throws ServletException {		
	}

	@Override
	public void destroy() {		
	}

}
