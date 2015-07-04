<%@page import="general.ActivityLog"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="access.DbConnection"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%
String name = request.getParameter("name");
String value = request.getParameter("courseid");

if(name==null || value==null ){
	out.print("33");
}else{
	if(name.isEmpty() || value.isEmpty()){
		out.print("22");
	}else{
		//Actual Processing
		String empid = request.getAttribute("userid").toString();
		Connection con = DbConnection.getConnection();
		PreparedStatement ps = con.prepareStatement("INSERT INTO `certificates`( `name`, `courseid`) VALUES (?,?)");
		ps.setString(1, name);
		ps.setString(2, value);
		int res = ps.executeUpdate();
		if(res > 0){
			out.print("1");
			String user = request.getAttribute("userid").toString();
			ActivityLog.log("New Certificate "+name+" was added","NEW",user);
		}else
			out.print("0");
		//Actual End
	}
}
%>