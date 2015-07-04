<%@page import="general.ActivityLog"%>
<%@page import="general.BatchSchedule"%>
<%@page import="access.DbConnection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%
String res = "";
String Session = request.getParameter("Session");

boolean ok = true;

if(Session==null){
	out.print(22);
	ok = false;
}
if(ok){
	
	int Courseid = Integer.parseInt(request.getParameter("Course"));	
	String Type = request.getParameter("Type");
	String sdate = request.getParameter("sdate");
	int Trainerid = Integer.parseInt(request.getParameter("Trainer"));
	int HrsPerday = Integer.parseInt(request.getParameter("Hours"));
	
	Connection c = DbConnection.getConnection();
	Statement s = c.createStatement();
	String sql = "SELECT * FROM coursedetails where `id`='"+Courseid+"' LIMIT 1";
	ResultSet rs = s.executeQuery(sql);
	int duration = 0;
	if(rs.next()){
		duration = rs.getInt("duration");
		BatchSchedule bs = new BatchSchedule();
		String useridd = request.getAttribute("userid").toString();
		res = bs.CreateSchedule(sdate, Type, duration, Trainerid, Session, Courseid, useridd, HrsPerday);
	}else{
		out.println("CourseNotfound");
	}
	if(res.equalsIgnoreCase("ALL_OK")){
		out.print(1);
		String user = request.getAttribute("userid").toString();
		ActivityLog.log("New Batch was Created Successfully","NEW",user);
	}else{
	out.print(res);
	}
}else{
	out.print("InvalidAccess");
}
%>