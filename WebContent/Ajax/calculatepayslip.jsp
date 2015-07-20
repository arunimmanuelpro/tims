<%@page import="java.util.LinkedList"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="access.DbConnection"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%
	Connection con = DbConnection.getConnection();
	int year = Integer.parseInt(request.getParameter("year"));
	int month = Integer.parseInt(request.getParameter("month"));
	PreparedStatement ps = con
			.prepareStatement("select id,FirstName,LastName from employee");
	ResultSet rs = ps.executeQuery();
	List<Integer> empid = new LinkedList<Integer>();
	List<String> empname = new LinkedList<String>();
	
	while (rs.next()) {
		empid.add(rs.getInt("id"));
		empname.add(rs.getString("FirstName")+" "+rs.getString("LastName"));
	}
%>
<table class="table" >
	<thead>
		<tr>
			<th>#</th>
			<th>Employee</th>
			<th>Name</th>
			
			<th>More...</th>
		</tr>
	</thead>
	<tbody id="payroll_info_ajax_display">

		<%
			for (int i = 0; i < empid.size(); i++) {
				ps = con.prepareStatement("select * from empattendance where empid = ? and month = ? and year = ?");
				ps.setInt(1, empid.get(i));
				ps.setInt(2, month);
				ps.setInt(3, year);
				rs = ps.executeQuery();
				if (rs.next()) {
		%>
					<tr>
						<td></td>
						<td><%=empid.get(i) %></td>
						<td><%=empname.get(i) %></td>
						
						<td><a href ="payslip.jsp?empid=<%=empid.get(i)%>&year=<%=year%>&month=<%=month%>">View Pay Slip</a></td>
					</tr>
		<%
			}
			}
		%>
	</tbody>
</table>



<%
	con.close();
%>