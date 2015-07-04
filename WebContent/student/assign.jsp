<%@page import="java.sql.PreparedStatement"%>
<%@page import="access.DbConnection"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%
	String name = request.getParameter("batchid");
	String stid = request.getParameter("stid");

	if (name == null || stid == null) {
		out.print("33");
	} else {
		if (name.isEmpty() || stid.isEmpty()) {
			out.print("22");
		} else {
			//Actual Processing
			String empid = request.getAttribute("userid").toString();
			Connection con = DbConnection.getConnection();
			PreparedStatement ps = con
					.prepareStatement("UPDATE `students` SET `status`='INPROGRESS',`batchid`=? WHERE `id`=?");
			ps.setString(1, name);
			ps.setString(2, stid);
			int res = ps.executeUpdate();
			if (res > 0) {
				out.print("1");
				response.sendRedirect(request.getHeader("referer")
						+ "&msg=BATCH UPDATED SUCCESSFULLY");
			} else {
				out.print("0");
				response.sendRedirect(request.getHeader("referer")
						+ "&msg=BATCH UPDATE ERROR");
			}
			//Actual End
		}
	}
%>