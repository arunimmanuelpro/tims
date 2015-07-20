<%@page import="java.util.LinkedList"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="access.DbConnection"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<% Connection con = DbConnection.getConnection();
List<Integer> month = new LinkedList<Integer>();
int year  = Integer.parseInt(request.getParameter("year"));
PreparedStatement ps = con.prepareStatement("SELECT DISTINCT month from empattendance where year = ?");
ps.setInt(1, year);
ResultSet rs = ps.executeQuery();
while(rs.next()){
	month.add(rs.getInt("month"));
}
con.close();
%>