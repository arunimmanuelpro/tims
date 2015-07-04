<%@page import="general.ActivityLog"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="access.DbConnection"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%
String name = request.getParameter("name");
String value = request.getParameter("value");
String start = request.getParameter("startdate");
String end = request.getParameter("enddate");

if(name==null || value==null || start==null || end==null){
	out.print("33");
}else{
	if(name.isEmpty() || value.isEmpty() || start.isEmpty() || end.isEmpty()){
		out.print("22");
	}else{
		//Actual Processing
		String empid = request.getAttribute("userid").toString();
		Connection con = DbConnection.getConnection();
		PreparedStatement ps = con.prepareStatement("INSERT INTO `coupons`(`name`, `value`, `startdate`, `enddate`) VALUES (?,?,?,?)");
		ps.setString(1, name);
		ps.setString(2, value);
		ps.setString(3, start);
		ps.setString(4, end);
		int res = ps.executeUpdate();
		if(res > 0){
			out.print("1");
			String user = request.getAttribute("userid").toString();
			ActivityLog.log("New Coupon "+name+" has been created.","NEW",user);
		}else
			out.print("0");
		//Actual End
	}
}
%>