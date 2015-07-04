<%@page import="java.sql.PreparedStatement"%>
<%@page import="access.DbConnection"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%
String cid = request.getParameter("courseid");
String topic = request.getParameter("topic");
String order = request.getParameter("order");

if(cid==null || topic==null || order==null){
	out.print("33");
}else{
	if(cid.isEmpty() || topic.isEmpty() || order.isEmpty()){
		out.print("22");
	}else{
		//Actual Processing
		
		Connection con = DbConnection.getConnection();
		PreparedStatement ps = con.prepareStatement("INSERT INTO `coursetopics`(`courseid`, `topic`, `order`) VALUES (?,?,?)");
		ps.setString(1, cid);
		ps.setString(2, topic);
		ps.setString(3, order);

		int res = ps.executeUpdate();
		if(res > 0){
			out.print("1");
			
		}else
			out.print("0");
		//Actual End
	}
}
%>