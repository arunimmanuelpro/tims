package access;

import general.GetInfoAbout;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import constant.InfoConstant;
import security.SecureNew;

public class LoginAuthService extends HttpServlet {
	private static final long serialVersionUID = 1L;

	PrintWriter out;
	ResultSet rs;

	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		// Getting Database Connection
		response.setContentType("text/html");
		out = response.getWriter();

		String n = request.getParameter("userName");
		String p = request.getParameter("passWord");

		if (n != null && p != null) {
			try {
				HttpSession ses = request.getSession();
				if (checklogin(n, p)) {
					SecureNew snn = new SecureNew();
					ses.setAttribute("user", rs.getString("FirstName")+" "+rs.getString("LastName"));
					ses.setAttribute("id", rs.getInt("id"));
					ses.setAttribute("email", snn.decrypt(rs.getString("WorkEmail")));
					ses.setAttribute("epass", rs.getString("password"));					
					ses.setAttribute("designation", ((rs.getString("JobTitleId")==null?"Not Assigned":rs.getString("JobTitleId"))));
					InfoConstant.loginEmpId = (String)rs.getString("id");
					InfoConstant.WorkMailID = (String)ses.getAttribute("email");
					InfoConstant.MailPassWord = (String)ses.getAttribute("epass");
					InfoConstant.JobTitle = (String)ses.getAttribute("designation");
					
					//ses.setAttribute("ip", getIpAddr(request));
					// get role id for user id
					
					String roleid = AccessRoles.getrole(rs.getString("id"));
					if (roleid != null) {
						// Get Role Name
						String rolename = AccessRoles.getrolename(roleid);
						ses.setAttribute("access", rolename);
						InfoConstant.RoleID = (String)ses.getAttribute("access");
						// Get Role Permissons
						ArrayList<String> roles = AccessRoles.get_permissons(roleid);
						ses.setAttribute("roles", roles);
					}

					loginlog(rs.getString("FirstName")+" "+rs.getString("LastName"), getIpAddr(request));
					response.sendRedirect("home.jsp");
				} else {
					response.sendRedirect("index.jsp?msg=Accountnotfound");
					return;
				}

			} catch (Exception e) {
				e.printStackTrace();
				response.sendRedirect("error.jsp?msg=db_error");
				return;
			}
		} else {
			response.sendRedirect("index.jsp?msg=InvalidCredentials");
			return;
		}

	}

	public String getIpAddr(HttpServletRequest request) {
		String ip = request.getHeader("x-forwarded-for");
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("Proxy-Client-IP");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("WL-Proxy-Client-IP");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getRemoteAddr();
		}
		return ip;
	}

	public void loginlog(String user, String ip) throws Exception {

		SimpleDateFormat ddmm = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
		Date currentdate = new Date();
		String cDate = ddmm.format(currentdate);
		Connection logcon = DbConnection.getConnection();
		Statement logs = logcon.createStatement();
		String logsql = "INSERT INTO `login_log`(`username`, `when`, `where`) VALUES ('"+rs.getString("id") + "','" + cDate + "','" + ip + "')";
		logs.executeUpdate(logsql);
	}

	public boolean checklogin(String user, String pwd) throws Exception {
		boolean status = false;
		Connection scon = DbConnection.getConnection();
		PreparedStatement ps = scon.prepareStatement("select * from `Employee` where `id`=? AND `password`=? AND `Terminationid` IS NULL LIMIT 1");
		ps.setString(1, user);		
		ps.setString(2, pwd);
		rs = ps.executeQuery();
		if (rs.next()) {
			status = true;
		} else {
			status = false;
		}
		return status;		
	}
}
