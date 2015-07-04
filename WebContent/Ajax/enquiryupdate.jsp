<%@page import="general.ActivityLog"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="access.DbConnection"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%
	String id = request.getParameter("id");	
	String name = request.getParameter("name");
	String email = request.getParameter("email");
	String qualification = request.getParameter("qualification");
	String designation = request.getParameter("designation");
	String currentlyin = request.getParameter("currentlyin");
	String homephone = request.getParameter("homephone");
	String address = request.getParameter("address");
	
	if (name == null) {
		out.print("Sorry. Invalid Access");
	} else {
		if (name.isEmpty()) {
			out.print("Sorry. Fill all Fields.");
		} else {
			//Actual Processing
			
			Connection con = DbConnection.getConnection();
			Statement s = con.createStatement();
			String sql = "UPDATE  `enquiry` SET  `name` =  '"+name+"',`email` =  '"+email+"',`qualification` =  '"+qualification+"',	`stream` =  '"+designation+"',`currentlyin` =  '"+currentlyin+"',`homephone` =  '"+homephone+"',`address` =  '"+address+"' WHERE `id` = '"+id+"';";
			int res = s.executeUpdate(sql);
			if (res > 0) {
				out.print("Update Success");
				String user = request.getAttribute("userid").toString();
				ActivityLog.log("Details of Enquiry "+id+" was updated","UPDATE",user);
			} else {
				out.print("Error Adding Enquiry. Please Try Again");
				//Actual End
			}
		}
	}
%>