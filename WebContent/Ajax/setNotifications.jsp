<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="general.ActivityLog"%>
<%@page import="java.sql.Statement"%>
<%@page import="access.DbConnection"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%
	String id = request.getParameter("id");

	if (id == null) {
		out.print("33");
	} else {
		if (id.isEmpty()) {
			out.print("22");
		} else {
			Connection con = DbConnection.getConnection();
			Statement ps1 = con.createStatement();
			String sql = "SELECT * FROM `notifications` WHERE `id`='"+ id + "' LIMIT 1";
			ResultSet rs = ps1.executeQuery(sql);
			PreparedStatement ps = con
					.prepareStatement("UPDATE `notifications` SET `read`=? WHERE `id`=?");
			ps.setString(2, id);
			rs.next();
			if (rs.getBoolean("read") == true) {
				ps.setBoolean(1, false);
			} else {
				ps.setBoolean(1, true);
			}

			int res = ps.executeUpdate();
			if (res > 0) {
				out.print("1");
			} else
				out.print("0");
			
			con.close();
		}
		
	}
%>