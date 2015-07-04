<%@page import="java.util.TreeSet"%>
<%@page import="java.util.Set"%>
<%@page import="java.util.LinkedList"%>
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
			<div class="col-sm-12">

				<section class="panel">
					<header class="panel-heading summary-head">
						<h4>Time Sheet to be reviewed</h4>

					</header>
				</section>
				<section class="panel">
					<form action="">
						<div class="adv-table">
							<table class="display table table-bordered table-striped"
								id="dynamic-table2" style="text-align: center;">
								<thead>
									<tr>

										<th style="text-align: center;">Employee Name</th>
										<th style="text-align: center;">From Date to To Date</th>

										<th style="text-align: center;">Comment</th>

										<th style="text-align: center;">Action</th>
									</tr>
								</thead>
								<tbody>
									<%
										
										List<String> fromdate = new LinkedList<String>();
										List<String> todate = new LinkedList<String>();
										List<String> employeeid = new LinkedList<String>();
										
										
										Connection con = DbConnection.getConnection();
										

									
											
												PreparedStatement ps2 = con
														.prepareStatement("select DISTINCT fromdate from timesheetmaster where status = ?");
												ps2.setString(1,"Waiting");
												ResultSet rs2 = ps2.executeQuery();
												while (rs2.next()) {
													fromdate.add(rs2.getString("fromdate"));
												}
												ps2 = con
														.prepareStatement("select DISTINCT todate from timesheetmaster where status = ?");
												ps2.setString(1,"Waiting");
												rs2 = ps2.executeQuery();
												while (rs2.next()) {
													todate.add(rs2.getString("todate"));
												}
												
												ps2 = con
														.prepareStatement("select id,FirstName,LastName from employee");
												
												ResultSet rs = ps2.executeQuery();
												while (rs.next()) {
													for(int i = 0; i<fromdate.size();i++){
														PreparedStatement ps = con.prepareStatement("select * from timesheetmaster where fromdate = ? and todate = ? and empid = ? and status = ?");
														ps.setString(1, fromdate.get(i));
														ps.setString(2, todate.get(i));
														ps.setInt(3, rs.getInt("id"));
														ps.setString(4, "Waiting");
														ResultSet rs5 = ps.executeQuery();
														if(rs5.next()){
											
									%>
									<tr>
									<td style = "text-align:center;">
									<%
												
												%> <%=rs.getString("FirstName") + " "+ rs.getString("LastName")%>
												<%
													
												%>
									</td>
										<td><%=rs5.getString("fromdate")%> to <%=rs5.getString("todate")%></td>

										<%
											PreparedStatement ps4 = con
																.prepareStatement("select * from timesheetlog where empid =? and fromdate = ? and todate = ? and updatedby = ?");
														ps4.setInt(1, rs.getInt("id"));
														ps4.setString(2, rs5.getString("fromdate"));
														ps4.setString(3, rs5.getString("todate"));
														ps4.setString(4, "User");
														ResultSet rs4 = ps4.executeQuery();
														String comment = "";
														while (rs4.next()) {
															comment = rs4.getString("comment");
														}
										%>

										<td><%=comment%></td>

										<td><a
											href="viewandedit.jsp?empid=<%=rs.getInt("id") %>&fromdate=<%=rs5.getString("fromdate")%>&todate=<%=rs5.getString("todate")%>" target = "blank">View
												and Edit</a></td>

									</tr>

									<%}
													}
												}
												
										
									%>
								</tbody>
							</table>
						</div>
					</form>
				</section>


			</div>

			<div class="col-sm-12">

				<section class="panel">
					<header class="panel-heading summary-head">
						<h4>Admin Action Log</h4>

					</header>
					<section class="panel">
						<form action="">
							<div class="adv-table">
								<table class="display table table-bordered table-striped"
									id="dynamic-table" style="text-align: center;">
									<thead>
										<tr>
											<th style="text-align: center;">Employee Name</th>
											<th style="text-align: center;">Date</th>
											<th style="text-align: center;">Status</th>
											<th style = "text-align:center">View</th>
										</tr>
									</thead>
									<tbody>
										<%
											fromdate.clear();
											todate.clear();
											employeeid.clear();
											List<String> status = new LinkedList<String>();
											List<String> empid2 = new LinkedList<String>();
											PreparedStatement ps = con.prepareStatement("select DISTINCT fromdate,todate,empid,status,id from timesheetmaster where status = 'Accepted' or status = 'Rejected'");
											rs = ps.executeQuery();
											while (rs.next()) {
												if (employeeid.size() == 0) {
													fromdate.add(rs.getString("fromdate"));
													todate.add(rs.getString("todate"));
													employeeid.add(String.valueOf(rs.getString("empid")));
													empid2.add(String.valueOf(rs.getString("empid")));
													status.add(rs.getString("status"));
												}
												boolean avilable = false;
												for (int i = 0; i < employeeid.size(); i++) {

													if (!employeeid.get(i).equals(
															String.valueOf(rs.getInt("empid")))) {
														avilable = true;
													} else {
														avilable = false;
													}
												}
												if (avilable) {
													fromdate.add(rs.getString("fromdate"));
													todate.add(rs.getString("todate"));
													employeeid.add(String.valueOf(rs.getString("empid")));
													empid2.add(String.valueOf(rs.getString("empid")));
													status.add(rs.getString("status"));
												}
											}

											for (int i = 0; i < empid2.size(); i++) {
										%>
										<tr>
											<td>
												<%
													ps2 = con
																.prepareStatement("select id,FirstName,LastName from employee where id = ?");
														ps2.setInt(1, Integer.parseInt(empid2.get(i)));
														rs2 = ps2.executeQuery();
														if (rs2.next()) {
												%> <%=rs2.getString("FirstName") + " "
							+ rs2.getString("LastName")%>
												<%
													}
												%>
											</td>
											<td><%=fromdate.get(i)%> to <%=todate.get(i)%></td>
											<td><%=status.get(i)%></td>
												<td>
												<a 	href="view.jsp?empid=<%=empid2.get(i) %>&fromdate=<%=fromdate.get(i)%>&todate=<%=todate.get(i)%>">View
												</a></td>
										</tr>
										<%
											}
										%>
									</tbody>
								</table>
							</div>
						</form>
					</section>
				</section>
			</div>


		</div>
	</section>
</section>
<%
	con.close();
%>

<%@include file="../Common/Footer.jsp"%>

