<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="access.DbConnection"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%
int cid = Integer.parseInt(request.getParameter("cname"));
int amt = Integer.parseInt(request.getParameter("fees"));
int sid = Integer.parseInt(request.getParameter("sid"));

Connection con = DbConnection.getConnection();
PreparedStatement ps = con.prepareStatement("insert into studentcourse(studid,courseid,fees,batchid,status) values(?,?,?,?,?)");
ps.setInt(1, sid);
ps.setInt(2, cid);
ps.setInt(3, amt);
ps.setInt(4, 0);
ps.setString(5, null);
int rs = ps.executeUpdate();
if(rs>0){
	out.println(1);
}else{
	out.println(33);
}
con.close();
%>