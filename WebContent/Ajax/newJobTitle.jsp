<%@page import="general.ActivityLog"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="access.DbConnection"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%
String name = request.getParameter("title");
String value = request.getParameter("description");
String range = request.getParameter("payrange");

if(name==null || value==null || range==null ){
	out.print("33");
}else{
	if(name.isEmpty() || value.isEmpty() || range.isEmpty()){
		out.print("22");
	}else{
		//Actual Processing
		Connection con = DbConnection.getConnection();
		PreparedStatement ps = con.prepareStatement("INSERT INTO `jobtitles`(`Title`, `Description`, `PayRange`) VALUES (?,?,?)");
		ps.setString(1, name);
		ps.setString(2, value);
		ps.setString(3, range);
		int res = ps.executeUpdate();
		if(res > 0){
			out.print("1");
			String user = request.getAttribute("userid").toString();
			ActivityLog.log("New Job Title "+name+" has been created.","NEW-ADMIN",user);
		}else
			out.print("0");
		//Actual End
	}
}
%>