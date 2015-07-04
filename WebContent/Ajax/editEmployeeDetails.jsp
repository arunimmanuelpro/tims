<%@page import="security.SecureNew"%>
<%@page import="general.ActivityLog"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="access.DbConnection"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%
	SecureNew sn = new SecureNew();
	String wemail = request.getParameter("workemail");
	String cstart = request.getParameter("contractstart");
	String cend = request.getParameter("contractend");
	String bpay = request.getParameter("basicpay");
	String estatus = request.getParameter("empstatus");
	String desig = request.getParameter("jobtitles");
	String role = request.getParameter("userrole");
	String level = request.getParameter("elevel");
	String mode = request.getParameter("mode");
	String pfnum = request.getParameter("pfnumber");
	String esicnum = request.getParameter("esicnumber");
	String reportto = request.getParameter("reportTo");
	String empid = request.getParameter("empid");
    //System.out.println(wemail+"\n"+bpay+"\n"+estatus+"\n"+desig+"\n"+role+"\n"+level+"\n"+reportto+"\n"+mode);

if(wemail==null || bpay==null  || estatus==null || desig==null || role==null || level==null || mode==null){
	out.print("33");
}else{
	if(wemail.isEmpty() || bpay.isEmpty() || estatus.isEmpty() || desig.isEmpty() || level.isEmpty() || mode.isEmpty()){
		out.print("22");
	}else{
		//Actual Processing
		//System.out.println("3434dfw");
		Connection con = DbConnection.getConnection();
		PreparedStatement ps = null;
		int res = 0;
		if(cstart.isEmpty() || cend.isEmpty()){
			ps = con.prepareStatement("UPDATE employee SET WorkEmail=?, BasicPay=?, EmpStatusId=?, JobTitleId=?, roleid=?, EmpLevelRef=?, pfnumber=?, esicnumber=?, ReportTo=?, ModeOfRole=? WHERE id=?");
			ps.setString(1, (wemail==null?"null":sn.encrypt(wemail)));
			ps.setString(2, bpay);
			ps.setString(3, estatus);
			ps.setString(4, desig);
			ps.setString(5, role);
			ps.setString(6, level);
			ps.setString(7, pfnum);
			ps.setString(8, esicnum);
			ps.setString(9, reportto);
			ps.setString(10, mode);
			ps.setString(11, empid);			
			res = ps.executeUpdate();
		}else{
			ps = con.prepareStatement("UPDATE employee SET WorkEmail=?, ContractStart=?, ContractEnd=?, BasicPay=?, EmpStatusId=?, JobTitleId=?, roleid=?, EmpLevelRef=?, pfnumber=?,esicnumber=?, ReportTo=?, ModeOfRole=? WHERE id=?");
			ps.setString(1, (wemail==null?"null":sn.encrypt(wemail)));
			ps.setString(2, cstart);
			ps.setString(3, cend);
			ps.setString(4, bpay);
			ps.setString(5, estatus);
			ps.setString(6, desig);
			ps.setString(7, role);
			ps.setString(8, level);
			ps.setString(9, pfnum);
			ps.setString(10, esicnum);
			ps.setString(11, reportto);
			ps.setString(12, mode);
			ps.setString(13, empid);
			res = ps.executeUpdate();
		}		
		
		if(res > 0){
			out.print("1");
			String user = request.getAttribute("userid").toString();
			ActivityLog.log("Employee "+empid+"`s Work Details has been Updated","UPDATE",user);
		}else
			out.print("0");
		//Actual End
		ps.close();
		con.close();
	}
}
%>