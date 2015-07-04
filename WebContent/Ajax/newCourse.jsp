<%@page import="general.ActivityLog"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="access.DbConnection"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%
String name = request.getParameter("name");
String des = request.getParameter("description");
String duration = request.getParameter("duration");
String fees = request.getParameter("fees");

if(name==null || des==null || duration==null  || fees==null){
	out.print("33");
}else{
	if(name.isEmpty() || des.isEmpty() || duration.isEmpty() || fees.isEmpty()){
		out.print("22");
	}else{
		//Actual Processing
		
		String courseid = request.getAttribute("userid").toString();
		
		Connection con = DbConnection.getConnection();
		PreparedStatement ps = con.prepareStatement("INSERT INTO `coursedetails`(`Name`, `Description`, `Duration`, `Fees`) VALUES (?,?,?,?)");
		ps.setString(1, name);
		ps.setString(2, des);
		ps.setString(3, duration);
		ps.setString(4, fees);
		int res = ps.executeUpdate();
		if(res > 0){
			out.print("1");
			String user = request.getAttribute("userid").toString();
			ActivityLog.log("New Course "+name+" has been created","NEW",user);
		}else
			out.print("0");
		//Actual End
	}
}


%>