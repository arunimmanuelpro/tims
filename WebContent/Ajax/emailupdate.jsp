<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="access.DbConnection"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%
int id = Integer.parseInt(request.getParameter("id"));
String name = request.getParameter("name");
String email = request.getParameter("email");
String oldpass = request.getParameter("oldpass");
String newpass = request.getParameter("newpass");
Connection con = DbConnection.getConnection();
PreparedStatement ps = con.prepareStatement("select * from emailaccounts where id = ?");
ps.setInt(1, id);
ResultSet rs = ps.executeQuery();
if(rs.next()){

	if(!(rs.getString("password").equals(oldpass))){
		response.sendRedirect(request.getContextPath()+"/Management/editemail.jsp?id="+id+"&msg=Invalid Old Password");
	}else{
		ps = con.prepareStatement("update emailaccounts set ename = ?,email = ?,password = ? where id = ?");
		ps.setString(1, name);
		ps.setString(2, email);
		ps.setString(3, newpass);
		ps.setInt(4, id);
		ps.executeUpdate();
		response.sendRedirect(request.getContextPath()+"/Management/emailpassword.jsp?msg=Email Updated Successfully");
	}
}
con.close();
%>