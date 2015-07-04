<%@page import="java.sql.PreparedStatement"%>
<%@page import="access.DbConnection"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%
	Connection con = DbConnection.getConnection();
	PreparedStatement ps = con.prepareStatement("insert into coursedetails (Name,Description,Duration, Fees) values(?,?,?,?)");
	ps.setString(1,request.getParameter("course"));
	ps.setString(2,request.getParameter("desc"));
	ps.setInt(3, Integer.parseInt(request.getParameter("duration")));
	ps.setInt(4, Integer.parseInt(request.getParameter("fees")));	
	int suc = ps.executeUpdate();
	if(suc>0){
		out.println("Course Added Successfully");
	}else{
		out.println("Try again Later");
	}
	ps.close();
	con.close();
%>