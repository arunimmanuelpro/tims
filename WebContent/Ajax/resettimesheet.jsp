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
PreparedStatement ps = con.prepareStatement("delete from timesheetmaster  where empid = ? and fromdate = ? and todate = ? ");

ps.setInt(1, (Integer) session.getAttribute("id"));
ps.setString(2, fromdate);
ps.setString(3, todate);
ps.executeUpdate();
out.println("Time Sheet Reset Successfull");

}catch(Exception e){
	out.println("Error  in Resetting Time sheet "+e);
}
%>



<%
con.close();
%>