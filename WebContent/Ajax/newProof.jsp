<%@page import="general.ActivityLog"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="access.DbConnection"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%
String type = request.getParameter("type");
String num = request.getParameter("number");
String val = request.getParameter("validupto");

if(type==null || num==null){
	out.print("33");
}else{
	if(type.isEmpty() || num.isEmpty()){
		out.print("22");
	}else if(val.isEmpty()){
		//Actual Processing
		
		String empid = request.getAttribute("userid").toString();
		
		Connection con = DbConnection.getConnection();
		PreparedStatement ps = con.prepareStatement("INSERT INTO `proof`( `empid`, `type`, `number`) VALUES (?,?,?)");
		ps.setString(1, empid);
		ps.setString(2, type);
		ps.setString(3, num);		

		int res = ps.executeUpdate();
		if(res > 0){
			out.print("1");
			String user = request.getAttribute("userid").toString();
			ActivityLog.log("New Proof "+type+" has been added by emp id :"+empid,"NEW",user);
		}else
			out.print("0");
		//Actual End
	}
	else{
		//Actual Processing
		
		String empid = request.getAttribute("userid").toString();
		
		Connection con = DbConnection.getConnection();
		PreparedStatement ps = con.prepareStatement("INSERT INTO `proof`( `empid`, `type`, `number`, `validupto`) VALUES (?,?,?,?)");
		ps.setString(1, empid);
		ps.setString(2, type);
		ps.setString(3, num);
		ps.setString(4, val);

		int res = ps.executeUpdate();
		if(res > 0){
			out.print("1");
			String user = request.getAttribute("userid").toString();
			ActivityLog.log("New Proof "+type+" has been added by emp id :"+empid,"NEW",user);
		}else
			out.print("0");
		//Actual End
	}
}
%>