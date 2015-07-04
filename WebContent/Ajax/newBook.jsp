<%@page import="general.ActivityLog"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="access.DbConnection"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%
String name = request.getParameter("name");
String publish = request.getParameter("publisher");
String cid = request.getParameter("courseid");

if(name==null || publish==null || cid==null){
	out.println("33");
}else{
	if(name.isEmpty() || publish.isEmpty() || cid.isEmpty()){
		out.print("22");
	}else{
		//Actual Processing
		
		String courseid = request.getAttribute("userid").toString();
		
		Connection con = DbConnection.getConnection();
		PreparedStatement ps = con.prepareStatement("INSERT INTO `books`(`name`, `publisher`, `courseid`) VALUES (?,?,?)");
		ps.setString(1, name);
		ps.setString(2, publish);
		ps.setString(3, cid);

		int res = ps.executeUpdate();
		if(res > 0){
			out.print("1");
			String user = request.getAttribute("userid").toString();
			ActivityLog.log("New Book "+name+" was Added to Store","NEW",user);
		}else
			out.print("0");
		//Actual End
	}
}
    
    
    
    
%>