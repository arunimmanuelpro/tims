<%@page import="general.ActivityLog"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="access.DbConnection"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%
String reason= request.getParameter("reason");
String date = request.getParameter("date");
String notes = request.getParameter("notes");
String empid = request.getParameter("empid");

if(reason==null || date==null || notes==null || empid==null){
	out.print("33");
}else{
	if(reason.isEmpty() || date.isEmpty() || notes.isEmpty()){
		out.print("22");
	}else{
		//Actual Processing
		
		
		Connection con = DbConnection.getConnection();
		PreparedStatement ps = con.prepareStatement("INSERT INTO `terminations`(`Reason`, `Date`, `Notes`) VALUES (?,?,?)",Statement.RETURN_GENERATED_KEYS);
		ps.setString(1, reason);
		ps.setString(2, date);
		ps.setString(3, notes);

		int res = ps.executeUpdate();
		int res2 = 0;
		
		ResultSet rs = ps.getGeneratedKeys();
        if (rs.next() ) {
            // The generated id
            long iid = rs.getLong(1);
            Statement s = con.createStatement();
            res2 = s.executeUpdate("UPDATE `employee` SET `TerminationId`='"+iid+"',`roleid`='0',`BasicPay`='0',`JobTitleId`=null,`EmpStatusId`=null WHERE `id`='"+empid+"' ");          
        }
        
		if(res2 > 0){
			out.print("1");
			String user = request.getAttribute("userid").toString();
			ActivityLog.log("Employee "+empid+" has been Terminated.","UPDATE",user);
		}else
			out.print("0");
		//Actual End
	}
}
%>