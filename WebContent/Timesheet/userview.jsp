<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="access.DbConnection"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%
	request.setAttribute("title", "View Timesheet");
%>

<%@include file="../Common/Header.jsp"%>

<!--main content start-->
<section id="main-content">
	<section class="wrapper">
		<!-- page start-->
		<div class="row">
			<div class="col-lg-12">
				<section class="panel">
					<!--Current Timesheet  -->
					<!-- <aside class="profile-info">   -->
					<header class="panel-heading summary-head">
						<h4>View Time Sheet</h4>

					</header>
					
						<div class="table-responsive">
						<table class="table table-striped m-b-none text-small datatable " id="dynamic-table" >
							<thead style="background-color: #F3F781; color: #000000;text-align:center;">
								<tr>
								<th style="text-align:center;">Date</th>
								<th style="text-align:center;">Status</th>
								<th style="text-align:center;">Action</th>
								</tr>
								</thead>
								<tbody>
									<%Connection con = DbConnection.getConnection();
									PreparedStatement ps = con.prepareStatement("select distinct fromdate,todate,status from timesheetmaster where empid =?");
									ps.setInt(1, (Integer)session.getAttribute("id"));
									ResultSet rs = ps.executeQuery();
									while(rs.next()){
									%>
								<tr>
									<td style="text-align:center;"><%=rs.getString("fromdate") +" to " +rs.getString("todate")%></td>
									<td style="text-align:center;"><%=rs.getString("status") %></td>
									<td style="text-align:center;">
									<%if(rs.getString("status").equals("Rejected") || rs.getString("status").equals("Waiting")){ %>
									<a 	href="viewandedit.jsp?empid=<%=session.getAttribute("id")%>&fromdate=<%=rs.getString("fromdate")%>&todate=<%=rs.getString("todate")%>">View and Edit</a>
									<%}else{ %>
									<a 	href="view.jsp?empid=<%=session.getAttribute("id")%>&fromdate=<%=rs.getString("fromdate")%>&todate=<%=rs.getString("todate")%>">View</a>
									<%} %>
									
									</td>
								
								</tr>
								<%} %>
								</tbody>
					</table>
					</div>
				</section>
			</div>
		</div>
	</section>
</section>
<%con.close(); %>
<%@include file="../Common/Footer.jsp"%>
