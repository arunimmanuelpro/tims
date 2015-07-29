<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="access.DbConnection"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%
String name = request.getParameter("batchid");
String stid = request.getParameter("stid");
int cid = Integer.parseInt(request.getParameter("cid"));
	if (name == null || stid == null) {
		out.print("33");
	} else {
		if (name.isEmpty() || stid.isEmpty()) {
			out.print("22");
		} else {
			//Actual Processing
			String empid = request.getAttribute("userid").toString();
			Connection con = DbConnection.getConnection();
			PreparedStatement p = con.prepareStatement("select * from studentcourse where courseid = ? and studid = ?");
			p.setInt(1,cid);
			p.setInt(2, Integer.parseInt(stid));
			ResultSet r = p.executeQuery();
			if(r.next()){
			PreparedStatement ps = con
					.prepareStatement("UPDATE `studentcourse` SET `status`='INPROGRESS',`batchid`=?,`courseid`=? WHERE `id`=?");
			ps.setInt(1, Integer.parseInt(name));
			ps.setInt(2, cid);
			ps.setInt(3, r.getInt(1));
			System.out.println(ps);
			int res = ps.executeUpdate();
			ps = con
					.prepareStatement("UPDATE `students` SET `status`='INPROGRESS' WHERE `id`=?");
			ps.setString(1, stid);
			System.out.println(ps);
			ps.executeUpdate();
			if (res > 0) {
				out.print("1");
				response.sendRedirect(request.getHeader("referer")
						+ "&msg=BATCH UPDATED SUCCESSFULLY");
			} else {
				out.print("0");
				response.sendRedirect(request.getHeader("referer")
						+ "&msg=BATCH UPDATE ERROR");
			}
			}else{
				out.print("0");
				response.sendRedirect(request.getHeader("referer")
						+ "&msg=BATCH UPDATE ERROR");
			}
			//Actual End
		}
	}
%>