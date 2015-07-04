<%@page import="security.SecureNew"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="general.ActivityLog"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="access.DbConnection"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%
	String from = request.getParameter("from");
	String to = request.getParameter("to");
	String empid = request.getParameter("userid");

	if (from == null || to == null || empid == null) {
		out.print("33");
	} else {
		if (from.isEmpty() || to.isEmpty() || empid.isEmpty()) {
			out.print("22");
		} else {

			Connection con = DbConnection.getConnection();
			Statement ps = con.createStatement();
			String sql = "SELECT * FROM `attendance` WHERE `Date`>'"
					+ from
					+ "' AND `Date`<'"
					+ to
					+ "' AND `empid`="
					+ empid
					+ " AND `TotalMinutes` IS NOT NULL ORDER BY `Date` ASC";

			ResultSet rs = ps.executeQuery(sql);
			if (rs.next()) {
%>
<section class="panel">
	<header class="panel-heading"> Attendance Log from </header>
	<div class="list-group">
		<%
			SecureNew sn = new SecureNew();
						long totalminutes = 0;
						while (rs.next()) {
		%>
		<a class="list-group-item" href="javascript:;"><span
			class="label label-info"><%=rs.getString("Date") %></span> - <%
			String tot_min = rs.getString("TotalMinutes");
							int tm = Integer.parseInt(sn.decrypt(tot_min));
							totalminutes = totalminutes + tm;
							out.print(tm);
		%>
			Minutes</a>
		<%
			}
		%>
		<a class="list-group-item" href="javascript:;"><span
			class="label label-warning label-lg">Total Minutes for range :</span><span
			class="label label-info"><b><%=totalminutes %></b></span></a> 
	</div>
</section>
<%
	} else {
				out.print("Sorry No Attendance Logs Found");
			}
		}
	}
%>