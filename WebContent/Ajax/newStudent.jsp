<%@page import="general.ActivityLog"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
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
	String country = request.getParameter("country");
	String hphone = request.getParameter("homephone");
	String dob = request.getParameter("dob");
	String bgroup = request.getParameter("bloodgroup");
	String gender = request.getParameter("gender");
	String stream = request.getParameter("stream");
	String qualify = request.getParameter("qualification");
	String fees = request.getParameter("totalfees");
	String coid = request.getParameter("courseid");

	if (fname == null || lname == null || mobile == null
			|| email == null || aline1 == null || aline2 == null
			|| city == null || state == null || zip == null
			|| country == null || hphone == null || dob == null
			|| bgroup == null || gender == null || stream == null
			|| qualify == null || fees == null ) {
		out.print("33");
	} else {
		if (fname.isEmpty() || lname.isEmpty() || mobile.isEmpty()
				|| email.isEmpty() || aline1.isEmpty()
				|| aline2.isEmpty() || city.isEmpty()
				|| state.isEmpty() || zip.isEmpty()
				|| country.isEmpty() || hphone.isEmpty()
				|| dob.isEmpty() || bgroup.isEmpty()
				|| gender.isEmpty() || stream.isEmpty()
				|| qualify.isEmpty() || fees.isEmpty()) {
			out.print("22");
		} else {
			//Actual Processing

			String empid = request.getAttribute("userid").toString();
			
			SimpleDateFormat sd = new SimpleDateFormat("yyyy-MM-dd");
			Date cDate = new Date();
			String cDat = sd.format(cDate);
			
			Connection con = DbConnection.getConnection();
			PreparedStatement ps = con
					.prepareStatement("INSERT INTO `students`(`fname`, `lname`, `Mobile`, `Emailaddress`, `addressline1`, `addressline2`,`city`,`state`,`zipcode`,`country`,`homephone`,`dateofbirth`,`bloodgroup`,`gender`,`stream`,`qualification`,`totalfees`,`status`,`joindate`,courseid) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
			ps.setString(1, fname);
			ps.setString(2, lname);
			ps.setString(3, mobile);
			ps.setString(4, email);
			ps.setString(5, aline1);
			ps.setString(6, aline2);
			ps.setString(7, city);
			ps.setString(8, state);
			ps.setString(9, zip);
			ps.setString(10, country);
			ps.setString(11, hphone);
			ps.setString(12, dob);
			ps.setString(13, bgroup);
			ps.setString(14, gender);
			ps.setString(15, stream);
			ps.setString(16, qualify);
			ps.setString(17, fees);
			ps.setString(18, "NEW");
			ps.setString(19, cDat);
			ps.setString(20, coid);
			int res = ps.executeUpdate();
			if (res > 0) {
				out.print("1");
				String user = request.getAttribute("userid").toString();
				ActivityLog.log("New Student "+fname+" has been created.","NEW",user);
			} else
				out.print("0");
			//Actual End
		}
	}
%>