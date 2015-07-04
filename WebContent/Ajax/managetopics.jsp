<%@page import="java.sql.PreparedStatement"%>
<%@page import="access.DbConnection"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%
	System.out.println("Reach here..");
	String process = request.getParameter("p");	
	Connection con = DbConnection.getConnection();
	PreparedStatement ps = null;
	if(process.equals("1")){		
		ps = con.prepareStatement("INSERT INTO `coursetopics`(`courseid`, `subtitle`, `topic`, `duration`, `order`, `updationdate`) VALUES (?,?,?,?,?,now())");
		ps.setString(1, request.getParameter("cid"));
		ps.setString(2, request.getParameter("stitle"));
		ps.setString(3, request.getParameter("topic"));
		ps.setString(4, request.getParameter("duration"));
		ps.setString(5, request.getParameter("order"));
		int suc = ps.executeUpdate();
		if(suc>0){
			out.println("Topic Updated Successfully");
		}else{
			out.println("Try again Later");
		}
	}else if(process.equals("2")){
		ps = con.prepareStatement("UPDATE `coursetopics` SET `subtitle`=?,`topic`=?,`duration`=?,`order`=?,`updationdate`=now() WHERE `id`=?");
		ps.setString(1, request.getParameter("stitle"));
		ps.setString(2, request.getParameter("topic"));
		ps.setString(3, request.getParameter("duration"));
		ps.setString(4, request.getParameter("order"));
		ps.setString(5, request.getParameter("topicid"));
		int suc = ps.executeUpdate();
		if(suc>0){
			out.println("Topic Added Successfully");
		}else{
			out.println("Try again Later");
		}
	}else if(process.equals("3")){
		System.out.println("Reach here..");
		ps = con.prepareStatement("DELETE FROM `coursetopics` WHERE `id`=?");
		ps.setString(1, request.getParameter("topicid"));
		int suc = ps.executeUpdate();
		if(suc>0){
			out.println("Topic Removed Successfully");
		}else{
			out.println("Try again Later");
		}
	}
	ps.close();
	con.close();
%>