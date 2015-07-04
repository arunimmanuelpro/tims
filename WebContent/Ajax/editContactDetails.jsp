<%@page import="general.ActivityLog"%>
<%@page import="security.*"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="access.DbConnection"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%
String mobile = request.getParameter("Mobile");
String wemail = request.getParameter("WorkEmail");
String pemail = request.getParameter("EmailAddress");
String aline1 = request.getParameter("AddressLine1");
String aline2 = request.getParameter("AddressLine2");
String city = request.getParameter("City");
String state = request.getParameter("State");
String zip = request.getParameter("ZipCode");
String country = request.getParameter("Country");
String hphone = request.getParameter("homeTelephone");
String wphone = request.getParameter("workphone");
String pan = request.getParameter("pancard");

if(mobile==null || wemail==null || pemail==null  || aline1==null  || aline2==null || city==null || state==null || zip==null || country==null || hphone==null || wphone==null || pan==null){
	out.print("33");
}else{
	if(mobile.isEmpty() || wemail.isEmpty() || pemail.isEmpty() || aline1.isEmpty() || aline2.isEmpty() || city.isEmpty() || state.isEmpty() || zip.isEmpty() 
			|| country.isEmpty() || hphone.isEmpty() || wphone.isEmpty() || pan.isEmpty()){
		out.print("22");
	}else{
		//Actual Processing
	
		String empid = request.getAttribute("userid").toString();
		
		Connection con = DbConnection.getConnection();
		PreparedStatement ps = con.prepareStatement("UPDATE employee SET Mobile=?, WorkEmail=?, PersonalEmail=?, AddressLine1=?, AddressLine2=?, City=?,State=?,ZipCode=?,Country=?,HomeTelephone=?,WorkTelephone=?,Pancardnumber=? WHERE id=?");
		SecureNew sn = new SecureNew();
		ps.setString(1, mobile);
		ps.setString(2, wemail==null?null:sn.encrypt(wemail));
		String pemails = sn.encrypt(pemail);
		ps.setString(3, pemails);
		String aline1s = sn.encrypt(aline1);
		ps.setString(4, aline1s);
		String aline2s = sn.encrypt(aline2);
		ps.setString(5, aline2s);
		ps.setString(6, city);
		ps.setString(7, state);
		ps.setString(8, zip);
		ps.setString(9, country);
		String hphones = sn.encrypt(hphone);
		ps.setString(10, hphones);
		String wphones = sn.encrypt(wphone);
		ps.setString(11, wphones);
		String pans = sn.encrypt(pan);
		ps.setString(12, pans);
		ps.setString(13, empid);
		int res = ps.executeUpdate();
		if(res > 0){
			out.print("1");
			ActivityLog.log("Employee "+empid+" `s Contact Details has been Updated","UPDATE",empid);
		}else
			out.print("0");
		//Actual End
	}
}
%>