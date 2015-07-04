<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%
	HttpSession s1 = request.getSession();
	s1.invalidate();
	response.sendRedirect(request.getContextPath()+"/index.jsp?msg=Logout_Success");
%>