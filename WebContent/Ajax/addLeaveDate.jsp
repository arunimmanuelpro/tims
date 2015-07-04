<%@page import="java.sql.PreparedStatement"%>
<%@page import="access.DbConnection"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%
	String indi = request.getParameter("rindicator");
	int indicator=1;
	if(indi==null||indi.isEmpty()){
		indicator=0;
	}
	Connection con = DbConnection.getConnection();
	PreparedStatement ps = con.prepareStatement("insert into holiday(hname,hdate,htype,repeatindicator,updationdate) values(?,?,?,?,now())");
	ps.setString(1, request.getParameter("hname"));
	ps.setString(2, request.getParameter("hdate"));
	ps.setString(3, request.getParameter("htype"));
	ps.setInt(4, indicator);	
	/* ps.setString(5, request.getParameter("location")); */
	int suc = ps.executeUpdate();
	ps.close();
	con.close();
	if(suc>0){
		out.println("1");
	}else{
		out.println("0");
	}	
%>