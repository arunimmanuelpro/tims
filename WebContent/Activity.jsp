<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="access.DbConnection"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.Date"%>
<%@page import="security.SecureNew"%>
<%@page import="general.GetInfoAbout"%>
<%
	request.setAttribute("title", "Activity Logs");
%>
<%@include file="Common/Header.jsp"%>
<%
	Date today = new Date();
	Connection con = DbConnection.getConnection();
	Statement s;
	String sql = "";

	//Get Emp
	sql = "SELECT * FROM `activity_log` order by id DESC";
	s = con.createStatement();
	ResultSet logdetails = s.executeQuery(sql);
%>
<!--main content start-->
<section id="main-content">
	<section class="wrapper">
		<div class="row">
			<div class="col-lg-12">
				<section class="panel">
					<header class="panel-heading summary-head">
						<h4>Activity Log</h4>
						<p><%=today%></p>
					</header>
					<div class="panel-body">
						<div class="table-responsive">
							<table class="table table-striped border-top" id="sample_1"
								class="dtable">
								<thead>
									<tr>
										<th>Type</th>
										<th>Activity</th>
										<th>Date</th>
										<th>User</th>
									</tr>
								</thead>
								<tbody>
								<%
								SecureNew sn = new SecureNew();
								while(logdetails.next()){
								%>
									<tr>
									<td><%=sn.decrypt(logdetails.getString("type")) %></td>
									<td><%=sn.decrypt(logdetails.getString("activity")) %></td>
									<td><%=logdetails.getString("date") %></td>
									<td><%=GetInfoAbout.gettrainername(logdetails.getString("userid")) %></td>
									</tr>
									<%} %>
								</tbody>
							</table>
						</div>

					</div>
				</section>
			</div>
		</div>
	</section>
</section>

<%@include file="Common/Footer.jsp"%>

