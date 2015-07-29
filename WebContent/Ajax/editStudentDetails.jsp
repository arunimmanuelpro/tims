<%@page import="general.ActivityLog"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="access.DbConnection"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%
String fname = request.getParameter("firstname");
String lname = request.getParameter("lastname");
String mobile = request.getParameter("mobile");
String email = request.getParameter("email");
String aline1 = request.getParameter("addresline1");
String aline2 = request.getParameter("addresline2");
String city = request.getParameter("city");
String state = request.getParameter("state");
String zip = request.getParameter("zipcode");
String hphone = request.getParameter("homephone");
String dob = request.getParameter("dob");
String stream = request.getParameter("stream");
String bloodgroup = request.getParameter("bloodgroup");
String qualification = request.getParameter("qualification");
String stuid = request.getParameter("stuid");

if(fname==null || lname==null || mobile==null  || email==null  || aline1==null || aline2==null || city==null || state==null || zip==null || hphone==null){
	out.print("33");
}else{
	if(fname.isEmpty() || lname.isEmpty() || mobile.isEmpty() || email.isEmpty() || aline1.isEmpty() || aline2.isEmpty() || city.isEmpty() || state.isEmpty() || zip.isEmpty() || hphone.isEmpty()){
		out.print("22");
	}else{
		//Actual Processing
		
		
		Connection con = DbConnection.getConnection();
		PreparedStatement ps = con.prepareStatement("UPDATE students SET fName=?, lName=?, Mobile=?, Emailaddress=?, addressLine1=?, addressLine2=?,city=?,state=?,zipcode=?,homephone=?,dateofbirth=?,stream=?,bloodgroup=?,qualification=? WHERE id=?");
		ps.setString(1, fname);
		ps.setString(2, lname);
		ps.setString(3, mobile);
		ps.setString(4, email);
		ps.setString(5, aline1);
		ps.setString(6, aline2);
		ps.setString(7, city);
		ps.setString(8, state);
		ps.setString(9, zip);
		ps.setString(10, hphone);
		ps.setString(11, dob);
		ps.setString(12, stream);
		ps.setString(13, bloodgroup);
		ps.setString(14, qualification);
		ps.setString(15, stuid);
		System.out.println(ps);
		int res = ps.executeUpdate();
		if(res > 0){
			out.print("1");
			String user = request.getAttribute("userid").toString();
			ActivityLog.log("Student "+fname+"`s  Details has been Updated","UPDATE",user);
		}else
			out.print("0");
		//Actual End
		con.close();
	}
}
%>