<%@page import="general.ActivityLog"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="access.DbConnection"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%
	
	int cid = Integer.parseInt(request.getParameter("cid"));
	String leaveType = request.getParameter("eleavetype");
	int minDays = Integer.parseInt(request.getParameter("emindays"));
	int maxDays = Integer.parseInt(request.getParameter("emaxdays"));

	if(leaveType==null){
		out.println("33");
	}else{
		if(leaveType.isEmpty()){
			out.print("22");
		}else{
			//Actual Processing							
			Connection con = DbConnection.getConnection();
			String sql = "update leavetype set LeaveType=?,MinDays=?,MaxDays=?,LastUpdationDate=curdate() where typeid=?";
			PreparedStatement ps = con.prepareStatement(sql);
			System.out.println(sql);
			ps.setString(1, leaveType);
			ps.setInt(2, minDays);
			ps.setInt(3, maxDays);
			ps.setInt(4, cid);		
			int res = ps.executeUpdate();			
			if(res > 0){
				out.print("1");
				String user = request.getAttribute("userid").toString();
				ActivityLog.log("New Type of Leave "+leaveType+" was Added to Store","NEW",user);
			}else
				out.print("0");
			//Actual End
			ps.close();
			con.close();
		}
	}    
    
%>