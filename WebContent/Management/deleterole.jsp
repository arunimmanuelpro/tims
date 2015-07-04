<%@page import="java.sql.ResultSet"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="access.DbConnection"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%
	String name = request.getParameter("role");
	if (name != null) {

		if (name.isEmpty()) {
			out.print("Invalid Values");
			response.sendRedirect("AccessRoles.jsp?msg=Oops Invalid Data");
			return;
		} else {

			int roleid = Integer.parseInt(name);
			
			if(roleid==1 || roleid==2 || roleid==3 || roleid==4){
				response.sendRedirect("AccessRoles.jsp?msg=Default Roles cannot be removed");
				return;
			}
			
			//Actual Processing
			Connection con = DbConnection.getConnection();
			PreparedStatement ps = con.prepareStatement(
					"DELETE FROM `roles` WHERE `roles`.`role_id` = ?");
			ps.setString(1, name);
			int res = ps.executeUpdate();
			
			ps = con.prepareStatement(
					"DELETE FROM `role_perm` WHERE `role_id` = ?");
			ps.setString(1, name);
			int res2 = ps.executeUpdate();
			//Actual End
			response.sendRedirect("AccessRoles.jsp?msg=Role Deleted Successfully");
			return;
		}
	} else {
		out.print("Invalid Access");
		response.sendRedirect("AccessRoles.jsp?msg=No Access");
	}
%>