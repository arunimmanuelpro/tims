<%@page import="general.ActivityLog"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="access.DbConnection"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%
	String id = request.getParameter("id");
	String status = request.getParameter("status");
	String message = request.getParameter("message");
	String followon = request.getParameter("followon");

	if (id == null || message == null || followon == null
			|| status == null) {
		out.print("Sorry. Invalid Access");
	} else {
		if (id.isEmpty() || message.isEmpty() || status.isEmpty()) {
			out.print("Sorry. Invalid data.");
		} else {
			//Actual Processing

			SimpleDateFormat hhmmss = new SimpleDateFormat("HH:mm:ss");
			SimpleDateFormat ddmm = new SimpleDateFormat("yyyy-MM-dd");
			Calendar calender = Calendar.getInstance();
			Date currentdate = new Date();
			calender.setTime(currentdate);
			String cTime = hhmmss.format(currentdate);
			String cDate = ddmm.format(currentdate);

			String userid = request.getAttribute("userid").toString();

			Connection con = DbConnection.getConnection();
			Statement s = con.createStatement();
			String sql = "UPDATE  `enquiry_data` SET  `callout` =  '"
					+ cTime + "',`message` =  '" + message
					+ "',`status` =  '" + status
					+ "' WHERE `enquiry_id` = '" + id
					+ "' AND `followon`='" + cDate
					+ "' ORDER BY id DESC LIMIT 1";
			int res = s.executeUpdate(sql);
			sql = "UPDATE  `enquiry` SET  `status` =  'FOLLOWUP' WHERE `id` = '"
					+ id + "';";
			res = s.executeUpdate(sql);

			if (status.equals("NOT-INTERESTED")
					|| status.equals("WRONG-ENQUIRY")
					|| status.equals("WRONG-NUMBER")
					|| status.equals("NOT-IN-USE")) {
				sql = "UPDATE  `enquiry` SET  `status` =  'NOT INTERESTED' WHERE `id` = '"
						+ id + "'";
				res = s.executeUpdate(sql);
			} else if (!followon.isEmpty()) {
				sql = "INSERT INTO `enquiry_data`(`enquiry_id`, `followon`) VALUES ('"
						+ id + "','" + followon + "')";
				res = s.executeUpdate(sql);
			} else {
				sql = "UPDATE  `enquiry` SET  `status` =  'COMPLETED' WHERE `id` = '"
						+ id + "'";
				res = s.executeUpdate(sql);
			}

			if (res > 0) {
				out.print("Call End Success");
				String user = request.getAttribute("userid").toString();
				ActivityLog.log("Call to Enquiry " + id
						+ " was completed", "CALL", user);
				response.sendRedirect("../Enquiry/details.jsp?id=" + id);
			} else {
				out.print("Error Ending Call. Please Try Again");
				//Actual End
			}
		}
	}
%>