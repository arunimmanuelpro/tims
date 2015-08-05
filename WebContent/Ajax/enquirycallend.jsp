<%@page import="java.sql.PreparedStatement"%>
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
			if(followon.isEmpty()||followon==null){
				PreparedStatement ps = con.prepareStatement("insert into enquiry_data(enquiry_id,message,donebyempid)values(?,?,?)");
				ps.setInt(1, Integer.parseInt(id));
				
				ps.setString(2, message);
				int r   = (Integer)request.getAttribute("userid");
				ps.setInt(3, r);
				ps.executeUpdate();
			}else{
		PreparedStatement ps = con.prepareStatement("insert into enquiry_data(enquiry_id,followon,message,donebyempid)values(?,?,?,?)");
		ps.setInt(1, Integer.parseInt(id));
		ps.setString(2, followon);
		ps.setString(3, message);
		int r   = (Integer)request.getAttribute("userid");
		ps.setInt(4, r);	
		ps.executeUpdate();
			}
			response.sendRedirect(request.getContextPath()+"/Enquiry/details.jsp?id="+id);
		}
	}
%>