<%@page import="java.util.UUID"%>
<%@page import="security.SecureNew"%>
<%@page import="mailing.SendMail"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="general.ActivityLog"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="access.DbConnection"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%
	String email = request.getParameter("mobile");

	if (email == null) {
		out.print("33");
	} else {
		if (email.isEmpty()) {
			out.print("22");
		} else {
			//Actual Processing
			SecureNew sn = new SecureNew();
			Connection con = DbConnection.getConnection();
			Statement ps = con.createStatement();
			String sql = "SELECT `WorkEmail` FROM `employee` WHERE `Mobile`='"
					+ email + "'";
			ResultSet rs = ps.executeQuery(sql);
			
			if (rs.next()) {
				String o_email = sn.decrypt(rs.getString(1));
				
				String usekey = UUID.randomUUID().toString();
				
				String uu = usekey.substring(0, 3);
				
				String sql1 = "UPDATE `employee` SET `password`='TIM@"+uu+"' WHERE `Mobile`='"+ email + "'";
				ps = con.createStatement();
				int ress = ps.executeUpdate(sql1);
				if(ress > 0){
					String htmlBody = "<h2>TIMS BRAIN</h2><br>Your New Password is : TIM@"+uu+" ";
					String subject = "Your New Password for TIMS BRAIN";
					SendMail.sendmail(o_email, subject, htmlBody);	
					response.sendRedirect("index.jsp?msg=Change Successful");
					return;
				}

			} else {
				out.print("No User Found");
				response.sendRedirect("index.jsp?msg=No user Found");
				return;
			}
		}
	}
%>