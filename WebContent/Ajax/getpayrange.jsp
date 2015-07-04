<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="access.DbConnection"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%
	int roleid = Integer.parseInt(request.getParameter("roleid"));
	String level = request.getParameter("level");
	//System.out.println("Role ID: "+roleid+" Level: "+level);
	Connection con = DbConnection.getConnection();
	Statement s = con.createStatement();
	s = con.createStatement();
	String csql = "SELECT "+level+" FROM `roles` where role_id="+roleid;
	//System.out.println("Payrange Query: "+csql);
	ResultSet rs = s.executeQuery(csql);
	if(rs.next())
	    out.println(rs.getString(1));
	rs.close();
	s.close();
	con.close();
%>