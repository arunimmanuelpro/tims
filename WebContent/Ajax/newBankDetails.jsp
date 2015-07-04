<%@page import="security.SecureNew"%>
<%@page import="general.ActivityLog"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="access.DbConnection"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%
String bname = request.getParameter("bankname");
String name = request.getParameter("accholdername");
String loc = request.getParameter("bankloacation");
String accn = request.getParameter("accnumber");
String codee = request.getParameter("ifsccode");

if(name==null || bname==null || loc==null  || accn==null  || codee==null ){
	out.print("33");
}else{
	if(name.isEmpty() || bname.isEmpty() || loc.isEmpty() || accn.isEmpty() || codee.isEmpty()){
		out.print("22");
	}else{
		//Actual Processing
		
		SecureNew sn = new SecureNew();
	
		String empid = request.getAttribute("userid").toString();
		
		Connection con = DbConnection.getConnection();
		PreparedStatement ps = con.prepareStatement("INSERT INTO `bankdetails`(`BankName`, `empid`, `AccHolderName`, `BankLocation`, `AccNumber`, `IFSC_code`) VALUES (?,?,?,?,?,?)");
		ps.setString(1, bname);
		ps.setString(2, empid);
		ps.setString(3, name);
		ps.setString(4, sn.encrypt(loc));
		ps.setString(5, sn.encrypt(accn));
		ps.setString(6, codee);

		int res = ps.executeUpdate();
		if(res > 0){
			out.print("1");
			String user = request.getAttribute("userid").toString();
			ActivityLog.log("Employee "+user+" added new bank details to his/her account","BANK",user);
		}else
			out.print("0");
		//Actual End
	}
}
%>