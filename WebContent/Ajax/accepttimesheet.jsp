<%@page import="java.util.LinkedList"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="access.DbConnection"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%
	int touser = Integer.parseInt(request.getParameter("touser"));
	String fromdate = request.getParameter("fromdate");
	String todate = request.getParameter("todate");
	String status = request.getParameter("status");
	String comment = request.getParameter("comment");
	Connection con = DbConnection.getConnection();
	PreparedStatement ps = con
			.prepareStatement("update timesheetmaster set status = ? where empid = ? and fromdate =? and todate = ?");
	ps.setString(1, status);
	ps.setInt(2, touser);
	ps.setString(3, fromdate);
	ps.setString(4, todate);
	ps.executeUpdate();
	//Update empattendance table

	if (status.equals("Accepted")) {
		//Calculate Dates between from and to date
		List<Date> dates = new ArrayList<Date>();

		String str_date = fromdate;
		String end_date = todate;

		DateFormat formatter;

		formatter = new SimpleDateFormat("dd-MM-yyyy");
		Date startDate = (Date) formatter.parse(str_date);
		Date endDate = (Date) formatter.parse(end_date);
		long interval = 24 * 1000 * 60 * 60; // 1 hour in millis
		long endTime = endDate.getTime(); // create your endtime here, possibly using Calendar or Date
		long curTime = startDate.getTime();
		while (curTime <= endTime) {
			dates.add(new Date(curTime));
			curTime += interval;
		}

		//Get leave categeory from tscategeory table
		PreparedStatement ps3 = con
				.prepareStatement("select * from tscategory");
		ResultSet rs3 = ps3.executeQuery();
		List<String> leavecat = new ArrayList<String>();
		leavecat.clear();
		while (rs3.next()) {
			if (rs3.getString("CategoryName").contains("Leave")) {
				leavecat.add(String.valueOf(rs3.getInt("CategoryId")));
			}
		}
		String[] datearray = new String[] { "d1", "d2,", "d3", "d4",
				"d5", "d6", "d7" };
		for (int i = 0; i < dates.size(); i++) {
			Date lDate = (Date) dates.get(i);
			String ds = formatter.format(lDate);
			formatter = new SimpleDateFormat("dd-MM-yyyy");
			Date currentdate = (Date) formatter.parse(ds);
			Calendar cal = Calendar.getInstance();
			cal.setTime(currentdate);
			int month = cal.get(Calendar.MONTH) + 1;
			int day = cal.get(Calendar.DAY_OF_MONTH);
			int year = cal.get(Calendar.YEAR);

			ps = con.prepareStatement("select * from empattendance where empid =? and  month = ? and year = ?");
			ps.setInt(1, touser);
			ps.setInt(2, month);
			ps.setInt(3, year);
			ResultSet rs = ps.executeQuery();

			if (rs.next()) {
				int k = i+1;
				PreparedStatement ps5 = con
						.prepareStatement("select cat,d"+k+" from timesheetmaster where empid = ? and fromdate = ? and todate = ? and status = ? ");
				ps5.setInt(1, touser);
				ps5.setString(2, fromdate);
				ps5.setString(3, todate);
				ps5.setString(4, "Accepted");
				ResultSet rs5 = ps5.executeQuery();
				int hours =0;
				boolean leave = false;
				String cat = "";
				while(rs5.next()){
					if(!rs5.getString("d"+k).isEmpty()){
						hours += Integer.parseInt(rs5.getString("d"+k));
						for(String str: leavecat) {
							System.out.println(rs5.getString("cat"));
						    if(str.trim().equals(rs5.getString("cat"))){
							leave = true;
							cat = rs5.getString("cat");
						    }
					}
				}
				}
				System.out.println(leave);
				ps = con.prepareStatement("update empattendance set d"
						+ day
						+ " = ? where empid = ? and month = ? and year = ?");
				if(leave){
					ps.setString(1, cat);
				}else{
				ps.setString(1, "P");
				}
				ps.setInt(2, touser);
				ps.setInt(3, month);
				ps.setInt(4, year);
				System.out.println(ps);
				ps.executeUpdate();

			} else {
				ps = con.prepareStatement("insert into empattendance (empid,month,year,d"
						+ day + ") value(?,?,?,?)");
				ps.setInt(1, touser);
				ps.setInt(2, month);
				ps.setInt(3, year);
				ps.setString(4, "P");
				
				ps.executeUpdate();

			}

		}
	}
	ps = con.prepareStatement("insert into timesheetlog (empid,fromdate,todate,status,comment,updatedby) values (?,?,?,?,?,?)");
	ps.setInt(1, touser);
	ps.setString(2, fromdate);
	ps.setString(3, todate);
	ps.setString(4, status);
	ps.setString(5, comment);
	ps.setString(6, "Admin");
	ps.executeUpdate();
	con.close();
	out.println("Timesheet " + status);
%>