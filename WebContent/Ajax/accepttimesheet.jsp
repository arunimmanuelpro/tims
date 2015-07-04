<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="access.DbConnection"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%
int touser = Integer.parseInt(request.getParameter("touser"));
String fromdate = request.getParameter("fromdate");
String todate = request.getParameter("todate");
String status =request.getParameter("status");
String comment = request.getParameter("comment");
Connection con = DbConnection.getConnection();
PreparedStatement ps = con.prepareStatement("update timesheetmaster set status = ? where empid = ? and fromdate =? and todate = ?");
ps.setString(1, status);
ps.setInt(2, touser);
ps.setString(3, fromdate);
ps.setString(4, todate);
ps.executeUpdate();

ps = con.prepareStatement("insert into timesheetlog (empid,fromdate,todate,status,comment,updatedby) values (?,?,?,?,?,?)");
ps.setInt(1, touser);
ps.setString(2, fromdate);
ps.setString(3, todate);
ps.setString(4, status);
ps.setString(5, comment);
ps.setString(6, "Admin");
ps.executeUpdate();

out.println("Timesheet "+status);
%>