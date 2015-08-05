<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="access.DbConnection"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%
	Connection con = DbConnection.getConnection();
	String fromdate = request.getParameter("from");
	String todate = request.getParameter("todate");
	int count = Integer.parseInt(request.getParameter("count"));
	
	
	PreparedStatement ps1 = con
			.prepareStatement("select * from timesheetmaster where empid = ? and fromdate = ? and todate = ?");
	ps1.setInt(1, (Integer) session.getAttribute("id"));
	ps1.setString(2, fromdate);
	ps1.setString(3, todate);
	
	ResultSet rs = ps1.executeQuery();
	
	if (rs.next()) {
		PreparedStatement ps = con
				.prepareStatement("delete  from timesheetmaster where empid = ? and fromdate = ? and todate = ?");
		ps.setInt(1, (Integer) session.getAttribute("id"));
		ps.setString(2, fromdate);
		ps.setString(3, todate);
		
		ps.executeUpdate();
		
	}
	try{
	for (int i = 1; i <= count; i++) {

		if ((request.getParameter(i + "r1").isEmpty() || request
				.getParameter(i + "r1").equals("0"))
				&& (request.getParameter(i + "r2").isEmpty() || request
						.getParameter(i + "r2").equals("0"))
				&& (request.getParameter(i + "r3").isEmpty() || request
						.getParameter(i + "r3").equals("0"))
				&& (request.getParameter(i + "r4").isEmpty() || request
						.getParameter(i + "r4").equals("0"))
				&& (request.getParameter(i + "r5").isEmpty() || request
						.getParameter(i + "r5").equals("0"))
				&& (request.getParameter(i + "r6").isEmpty() || request
						.getParameter(i + "r1").equals("0"))
				&& (request.getParameter(i + "r7").isEmpty() || request
						.getParameter(i + "r1").equals("0"))) {
		} else {
			PreparedStatement ps = con
						.prepareStatement("insert into timesheetmaster (empid,fromdate,todate,d1,d2,d3,d4,d5,d6,d7,cat) values(?,?,?,?,?,?,?,?,?,?,?)");
			
			ps.setInt(1, (Integer) session.getAttribute("id"));
			ps.setString(2, fromdate);
			ps.setString(3, todate);
			
			
				ps.setString(4,
						request.getParameter(i + "r1"));

				ps.setString(5,
						request.getParameter(i + "r2"));
				ps.setString(6,
						request.getParameter(i + "r3"));
				ps.setString(7,
						request.getParameter(i + "r4"));
				ps.setString(8,
						request.getParameter(i + "r5"));
			
				ps.setString(9,
						request.getParameter(i + "r6"));
			
				ps.setString(10,
						request.getParameter(i + "r7"));
			
				ps.setString(11,
						request.getParameter(i + "cat"));
			

			
			ps.executeUpdate();			


		}

	}
	PreparedStatement ps = con.prepareStatement("select * from timesheetlog where empid = ? and fromdate = ? and todate = ? and comment = ?");
	ps.setInt(1, (Integer) session.getAttribute("id"));
	ps.setString(2, fromdate);
	ps.setString(3, todate);
	ps.setString(4, request.getParameter("comment"));
	ResultSet rs1 = ps.executeQuery();
	if(rs1.next()){
		ps = con.prepareStatement("delete from timesheetlog where empid = ? and fromdate = ? and todate = ? and comment = ?");
		ps.setInt(1, (Integer) session.getAttribute("id"));
		ps.setString(2, fromdate);
		ps.setString(3, todate);
		ps.setString(4, request.getParameter("comment"));
		ps.executeUpdate();
	} 
	ps = con.prepareStatement("insert into timesheetlog (empid,fromdate,todate,status,comment,updatedby) values(?,?,?,?,?,?)");
	ps.setInt(1, (Integer) session.getAttribute("id"));
	ps.setString(2, fromdate);
	ps.setString(3, todate);
	ps.setString(4, "Added");
	ps.setString(5, request.getParameter("comment"));
	ps.setString(6, "User");
	ps.executeUpdate();
	out.println("Data Stored Successfully");
	}catch(Exception e){
		e.printStackTrace();
		out.println("There was Error in Processing your request, please try again later "+e);
	}
	
	con.close();
%>