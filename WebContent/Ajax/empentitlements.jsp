<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="access.DbConnection"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>    
<%
	int days = Integer.parseInt(request.getParameter("days"));
	int empid = Integer.parseInt(request.getParameter("empid"));
	String fromdate = request.getParameter("fdate");
	String todate = request.getParameter("tdate");
	if(fromdate==null||todate==null||fromdate.isEmpty()||todate.isEmpty()){
		out.println("Please select From date & To date");
	}else{
		Connection con = DbConnection.getConnection();
		PreparedStatement ps = con.prepareStatement("select * from leavepolicy where empid = ?");
		ps.setInt(1, empid);
		ResultSet rs = ps.executeQuery();
		if(rs.next()){
			ps =con.prepareStatement("update leavepolicy set noofdays = ?, frompriod=?, topriod=?, adminid=?, updationdate=curdate() where empid = ?");
			ps.setInt(1, days);
			ps.setString(2, fromdate);
			ps.setString(3, todate);
			ps.setInt(4,(Integer)session.getAttribute("id"));	
			ps.setInt(5, empid);
			ps.executeUpdate();
			out.println("Updated Successfully");
		}else{
			PreparedStatement ps2 = con.prepareStatement("insert into leavepolicy (empid,noofdays,frompriod,topriod,adminid,creationdate,updationdate) values(?,?,?,?,?,curdate(),curdate())");	
			ps2.setInt(1, empid);
			ps2.setInt(2, days);
			ps2.setString(3, fromdate);
			ps2.setString(4, todate);
			ps2.setInt(5,(Integer)session.getAttribute("id"));	
			ps2.executeUpdate();
			out.println("Added Successfully");
		}
		con.close();
	}
%>