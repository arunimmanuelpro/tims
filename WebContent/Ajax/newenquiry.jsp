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
	String name = request.getParameter("name");
	String source = request.getParameter("source");
	String email = request.getParameter("email");
	String mobile = request.getParameter("mobile");
	String qualification = request.getParameter("qualification");
	String designation = request.getParameter("designation");
	String currentlyin = request.getParameter("currentlyin");
	String homephone = request.getParameter("homephone");
	String status = request.getParameter("status");
	String type = request.getParameter("type");
	String telecaller = request.getParameter("telecaller");
	String counsiller = request.getParameter("counsiller");
	String courseinterestedin = request
			.getParameter("courseinterestedin");
	if(courseinterestedin.equals("Other")){
		courseinterestedin = request.getParameter("courseinterestedino");
	}
	String address = request.getParameter("address");
	String notes = request.getParameter("notes");
	String followondate = request.getParameter("date");

	if (name == null || source == null || mobile == null) {
		out.print("Sorry. Invalid Access");
	} else {
		if (name.isEmpty() || source.isEmpty() || mobile.isEmpty()) {
			out.print("Sorry. Fill all Fields.");
		} else {
			//Actual Processing
			
			HttpSession ses = request.getSession();
			//String user = (String) ses.getAttribute("user");
			Integer userid = (Integer) ses.getAttribute("id");
			
				
			SimpleDateFormat ddmm = new SimpleDateFormat("yyyy-MM-dd");
			SimpleDateFormat yyyy = new SimpleDateFormat("yyyy");
			Calendar calender = Calendar.getInstance();
			Date currentdate = new Date();
			calender.setTime(currentdate);
			int month = calender.get(Calendar.MONTH) + 1;
			String cDate = ddmm.format(currentdate);
			String year = yyyy.format(currentdate);

			Connection con = DbConnection.getConnection();
			Statement s = con.createStatement();
			String sql = "INSERT INTO `enquiry`(`source`, `name`, `email`, `mobile`, `qualification`, `stream`, `currentlyin`, `homephone`, `courseinterested`, `address`,`donebyid`,`date`,`month`,`year`,`status`,`stype`,`telecaller`,`counsiller`) VALUES ('"	+ source+ "','"	+ name	+ "','"	+ email	+ "','"	+ mobile+ "','"	+ qualification	+ "','"	+ designation+ "','"+ currentlyin+ "','"+ homephone	+ "','"	+ courseinterestedin+ "','"	+ address	+ "','"	+userid+ "','"	+ cDate	+ "','"	+ month+ "','"	+ year + "','"+status+"','"+type+"','"+telecaller+"','"+counsiller+"')";
			System.out.println(sql);
			int res = s.executeUpdate(sql,
			Statement.RETURN_GENERATED_KEYS);
			ResultSet rs = s.getGeneratedKeys();
			if (rs.next()) {
				// Retrieve the auto generated key(s).
				int key = rs.getInt(1);

				out.print(1);
				String user = request.getAttribute("userid").toString();
				ActivityLog.log("New Enquiry "+name+" from "+source+" has been added.","NEW",user);
				if(!followondate.isEmpty()){
					sql = "INSERT INTO `enquiry_data`(`enquiry_id`, `followon`) VALUES ('"+ key	+ "','"+ followondate+ "')";
					int res2 = s.executeUpdate(sql);
				}

			} else {
				out.print("Error Adding Enquiry. Please Try Again");
				//Actual End
			}
		}
	}
%>