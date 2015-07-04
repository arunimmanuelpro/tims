<%@page import="mailing.SendMail"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%
	String mailid = request.getParameter("mailid");	
	String email [] = mailid.split(";");	
	String cc = request.getParameter("cc");	
	String emailcc [] = cc.split(";");	
	String bcc = request.getParameter("bcc");	
	String emailbcc [] = bcc.split(";");	
	String sub = request.getParameter("sub");	
	String msg = request.getParameter("msg");	
	if(SendMail.sendBulkMail(email, sub, msg,emailcc,emailbcc)){
		out.println(1);
	}else{
		out.println(0);
	}
%>