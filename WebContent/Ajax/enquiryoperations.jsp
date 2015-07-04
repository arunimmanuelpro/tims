<%@page import="general.ActivityLog"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="access.DbConnection"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%
	String bid = request.getParameter("bid");
	String operation = request.getParameter("operation");

	if (bid != null || operation != null) {
		if (bid.isEmpty() || operation.isEmpty()) {
			out.println("22");
		} else if(operation.equalsIgnoreCase("COMPLETED") || operation.equalsIgnoreCase("NOT INTERESTED")|| operation.equalsIgnoreCase("DUPLICATE")){
			Connection con = DbConnection.getConnection();
			PreparedStatement s = con
					.prepareStatement("UPDATE enquiry SET status='"
							+ operation + "' WHERE `id`='" + bid + "'");
			int res = s.executeUpdate();
			
			Statement ss = con.createStatement();
			String sql = "DELETE FROM `enquiry_data` WHERE `enquiry_id`='"+bid+"' AND `donebyempid` IS NULL";
			ss.executeUpdate(sql);

			if (res > 0) {
				out.println("1");
				String user = request.getAttribute("userid").toString();
				ActivityLog.log("Batch "+bid+" was marked as "+operation,"CALL",user);
				response.sendRedirect(request.getContextPath()+"/Enquiry/?msg=Enquiry was marked "+operation);
			} else {
				out.println("0");
			}
		}
	} else {
		out.println("33");
	}
	
%>