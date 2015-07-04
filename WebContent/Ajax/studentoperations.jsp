<%@page import="general.ActivityLog"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="access.DbConnection"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%
	String id = request.getParameter("id");
	String sid = request.getParameter("sid");
	String o = request.getParameter("o");
	SimpleDateFormat dt = new SimpleDateFormat("yyyy-MM-dd");
	Date today = new Date();
	String todayd = dt.format(today);
	if (id != null || sid != null || o !=null) {
		if (id.isEmpty() || sid.isEmpty() || o.isEmpty()) {
	out.println("22");
		} else {
	if(o.equalsIgnoreCase("books")){
	Connection con = DbConnection.getConnection();
	PreparedStatement s = con
			.prepareStatement("INSERT INTO student_books(`studentid`,`date`,`bookid`,`empid`)VALUES(?,?,?,?)");
	s.setString(1, sid);
	s.setString(2, todayd);
	s.setString(3, id);
	s.setString(4, request.getAttribute("userid").toString());
	int res = s.executeUpdate();
	
	if (res > 0) {
		out.println("1");
		String user = request.getAttribute("userid").toString();
		ActivityLog.log("New Book has been issued to Student.","UPDATE",user);
		response.sendRedirect(request.getHeader("referer")+"&msg=Books Issued");
	} else {
		out.println("0");
	}
	}
	if(o.equalsIgnoreCase("certificates")){
		Connection con = DbConnection.getConnection();
		PreparedStatement s = con
				.prepareStatement("INSERT INTO students_certificate(`studentid`,`date`,`certificateid`,`empid`)VALUES(?,?,?,?)");
		s.setString(1, sid);
		s.setString(2, todayd);
		s.setString(3, id);
		s.setString(4, request.getAttribute("userid").toString());
		int res = s.executeUpdate();

		if (res > 0) {
			out.println("1");
			String user = request.getAttribute("userid").toString();
			ActivityLog.log("New Certificate has been issued to Student.","UPDATE",user);
			response.sendRedirect(request.getHeader("referer")+"&msg=Certificates Issued");
		} else {
			out.println("0");
		}
		}

		}
	} else {
		out.println("33");
	}
%>