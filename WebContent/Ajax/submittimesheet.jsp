<%@page import="java.sql.PreparedStatement"%>
<%@page import="access.DbConnection"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%
Connection con = DbConnection.getConnection();
String fromdate = request.getParameter("from");
String todate = request.getParameter("todate");
try{
PreparedStatement ps = con.prepareStatement("update timesheetmaster set status = ? where empid = ? and fromdate = ? and todate = ? ");
ps.setString(1, "Waiting");
ps.setInt(2, (Integer) session.getAttribute("id"));
ps.setString(3, fromdate);
ps.setString(4, todate);
ps.executeUpdate();
out.println("Time Sheet Submitied for Review");

}catch(Exception e){
	out.println("Error  in Submiting Time sheet "+e);
}
%>



<%
con.close();
%>