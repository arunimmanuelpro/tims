<%@page import="java.sql.PreparedStatement"%>
<%@page import="access.DbConnection"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%
Connection con = DbConnection.getConnection();
String rowno = request.getParameter("rowno");

String [] row = rowno.split(",");
try{
for(int i = 0;i<row.length;i++){
	
PreparedStatement ps = con.prepareStatement("delete from timesheetmaster where id = ?");
ps.setInt(1, Integer.parseInt(row[i]));
ps.executeUpdate();


}

out.println("Success");
}catch(Exception e){
	out.println("Failed");	
}
%>



<%
con.close();
%>