<%@page import="general.GetInfoAbout"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="access.DbConnection"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%
	String payroll = request.getParameter("pr");
	if (payroll == null) {
		out.print("Error");
	} else {
		if (payroll.isEmpty()) {
			out.print("Invalid data");
		} else {
			//Operation
			Connection con = DbConnection.getConnection();
			Statement s = con.createStatement();
			String sql = "SELECT * FROM `payroll_info` WHERE `my` = '"
					+ payroll + "'";

			ResultSet rss = s.executeQuery(sql);
			while (rss.next()) {
				out.print("<tr>");
				out.print("<td>" + rss.getString("id") + "</td>");
				out.print("<td>" + rss.getString("empid") + "</td>");
				out.print("<td>"
						+ GetInfoAbout.gettrainername(rss
								.getString("empid")) + "</td>");
				out.print("<td>" + rss.getString("payroll_status")
						+ "</td>");
				out.print("<td>" + rss.getString("payslip_status")
						+ "</td>");
				if (rss.getString("payroll_status").equalsIgnoreCase(
						"PENDING")) {
%>
<td><a href="process.jsp?id=<%=rss.getString("id")%>"> <i
		class="icon-signin"></i></a></td>
<%
	} else if (rss.getString("payroll_status")
						.equalsIgnoreCase("COMPLETED") && rss.getString("payslip_status")
						.equalsIgnoreCase("NOT GENERATED")) {
%>
<td><a
	href="../Ajax/generatePaySlip.jsp?id=<%=rss.getString(1)%>&eid=<%=rss.getInt("empid")%>"><i
		class="icon-expand"></i></a></td>
<%
	} else if (rss.getString("payroll_status")
			.equalsIgnoreCase("COMPLETED") && rss.getString("payslip_status")
			.equalsIgnoreCase("GENERATED")) {%>
		<td><a href="payslip.jsp?id=<%=rss.getString(1)%>&emid=<%=rss.getInt("empid")%>"><i
		class="btn btn-success">View Pay slip</i></a></td><%
	}

				out.print("</tr>");
			}
		}
	}
%>