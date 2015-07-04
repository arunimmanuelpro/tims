<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="access.DbConnection"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%
	int id = 0;
	String strid = request.getParameter("id");
	if (strid != null) {
		id = Integer.parseInt(request.getParameter("id"));
	} else {
		id = 0;
	}

	if (id == 0) {

	} else {
		Connection dbc = DbConnection.getConnection();
		Statement s = dbc.createStatement();

		//------------Making all process in enquiry Area
		String sql = "UPDATE enquiry set `status`='STUDENT' where `id`='"
				+ id + "'";
		s.executeUpdate(sql);

		String sql2 = "UPDATE enquiry_data set `status`='STUDENT' where `enquiry_id`='"
				+ id + "'";
		s.executeUpdate(sql2);

		String sqld = "DELETE FROM `enquiry_data` WHERE `enquiry_id`='"
				+ id + "' AND `donebyempid` IS NULL";
		s.executeUpdate(sqld);

		//------------ Converting to Student
		String sql33 = "SELECT * FROM enquiry where `id`='" + id + "'";
		ResultSet rs = s.executeQuery(sql33);
		if (rs.next()) {
			String source = rs.getString("source");
			String name = rs.getString("name");
			String email = rs.getString("email");
			String mobile = rs.getString("mobile");
			String home = rs.getString("homephone");
			String qua = rs.getString("qualification");
			String des = rs.getString("stream");
			String curr = rs.getString("currentlyin");
			String ci = rs.getString("courseinterested");
			String address = rs.getString("address");
			String status = rs.getString("status");

			SimpleDateFormat sd = new SimpleDateFormat("yyyy-MM-dd");
			Date cDate = new Date();
			String cDat = sd.format(cDate);

			// Switch to Student
			String sql4 = "INSERT INTO `tims`.`students` (`id`, `fName`, `lName`, `Mobile`, `Emailaddress`, `addressline1`, `addressline2`, `city`, `state`, `zipcode`, `country`, `gender`, `homephone`, `dateofbirth`, `bloodgroup`, `joindate`, `stream`, `qualification`, `courseid`, `totalfees`, `batchid`, `status`) VALUES (NULL, '"+name+"', 'EOS', '"+mobile+"', '"+email+"', '"+address+"', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '"+cDat+"', NULL, '"+qua+"', NULL, NULL, NULL, 'NEW');";
			System.out.println(sql4);
			s.executeUpdate(sql4);
			
			response.sendRedirect("../student");			

		} else {
			out.print("Enquiry data not found.");
		}

	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Please Hold Conversion in Progress</title>
</head>
<body>Conversion in Progress

</body>
</html>