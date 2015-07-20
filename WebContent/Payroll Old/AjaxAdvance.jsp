<%@page import="general.GetInfoAbout"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="access.DbConnection"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%
	String advance = request.getParameter("pr");
	if (advance == null) {
		out.print("Error");
	} else {
		if (advance.isEmpty()) {
			out.print("Invalid data");
		} else {
			//Operation
			Connection con = DbConnection.getConnection();
			Statement s = con.createStatement();
			String sql = "SELECT * FROM `advance` WHERE `my` = '"
					+ advance + "'";

			ResultSet rss = s.executeQuery(sql);
			while (rss.next()) {
				int adv = Integer.parseInt(GetInfoAbout.getbasicpay(rss.getString("empid")));
				float advamt = adv*0.3f;
				int adv_amt = (int)advamt;
				out.print("<tr>");
				out.print("<td>" + "<input type= hidden value= '"+ rss.getString("id") +"'>" +  "</td>");
				out.print("<td>"+rss.getString("empid")+"</td>");
				out.print("<td>"+ GetInfoAbout.gettrainername(rss.getString("empid")) + "</td>");
				out.print("<td>" + adv_amt + "</td>");
				out.print("<td>"+(rss.getString("adv_amount")==null?"":rss.getString("adv_amount"))+"</td>");
				out.print("<td>" + rss.getString("status") + "</td>");
				if (rss.getString("status").equalsIgnoreCase("NOT ISSUED")) {
%><td><a href="advanceProcess.jsp?id=<%= rss.getString("id") %>"><i class="icon-arrow-right"></i></a></td>
<%
	} else {
		out.print("<td>"+"<a href=></a>"+"</td>");
	}

				out.print("</tr>");
			}

		}
	}
%>