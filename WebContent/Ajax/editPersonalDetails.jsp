<%@page import="general.ActivityLog"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="access.DbConnection"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%
String fname = request.getParameter("FirstName");
String lname = request.getParameter("LastName");
String gender = request.getParameter("gender");
String mstatus = request.getParameter("MaritalStatus");
String dob = request.getParameter("dob");
String nation = request.getParameter("Nationality");
String bgroup = request.getParameter("Bloodgroup");


if(fname==null || lname==null || gender==null  || mstatus==null  || dob==null || nation==null || bgroup==null){
	out.print("33");
}else{
	if(fname.isEmpty() || lname.isEmpty() || gender.isEmpty() || mstatus.isEmpty() || dob.isEmpty() || nation.isEmpty() || bgroup.isEmpty()){
		out.print("22");
	}else{
		//Actual Processing
		
		String empid = session.getAttribute("editEmpId").toString();
		
		Connection con = DbConnection.getConnection();
		PreparedStatement ps = con.prepareStatement("UPDATE employee SET FirstName=?, LastName=?, Gender=?, MaritalStatus=?, DateofBirth=?, Nationality=?,Bloodgroup=? WHERE id=?");
		ps.setString(1, fname);
		ps.setString(2, lname);
		ps.setString(3, gender);
		ps.setString(4, mstatus);
		ps.setString(5, dob);
		ps.setString(6, nation);
		ps.setString(7, bgroup);
		ps.setString(8, empid);
		int res = ps.executeUpdate();
		if(res > 0){
			out.print("1");
			String user = request.getAttribute("userid").toString();
			ActivityLog.log("Employee "+user+"`s Personal Details has been Updated","UPDATE",user);
		}else
			out.print("0");
		//Actual End
	}
}
%>