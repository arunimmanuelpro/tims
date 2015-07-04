<%@page import="general.ActivityLog"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="access.DbConnection"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%
String fname = request.getParameter("FirstName");
String lname = request.getParameter("LastName");
String mobile = request.getParameter("Mobile");
String jdate = request.getParameter("Joindate");
//System.out.println("jdate");
//String cstart = request.getParameter("contractstart");
//String cend = request.getParameter("contractend");
//String level = request.getParameter("elevel");
//String rid = request.getParameter("roleid");
//String bpay = request.getParameter("Basicpay");
Connection con = null; PreparedStatement ps = null;
if(fname==null || lname==null || mobile==null  || jdate==null){
	out.print("33");
}else{
	if(fname.isEmpty() || lname.isEmpty() || mobile.isEmpty() || jdate.isEmpty()){
		out.print("22");
	}else{
		//Actual Processing		
		String empid = request.getAttribute("userid").toString();		
		con = DbConnection.getConnection();
		int res = 0;
		//if(cstart.isEmpty() || cend.isEmpty()){
			ps = con.prepareStatement("INSERT INTO `employee`(`FirstName`, `LastName`, `Mobile`, `JoinDate`, `password`) VALUES (?,?,?,?,'password')");
			ps.setString(1, fname);
			ps.setString(2, lname);
			ps.setString(3, mobile);
			ps.setString(4, jdate);			
			res = ps.executeUpdate();	
		/* }else{
			ps = con.prepareStatement("INSERT INTO `employee`(`FirstName`, `LastName`, `Mobile`, `JoinDate`, `ContractStart`, `ContractEnd`, `password`) VALUES (?,?,?,?,?,?,'password')");
			ps.setString(1, fname);
			ps.setString(2, lname);
			ps.setString(3, mobile);
			ps.setString(4, jdate);
			ps.setString(5, cstart);
			ps.setString(6, cend);			
			res = ps.executeUpdate();
		}		 */
		if(res > 0){
			out.print("1");
			ActivityLog.log("New Employee "+fname+" has been Created Successfully","NEW",empid);
		}else
			out.print("0");
		//Actual End	
	}
}
ps.close();
con.close();
%>