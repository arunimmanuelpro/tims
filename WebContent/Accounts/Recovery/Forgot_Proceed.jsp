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
	String email = request.getParameter("email");
String empid = request.getParameter("empid");

	if (email == null || empid == null) {
		out.print("33");
	} else {
		if (email.isEmpty() || empid.isEmpty()) {
			out.print("22");
		} else {
			//Actual Processing
			SecureNew sn = new SecureNew();
			Connection con = DbConnection.getConnection();
			Statement ps;
				String o_email = email;
				
				String usekey = UUID.randomUUID().toString();
				
				String uu = usekey.substring(0, 3);
				
				String sql1 = "UPDATE `employee` SET `password`='TIM@"+uu+"' WHERE `id`='"+ empid + "'";
				ps = con.createStatement();
				int ress = ps.executeUpdate(sql1);
				if(ress > 0){
					String htmlBody = "<h2>TIMS BRAIN</h2><br>Your New Password is : TIM@"+uu+" ";
					String subject = "Your New Password for TIMS BRAIN";
					SendMail.sendmail(o_email, subject, htmlBody);	
					response.sendRedirect(request.getContextPath() +"/index.jsp?msg=Password Change Successful. Check Email");
					return;
				}else{
					response.sendRedirect(request.getContextPath() +"/index.jsp?msg=Error During Change, Try Again");
					return;
				}
		}
	}
%>