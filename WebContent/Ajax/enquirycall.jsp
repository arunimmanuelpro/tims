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
	
	if (id == null) {
		out.print("Sorry. Invalid Access");
	} else {
		if (id.isEmpty()) {
			out.print("Sorry. Invalid data.");
		} else {
			//Actual Processing
			
			String userid = request.getAttribute("userid").toString();
			
			SimpleDateFormat hhmmss = new SimpleDateFormat("HH:mm:ss");
			SimpleDateFormat ddmm = new SimpleDateFormat("yyyy-MM-dd");
			Calendar calender = Calendar.getInstance();
			Date currentdate = new Date();
			calender.setTime(currentdate);
			String cTime = hhmmss.format(currentdate);
			String cDate = ddmm.format(currentdate);
			
			Connection con = DbConnection.getConnection();
			Statement s = con.createStatement();
			String sql = "SELECT status FROM `enquiry` WHERE `id`='"+id+"' LIMIT 1";
			ResultSet rss = s.executeQuery(sql);
			String stat = "";
			if(rss.next())
				stat = rss.getString(1);
		
			int res = 0;
			if(!stat.equalsIgnoreCase("ONCALL")){
				sql = "UPDATE  `enquiry_data` SET  `callin` =  '"+cTime+"', `donebyempid`='"+userid+"' WHERE `enquiry_id` = '"+id+"' AND `followon`='"+cDate+"' ORDER BY id DESC LIMIT 1";
				res = s.executeUpdate(sql);
				sql = "UPDATE  `enquiry` SET  `status` =  'ONCALL' WHERE `id` = '"+id+"';";
				res = s.executeUpdate(sql);
			}else{
				out.println("A Call is already in Progress<br>");
			}
			if (res > 0) {
				out.print("Call Success");
				String user = request.getAttribute("userid").toString();
				ActivityLog.log("Call to enquiry id: "+id+" was connected","CALL",user);
				response.sendRedirect("../Enquiry/details.jsp?id="+id);
			} else {
				out.println("Error making Call. Please Try Again");
				//Actual End
			}
		}
	}
%>