<%@page import="java.sql.PreparedStatement"%>
<%@page import="access.DbConnection"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%
	Connection con = DbConnection.getConnection();
	PreparedStatement ps = con.prepareStatement("update coursedetails set Name=?,Description = ?,Duration = ?, Fees=? where Name =?");
	ps.setString(1,request.getParameter("course"));
	ps.setString(2,request.getParameter("desc"));
	ps.setInt(3, Integer.parseInt(request.getParameter("duration")));
	ps.setInt(4, Integer.parseInt(request.getParameter("fees")));
	ps.setString(5,request.getParameter("course"));
	int suc = ps.executeUpdate();
	if(suc>0){
		out.println("Course Updated Successfully");
	}else{
		out.println("Try again Later");
	}
	ps.close();
	con.close();
%>